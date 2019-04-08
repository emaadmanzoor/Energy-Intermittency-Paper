library(tidyverse)
library(ggplot2)
library(AER)
library(stargazer)
library(commarobust)
library(ivpack)
library(sandwich)

reg_data <- read_csv('../data/processed/ces_monthly.csv')
reg_data$state <- factor(reg_data$state_1)

## Regressions

# Linear Models
reg_lm_1   = lm(paste0('ln_load_rel ~ ln_price_rel'),
                data = reg_data)

reg_lm_2   = lm(paste0('ln_load_rel ~ (CDD_1+1)',
                       ' + (CDD_2+1) + (HDD_1+1) + (HDD_2+1)',
                       ' + ln_price_rel'),
                data = reg_data)

reg_lm_3   = lm(paste0('ln_load_rel ~ time_diff + (CDD_1+1)',
                       ' + (CDD_2+1) + (HDD_1+1) + (HDD_2+1)',
                       ' + ln_price_rel'),
                data = reg_data)

reg_plm_1  = plm(as.formula(paste0('ln_load_rel ~ ln_price_rel')),
                 index = 'state', model = 'within', data = reg_data)

reg_plm_2  = plm(as.formula(paste0('ln_load_rel ~ ln_price_rel + (CDD_1)',
                                   ' + (CDD_2) + (HDD_1) + (HDD_2)')),
                 index = 'state', model = 'within', data = reg_data)

reg_plm_3  = plm(as.formula(paste0('ln_load_rel ~ ln_price_rel + (CDD_1+1)',
                                   ' + (CDD_2+1) + (HDD_1+1)',
                                   ' + (HDD_2+1) + time_diff')),
                 index = 'state', model = 'within', data = reg_data)

# IV Regressions

ivreg_1 <- ivreg(paste0('ln_load_rel ~ time_diff  + log(CDD_1+1)',
                      ' + log(CDD_2+1) + log(HDD_1+1) + log(HDD_2+1)',
                      ' + ln_price_rel | . - ln_price_rel + ln_coal_rel'),
               data = reg_data)

ivreg_2 <- ivreg(paste0('ln_load_rel ~  factor(state_1) + time_diff +',
                      ' + log(CDD_1+1)  + log(CDD_2+1) + log(HDD_1+1)',
                      ' + log(HDD_2+1) + ln_price_rel',
                      ' | . - ln_price_rel + ln_coal_rel'),
               data = reg_data)



## Stargazer

# OLS
fits       = list(reg_lm_1, reg_lm_2, reg_lm_3,
                  reg_plm_1, reg_plm_2, reg_plm_3)

robust_ses = list(coeftest(reg_lm_1,  vcovHC)[,2],
                  coeftest(reg_lm_2,  vcovHC)[,2],
                  coeftest(reg_lm_3,  vcovHC)[,2],
                  coeftest(reg_plm_1, vcovHC)[,2],
                  coeftest(reg_plm_2, vcovHC)[,2],
                  coeftest(reg_plm_3, vcovHC)[,2])

robust_ps  = list(coeftest(reg_lm_1,  vcovHC)[,4],
                  coeftest(reg_lm_2,  vcovHC)[,4],
                  coeftest(reg_lm_3,  vcovHC)[,4],
                  coeftest(reg_plm_1, vcovHC)[,4],
                  coeftest(reg_plm_2, vcovHC)[,4],
                  coeftest(reg_plm_3, vcovHC)[,4])

extra_lines = list(
    c('State FEs', ' ', ' ', ' ', 'Yes', 'Yes', 'Yes')
)

stargazer(fits,
          type = 'latex',
          dep.var.labels = c('test', 'test', 'test', 'test', 'test', 'test'),
          star.cutoffs = c(0.05, 0.01, 0.001),
          se = robust_ses,
          p  = robust_ps,
          add.lines = extra_lines,
          column.separate = c(3, 3),
          model.names = FALSE,
          omit.stat=c("ser"))

