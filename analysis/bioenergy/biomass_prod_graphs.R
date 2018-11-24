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
states_map <- map_data("state")

# import bioenergy data
bioenergy_data <- read_excel('../../data/bioenergy/bioenergy_clean.xlsx')

# clean data
bioenergy_data <- filter(bioenergy_data, Year == 2016)
bioenergy_data$ResourceType <- bioenergy_data$`Resource Type`

# get average production of each feedstock by state
fsprod_state_data <- bioenergy_data %>%
    group_by(State, ResourceType, Feedstock) %>%
    summarize(Production = mean(Production)) %>%
    ungroup

# add zeros to states not producing each bioenergy
for (state in unique(fsprod_state_data$State)) {
    for (feedstock in unique(fsprod_state_data$Feedstock)) {
        if (nrow(filter(fsprod_state_data, Feedstock == feedstock,
                        State == state)) == 0) {
            fsprod_state_data <- add_row(fsprod_state_data,
              State = state, Feedstock = feedstock, Production = NA)

        }
    }
}

# merge map and bioenergy data
fsprod_state_data$Feedstock <- toTitleCase(fsprod_state_data$Feedstock)
fsprod_state_data$state <- tolower(fsprod_state_data$State)
states_map$state           <- tolower(states_map$region)
merged_fs_data <- merge(fsprod_state_data, states_map, by = 'state')

# get total resource type production
rtprod_state_data <- fsprod_state_data %>%
    group_by(State, ResourceType) %>%
    summarize(Production = sum(Production)) %>%
    ungroup %>% drop_na
rtprod_state_data$state <- tolower(rtprod_state_data$State)
merged_rt_data <- merge(rtprod_state_data, states_map, by = 'state')


# ----------------------------------------------------------------------------
## Graphs

manual_theme <- theme_minimal() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.text = element_blank(),
          axis.title = element_blank(),
          legend.key.size = unit(0.5, "cm"), legend.key.width = unit(2, "cm"),
          legend.direction = "horizontal", legend.position = "bottom",
          plot.title = element_text(hjust = 0.5))

feedstocks_unique <- unique(merged_fs_data$Feedstock)[1:3]

for (i in c(1:length(feedstocks_unique))) {

    temp_plot <- ggplot(data = filter(merged_fs_data,
                                      Feedstock == feedstocks_unique[i])) +
        geom_polygon(aes(x = long, y = lat, fill = Production/1e5,
                         group = group), color = "gray70", size = 0.1) +
        coord_fixed(1.3) +
        labs(title = paste0('2016 Production of ', feedstocks_unique[i]),
             fill = 'Production (millions of dt)') +
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

    temp_plot <- ggplot(data = filter(merged_rt_data,
                        ResourceType == resourcetypes_unique[i])) +
        geom_polygon(aes(x = long, y = lat, fill = Production/1e5,
                         group = group), color = "gray70", size = 0.1) +
        coord_fixed(1.3) +
        labs(title = paste0('2016 Production of ', resourcetypes_unique[i]),
             fill = 'Production (millions of dt)') +
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



