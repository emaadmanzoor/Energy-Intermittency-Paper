library(tidyverse)
library(plyr)
library(gdxrrw)
library(ggplot2)
library(scales)
library(ggthemes)

setwd('C:/Users/saket/GitHub/BECCS-Case-Study/analysis/cge')

# Paths
igdx(gamsSysDir = "C:/GAMS/win64/25.1")
data_loc <- '../../data/cge/results.gdx'

# Folder to put graphs
fig_folder <- '../../documents/exhibits/cge/pgm/'

# Params
fig_scale  <- 1.1
fig_width  <- 7
fig_height <- 5

#--------------
## Load Data

# Data
data_Zpz    <- rgdx.param(data_loc, 'Res_Zpz')
data_Z      <- rgdx.param(data_loc, 'Res_Z')
data_pz     <- rgdx.param(data_loc, 'Res_pz')
data_co2    <- rgdx.param(data_loc, 'Res_co2')
data_tax    <- rgdx.param(data_loc, 'Res_tax')
data_ler    <- rgdx.param(data_loc, 'L_mult')
data_co2_rt <- rgdx.param(data_loc, 'co2_tax_rt')


#--------------
## Data Clean up

# Merge some data
data_merged <- merge(data_tax, data_Zpz, on = c('i', 't'))
data_merged <- merge(data_merged, data_pz, on = c('i', 't'))
data_merged <- merge(data_merged, data_Z, on = c('i', 't'))
data_merged <- merge(data_merged, data_co2, on = c('i', 't'))

# Clean column names
data_merged$i <- mapvalues(data_merged$i,
          from = c('ELC_BECCS', 'ELC_FF', 'ELC_RNW'),
          to = c('BECCS', 'Fossil Fuels', 'Renewables'))

data_merged$tax_revenue <- data_merged$Res_tax * data_merged$Res_Zpz

data_merged <- ddply(data_merged, .(i, t))

data_merged <- ddply(data_merged, .(i), transform,
                     tax_rev_chg = (tax_revenue - tax_revenue[1]),
                     tax_rev_chg_rel = (tax_revenue/tax_revenue[1]) - 1,
                     zpz_pct_chg = Res_Zpz/Res_Zpz[1] - 1,
                     zpz_chg = Res_Zpz - Res_Zpz[1]
                     )

data_beccs <- filter(data_merged, i == 'BECCS')
data_ff    <- filter(data_merged, i == 'Fossil Fuels')
data_rnw   <- filter(data_merged, i == 'Renewables')

# -----------------
## Plots

pdf(file = paste0(fig_folder, 'graphs.pdf'),
    paper = 'USr', width = 8, height = 5)

ggtheme <- theme_gray() + theme(plot.title = element_text(hjust = 0.5))



# Learning Rate

ggplot(data = data_ler,
       aes(x = t, y = L_Mult, group = 1)) +
  geom_line(color = '#FF6600', size = 2) +
  scale_y_continuous(labels = percent, breaks = seq(1,1.4,by =0.1)) +
  labs(title = 'Learning Parameter')  +
  xlab('Time (years)') + ylab('Input-Use Efficiency') +
  ggtheme
