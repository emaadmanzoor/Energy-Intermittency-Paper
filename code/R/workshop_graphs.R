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
ercot_data <- read_csv(paste0(folder, 'processed/ercot_load_solar.csv'))

## Clean up data

# Ignore Alaska and Hawaii
plant_data <- filter(plant_data,
                     `Plant State` != 'AK',
                     `Plant State` != 'HI')
# Rename col
plant_data$Capacity <- plant_data$`Nameplate Capacity (MW)`


## Plot

# Geo Hydro plants

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

# Ercot data

ggplot(data = ercot_data) +
    geom_line(aes(x = Hour, y = Load, color = 'Load'), size = 1) +
    geom_line(aes(x = Hour, y = SolarGen*50, color = 'SolarGen'), size = 1) +
    scale_y_continuous(expand = c(0, 100),
        sec.axis = sec_axis(~./50, name = "Solar Generation (MW)")) +
    scale_colour_manual(values = c("blue", "orange")) +
    expand_limits(x = 0, y = 0) +
    theme(legend.box = "vertical", legend.key.size = unit(0.5, "cm"),
          legend.key.width = unit(2, "cm"), legend.title = element_blank(),
          legend.direction = "horizontal", legend.position = "bottom",
          legend.margin = margin(-0.25,0,0,0, unit="cm"),
          legend.background = element_rect(fill = '#FAFAFA', color = '#FAFAFA'),
          panel.background = element_rect(fill = '#FAFAFA', color = '#FAFAFA'),
          plot.background = element_rect(fill = '#FAFAFA', color = '#FAFAFA'),
          axis.line.x.bottom = element_line(size = 0.5, colour = "grey50"),
          axis.line.y.left = element_line(size = 0.5, colour = "grey50"),
          panel.grid.major = element_line(color = 'grey90'))





