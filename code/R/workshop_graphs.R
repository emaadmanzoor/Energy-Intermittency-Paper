library(tidyverse)
library(ggplot2)
library(scales)
library(grid)
library(ggthemes)
library(readxl)
library(ggmap)
library(maps)
library(mapdata)
library(tools)

### Functions

manual_theme <- theme_minimal() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.text = element_blank(),
          axis.title = element_blank(),
          legend.key.size = unit(0.5, "cm"), legend.key.width = unit(2, "cm"),
          legend.direction = "horizontal", legend.position = "bottom",
          plot.title = element_text(hjust = 0.5))


# Params

plot_width  <- 8
plot_height <- 5

### Import Data

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
folder <- '../../data/'

plant_data <- read_excel(paste0(folder, 'EIA/plantlocations_04_2019.xlsx'))
map_data_state  <- map_data("state")
map_data_county <- map_data("county")

## Clean up data

# Ignore Alaska and Hawaii
plant_data <- filter(plant_data,
                     `Plant State` != 'AK',
                     `Plant State` != 'HI')
# Rename col
plant_data$Capacity <- plant_data$`Nameplate Capacity (MW)`

## Plot

rel_renew_plot <- ggplot() +
    geom_polygon(data = map_data_state, color = 'grey70', fill = 'white',
                 aes(x = long, y = lat, group = group)) +
    geom_point(data = filter(
        plant_data, grepl('Geo', Technology) | grepl('Hydro', Technology)),
               aes(x = Longitude, y = Latitude, size = Capacity,
                   color = Technology),
               alpha = 0.5,
               stroke = 0, shape = 16) +
    guides(color = guide_legend(override.aes = list(size=5))) +
    manual_theme +
    theme(legend.box = "vertical",
          legend.margin = margin(-0.25,0,0,0, unit="cm"),
          legend.background = element_rect(fill = '#FAFAFA', color = '#FAFAFA'),
          panel.background = element_rect(fill = '#FAFAFA', color = '#FAFAFA'),
          plot.background = element_rect(fill = '#FAFAFA', color = '#FAFAFA'))

print(rel_renew_plot)
ggsave('../../documents/exhibits/rel_renew_map.pdf',
       width = plot_width, height = plot_height, dpi = 600)