ggsave(paste0(fig_folder, 'learning_rate.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# Carbon Tax

data_co2_rt$co2_tax_rt <- data_co2_rt$co2_tax_rt*1e6
#data_co2_rt[nrow(data_co2_rt) + 1,] <- list(1, 0)

ggplot(data = data_co2_rt,
       aes(x = t, y = co2_tax_rt, group = 1)) +
  geom_line(color = 'blueviolet', size = 2) +
  scale_y_continuous(breaks = seq(0,220, by=25)) +
  labs(title = 'Carbon Tax Rate Over Time')  +
  xlab('Time (years)') + ylab('Carbon Tax ($/ton)') +
  ggtheme
ggsave(paste0(fig_folder, 'co2_tax_rate.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# Change in Tax Rates

ggplot(data = filter(data_merged, i %in% c('Fossil Fuels', 'BECCS', 'Renewables')),
       aes(x = t, y = Res_tax, group = i, fill = i)) +
  geom_line(aes(color = i), size = 2) +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Production Tax Rates on Electricity Sector over Time',
       color = 'Sector')  +
  xlab('Time (years)') + ylab('Tax Rate') +
  ggtheme
ggsave(paste0(fig_folder, 'tax_rates.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# Dollar Output Pct Change

ggplot(data = filter(data_merged,
                     i %in% c('Fossil Fuels', 'BECCS', 'Renewables')),
       aes(x = t, y = zpz_pct_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  scale_y_continuous(labels = percent, limits = c(-0.5, 1))    +
  labs(title = 'Cumulative Percent Change in Output (Mil $) over Time',
       fill = 'Sector')  +
  xlab('Time (years)') + ylab('Percent Change in Output (Mil $)') +
  ggtheme
ggsave(paste0(fig_folder, 'output_pct_chg.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


## Dollar Output Change

ggplot(data = filter(data_merged,
                     i %in% c('Fossil Fuels', 'BECCS', 'Renewables')),
       aes(x = t, y = zpz_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  labs(title = 'Change in Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Change in Output (Mil $)') +
  ggtheme
ggsave(paste0(fig_folder, 'output_chg.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# beccs
data_temp <- data_beccs
data_temp$Res_Zpz <- data_beccs$Res_Zpz

ggplot(data = filter(data_temp),
       aes(x = t, y = Res_Zpz, fill = i)) +
  geom_bar(stat = 'identity') +
  labs(title = 'Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (Mil $)') +
  scale_fill_manual(labels = c("BECCS"), values = c("dodgerblue")) +
  ggtheme

# fossil fuels - trick to get bar plot to start from 8000
data_temp <- data_ff
data_temp$Res_Zpz <- data_ff$Res_Zpz

ggplot(data = filter(data_temp),
       aes(x = t, y = Res_Zpz, fill = i)) +
  geom_bar(stat = 'identity') +
  #scale_y_continuous(labels = (seq(0,400,100) + 8000)) +
  labs(title = 'Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (Mil $)') +
  scale_fill_manual(labels = c("Fossil Fuels"), values = c("coral1")) +
  ggtheme

# renewables - trick to get bar plot to start from 31e3
data_temp <- data_rnw
data_temp$Res_Zpz <- data_rnw$Res_Zpz

ggplot(data = filter(data_temp),
       aes(x = t, y = Res_Zpz, fill = i)) +
  geom_bar(stat = 'identity') +
  #scale_y_continuous(labels = (seq(0,400,100) + 31e3)) +
  labs(title = 'Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (Mil $)') +
  scale_fill_manual(labels = c("Renewables"), values = c("springgreen3")) +
  ggtheme


# Tax Revenue Change

ggplot(data = filter(data_merged, i %in% c('Fossil Fuels', 'BECCS', 'Renewables')),
       aes(x = t, y = tax_rev_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  labs(title = 'Change in Tax Revenue over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Change in Tax Revenue (Mil $)') +
  ggtheme
ggsave(paste0(fig_folder, 'tax_rev_chg.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# Tax Revenue Percent Change

ggplot(data = filter(data_merged, i %in% c('Fossil Fuels', 'BECCS', 'Renewables')),
       aes(x = t, y = tax_rev_chg_rel, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Percent Change in Tax Revenue over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Percent Change in Tax Revenue') +
  ggtheme
ggsave(paste0(fig_folder, 'tax_rev_pct_chg.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# Price of BECCS

data_beccs$pct <- (data_beccs$Res_pz / filter(data_beccs, t == 0)$Res_pz - 1)

ggplot(data = data_beccs,
       aes(x = t, y = pct, group = i)) +
  geom_line(color = "#009E73", size = 2)  +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Change in Cost of BECCS Electricity')  +
  xlab('Time (years)') + ylab('Cumulative Percent Change in Price') +
  ggtheme
ggsave(paste0(fig_folder, 'beccs_cost.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


# Electricity Sector Output

ggplot(data = filter(data_merged, i %in% c('Fossil Fuels', 'BECCS', 'Renewables')),
       aes(x = t, y = Res_Zpz, fill = i, group = i, ymax = 45e3)) +
  geom_bar(stat = 'identity', aes(color = i=='ELC_BECCS'))  +
  scale_color_manual(values = c(NA, 'black'), guide=F) +
  labs(title = 'Output of Electricity Sectors', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (million $)') +
  ggtheme


# Change in Co2

data_co2$pct <- (data_co2$Res_co2 / filter(data_co2, t == 0)$Res_co2 - 1)

ggplot(data = data_co2,
       aes(x = t, y = pct, group = 1)) +
  geom_line(color = 'dodgerblue', size = 2) +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Cumulative Percent Change in Electricity Sector CO2 Emissions over Time')  +
  xlab('Time (years)') + ylab('Cumulative Percent Change') +
  ggtheme
ggsave(paste0(fig_folder, 'co2_pct_chg.png'), scale = fig_scale,
       width = fig_width, height = fig_height)


dev.off()
