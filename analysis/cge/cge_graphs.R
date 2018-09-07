library(tidyverse)
library(gdxrrw)
library(ggplot2)
library(scales)
library(ggthemes)


# Paths
igdx(gamsSysDir = "C:/GAMS/win64/25.1")
data_loc <- '../../data/cge/results.gdx'


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

# Merge some data
data_merged <- merge(data_tax, data_Zpz, on = c('i', 't'))
data_merged <- merge(data_merged, data_pz, on = c('i', 't'))
data_merged <- merge(data_merged, data_Z, on = c('i', 't'))
data_merged <- merge(data_merged, data_co2, on = c('i', 't'))


# -----------------
## Plots

pdf(file='graphs.pdf', paper='USr', width = 8, height = 5)

ggtheme <- theme_gray() + theme(plot.title = element_text(hjust = 0.5))

data_beccs <- filter(data_merged, i == 'ELC_BECCS')
data_ff    <- filter(data_merged, i == 'ELC_FF')
data_rnw   <- filter(data_merged, i == 'ELC_RNW')


# Learning Rate

ggplot(data = data_ler,
       aes(x = t, y = L_Mult, group = 1)) +
  geom_line(color = '#FF6600', size = 2) +
  scale_y_continuous(labels = percent) +
  labs(title = 'Learning Parameter')  +
  xlab('Time (years)') + ylab('Input-Use Efficiency') +
  ggtheme


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


# Change in Tax Rates

ggplot(data = filter(data_merged, i %in% c('ELC_BECCS', 'ELC_FF', 'ELC_RNW')),
       aes(x = t, y = Res_tax, group = i, fill = i)) +
  geom_line(aes(color = i), size = 2) +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Production Tax Rates on Electricity Sector over Time',
       color = 'Sector')  +
  xlab('Time (years)') + ylab('Tax Rate') +
  ggtheme +
  scale_color_discrete(labels = c('Fossil Fuels', 'Renewables', 'BECCS'))


# Dollar Output Pct Change

data_merged <- data_merged %>%
  group_by(i) %>%
  mutate(zpz_pct_chg = Res_Zpz/Res_Zpz[t==0][1L] - 1)

ggplot(data = filter(data_merged,
                     i %in% c('ELC_BECCS', 'ELC_FF', 'ELC_RNW')),
       aes(x = t, y = zpz_pct_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Percent Change in Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Percent Change in Output (Mil $)') +
  scale_fill_discrete(labels = c('Fossil Fuels', 'Renewables', 'BECCS')) +
  ggtheme


## Dollar Output Change

data_merged <- data_merged %>%
  group_by(i) %>%
  mutate(zpz_chg = Res_Zpz - Res_Zpz[t==0][1L])

ggplot(data = filter(data_merged,
                     i %in% c('ELC_BECCS', 'ELC_FF', 'ELC_RNW')),
       aes(x = t, y = zpz_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  labs(title = 'Change in Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Change in Output (Mil $)') +
  scale_fill_discrete(labels = c('Fossil Fuels', 'Renewables', 'BECCS')) +
  ggtheme


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
data_temp$Res_Zpz <- data_ff$Res_Zpz - 8000

ggplot(data = filter(data_temp),
       aes(x = t, y = Res_Zpz, fill = i)) +
  geom_bar(stat = 'identity') +
  scale_y_continuous(labels = (seq(0,500,100) + 8000)) +
  labs(title = 'Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (Mil $)') +
  scale_fill_manual(labels = c("Fossil Fuels"), values = c("coral1")) +
  ggtheme

# renewables - trick to get bar plot to start from 31e3
data_temp <- data_rnw
data_temp$Res_Zpz <- data_rnw$Res_Zpz - 31e3

ggplot(data = filter(data_temp),
       aes(x = t, y = Res_Zpz, fill = i)) +
  geom_bar(stat = 'identity') +
  scale_y_continuous(labels = (seq(0,400,100) + 31e3)) +
  labs(title = 'Output (Mil $) over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (Mil $)') +
  scale_fill_manual(labels = c("Renewables"), values = c("springgreen3")) +
  ggtheme


# Tax Revenue Percent Change

data_merged$tax_revenue <- data_merged$Res_tax * data_merged$Res_Zpz
data_merged <- data_merged %>%
  group_by(i) %>%
  mutate(tax_rev_chg = tax_revenue - tax_revenue[t==0][1L])


ggplot(data = filter(data_merged, i %in% c('ELC_BECCS', 'ELC_FF', 'ELC_RNW')),
       aes(x = t, y = tax_rev_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Change in Tax Revenue over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Percent Change in Tax Revenue') +
  scale_fill_discrete(labels = c('Fossil Fuels', 'Renewables', 'BECCS')) +
  ggtheme


# Tax Revenue Change

data_merged$tax_revenue <- data_merged$Res_tax * data_merged$Res_Zpz
data_merged <- data_merged %>%
  group_by(i) %>%
  mutate(tax_rev_pct_chg = tax_revenue/tax_revenue[t==0][1L] - 1)


ggplot(data = filter(data_merged, i %in% c('ELC_BECCS', 'ELC_FF', 'ELC_RNW')),
       aes(x = t, y = tax_rev_pct_chg, group = i, fill = i)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Percent Change in Tax Revenue over Time', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Percent Change in Tax Revenue') +
  scale_fill_discrete(labels = c('Fossil Fuels', 'Renewables', 'BECCS')) +
  ggtheme


# Price of BECCS

data_beccs$pct <- (data_beccs$Res_pz / filter(data_beccs, t == 0)$Res_pz - 1)

ggplot(data = data_beccs,
       aes(x = t, y = pct, group = i)) +
  geom_line(color = "#009E73", size = 2)  +
  scale_y_continuous(labels = percent)    +
  labs(title = 'Change in Price of BECCS Electricity')  +
  xlab('Time (years)') + ylab('Cumulative Percent Change in Price') +
  ggtheme


# Electricity Sector Output

ggplot(data = filter(data_merged, i %in% c('ELC_BECCS', 'ELC_FF', 'ELC_RNW')),
       aes(x = t, y = Res_Zpz, fill = i, group = i, ymax = 45e3)) +
  geom_bar(stat = 'identity', aes(color = i=='ELC_BECCS'))  +
  scale_color_manual(values = c(NA, 'black'), guide=F) +
  labs(title = 'Output of Electricity Sectors', fill = 'Sector')  +
  xlab('Time (years)') + ylab('Output (million $)') +
  ggtheme + scale_y_continuous(limits = c(0,42500), expand = c(0,0)) +
  scale_fill_discrete(labels = c('Fossil Fuels', 'Renewables', 'BECCS'))


# Change in Co2

data_co2$pct <- (data_co2$Res_co2 / filter(data_co2, t == 0)$Res_co2 - 1)

ggplot(data = data_co2,
       aes(x = t, y = pct, group = 1)) +
  geom_line(color = 'dodgerblue', size = 2) +
  scale_y_continuous(labels = percent, breaks = seq(0,-0.4,length=9)) +
  labs(title = 'Change in Electricity Sector CO2 Emissions over Time')  +
  xlab('Time (years)') + ylab('Cumulative Percent Change') +
  ggtheme

dev.off()
