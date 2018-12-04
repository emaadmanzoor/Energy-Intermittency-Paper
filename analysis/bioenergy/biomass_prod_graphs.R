library(tidyverse)
library(readxl)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(tools)

setwd('C:/Users/saket/GitHub/BECCS-Case-Study/analysis/bioenergy/')
fig_folder <- '../../documents/exhibits/bioenergy/'

# import state map
map_data <- map_data("county")

# import bioenergy data
bioenergy_data <- read_csv('../../data/bioenergy/bioenergy_county_clean.csv')
fsprod_county_data <- read_csv('../../data/bioenergy/bioenergy_county_avgprod.csv')

# clean data
bioenergy_data <- filter(bioenergy_data, Year == 2016)
#bioenergy_data$ResourceType <- bioenergy_data$ResourceType

# get average production of each feedstock by state
fsprod_county_data <- bioenergy_data %>%
    group_by(State, County, ResourceType, Feedstock) %>%
    summarize(Production = mean(Production)) %>%
    ungroup


## This merged data does not plot well!

# merge map and bioenergy data
fsprod_county_data$Feedstock <- toTitleCase(fsprod_county_data$Feedstock)
fsprod_county_data$state <- tolower(fsprod_county_data$State)
fsprod_county_data$subregion <- fsprod_county_data$County
map_data$state           <- tolower(map_data$region)
merged_fs_data <- full_join(map_data, fsprod_county_data,
                        by = c('state', 'subregion'))

# get total resource type production
rtprod_county_data <- fsprod_county_data %>%
    group_by(State, County, ResourceType) %>%
    summarize(Production = sum(Production)) %>%
    ungroup
rtprod_county_data$state <- tolower(rtprod_county_data$State)
rtprod_county_data$subregion <- rtprod_county_data$County
merged_rt_data <- full_join(map_data, rtprod_county_data,
                        by = c('state', 'subregion'))

# get total production of every feedstock
totprod_county_data <- fsprod_county_data %>%
    group_by(State, County) %>%
    summarize(Production = sum(Production)) %>%
    ungroup
totprod_county_data$state <- tolower(totprod_county_data$State)
totprod_county_data$subregion <- totprod_county_data$County
merged_tot_data <- full_join(map_data, totprod_county_data,
                            by = c('state', 'subregion'))


# ----------------------------------------------------------------------------
## Graphs

manual_theme <- theme_minimal() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.text = element_blank(),
          axis.title = element_blank(),
          legend.key.size = unit(0.5, "cm"), legend.key.width = unit(2, "cm"),
          legend.direction = "horizontal", legend.position = "bottom",
          plot.title = element_text(hjust = 0.5))


feedstocks_unique <- unique(fsprod_county_data$Feedstock)

for (i in c(1:length(feedstocks_unique))) {

    # create temporary dataframe with relevant production data
    temp <- full_join(map_data, filter(fsprod_county_data,
                                       Feedstock == feedstocks_unique[i]),
                      by = c('state', 'subregion'))
    temp$Production <- replace_na(temp$Production, 0)

    temp_plot <- ggplot(data = temp) +
        geom_polygon(aes(x = long, y = lat, fill = Production/1e5,
                         group = group, color = Production)) +
        coord_fixed(1.3) +
        labs(title = paste0('2016 Production of ', feedstocks_unique[i]),
             fill = 'Production (millions of dt)') +
        scale_color_gradient(guide = 'none') +
        scale_fill_viridis_c(na.value = "gray95") +
        guides(fill = guide_colourbar(title.position = "top", title.hjust = .5,
                                      label.position = "bottom")) +
        manual_theme

    print(temp_plot)
    figure_name <- paste0('fig_fsprod_',
                          sapply(gsub(' ', '_', feedstocks_unique[i]), tolower),
                          '.pdf')
    ggsave(paste0(fig_folder, figure_name), width = 12, height = 10)

}

resourcetypes_unique <- unique(merged_rt_data$ResourceType)

for (i in c(1:length(resourcetypes_unique))) {

    # create temporary dataframe with relevant production data
    temp <- full_join(map_data, filter(rtprod_county_data,
                                       ResourceType == resourcetypes_unique[i]),
                      by = c('state', 'subregion'))
    temp$Production <- replace_na(temp$Production, 0)

    temp_plot <- ggplot(data = temp) +
        geom_polygon(aes(x = long, y = lat, fill = Production/1e5,
                         group = group, color = Production)) +
        coord_fixed(1.3) +
        labs(title = paste0('2016 Production of ', resourcetypes_unique[i]),
             fill = 'Production (millions of dt)') +
        scale_color_gradient(guide = 'none') +
        scale_fill_viridis_c(na.value = "gray95") +
        guides(fill = guide_colourbar(title.position = "top", title.hjust = .5,
                                      label.position = "bottom")) +
        manual_theme

    print(temp_plot)
    figure_name <- paste0('fig_rtprod_',
                          sapply(gsub(' ', '_', resourcetypes_unique[i]),
                                 tolower),
                          '.pdf')
    ggsave(paste0(fig_folder, figure_name), width = 12, height = 10)

}

## Total Production
# create temporary dataframe with relevant production data
temp <- full_join(map_data, filter(totprod_county_data),
                  by = c('state', 'subregion'))
temp$Production <- replace_na(temp$Production, 0)

temp_plot <- ggplot(data = temp) +
    geom_polygon(aes(x = long, y = lat, fill = Production/1e5,
                     group = group, color = Production)) +
    coord_fixed(1.3) +
    labs(title = paste0('2016 Production of All Biomass'),
         fill = 'Production (millions of dt)') +
    scale_color_gradient(guide = 'none') +
    scale_fill_viridis_c(na.value = "gray95") +
    guides(fill = guide_colourbar(title.position = "top", title.hjust = .5,
                                  label.position = "bottom")) +
    manual_theme

print(temp_plot)
figure_name <- paste0('fig_totprod.pdf')
ggsave(paste0(fig_folder, figure_name), width = 12, height = 10)


