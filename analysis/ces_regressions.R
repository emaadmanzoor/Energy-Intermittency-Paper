library(tidyverse)
library(ggplot2)
library(AER)
library(stargazer)
library(commarobust)
library(ivpack)
library(sandwich)
library(plm)

## Import DAta

# Set working directory to script location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
reg_data <- read_csv('../data/processed/ces_monthly.csv')
reg_data$state <- factor(reg_data$state_1)

# Adjust degree day scale
reg_data$CDD_1 = reg_data$CDD_1/1000
reg_data$CDD_2 = reg_data$CDD_2/1000
reg_data$HDD_1 = reg_data$HDD_1/1000
reg_data$HDD_2 = reg_data$HDD_2/1000

## Linear Models

# Regressions

reg_lm_1   = lm(paste0('ln_load_rel ~ ln_price_rel'),
                data = reg_data)

reg_lm_2   = lm(paste0('ln_load_rel ~ (CDD_1)',
                       ' + (CDD_2) + (HDD_1) + (HDD_2)',
                       ' + ln_price_rel'),
                data = reg_data)

reg_lm_3   = lm(paste0('ln_load_rel ~ time_diff + (CDD_1)',
                       ' + (CDD_2) + (HDD_1) + (HDD_2)',
                       ' + ln_price_rel'),
                data = reg_data)

reg_plm_1  = plm(as.formula(paste0('ln_load_rel ~ ln_price_rel')),
                 index = 'state', model = 'within', data = reg_data)

reg_plm_2  = plm(as.formula(paste0('ln_load_rel ~ ln_price_rel + (CDD_1)',
                                   ' + (CDD_2) + (HDD_1) + (HDD_2)')),
                 index = 'state', model = 'within', data = reg_data)

reg_plm_3  = plm(as.formula(paste0('ln_load_rel ~ ln_price_rel + (CDD_1)',
                                   ' + (CDD_2) + (HDD_1)',
                                   ' + (HDD_2) + time_diff')),
                 index = 'state', model = 'within', data = reg_data)

# Stargazer

fits       = list(reg_lm_1, reg_lm_2, reg_lm_3,
                  reg_plm_1, reg_plm_2, reg_plm_3)

robust_ses = lapply(fits, function(x) {coeftest(x, vcovHC)[,2]})

robust_ps = lapply(fits, function(x) {coeftest(x, vcovHC)[,4]})

extra_lines = list(
    c('State FEs', ' ', ' ', ' ', 'Yes', 'Yes', 'Yes')
)


stargazer(fits,
          type = 'latex',
          covariate.labels =  c('Delta_{t,s}', 'CDD_t', 'CDD_s',
                             'HDD_t', 'HDD_s', 'ln (P_{t,i} / P_{s,i})'),
          dep.var.labels.include = FALSE,
          star.cutoffs = c(0.05, 0.01, 0.001),
          se = robust_ses,
          p  = robust_ps,
          add.lines = extra_lines,
          column.separate = c(3, 3),
          model.names = FALSE,
          omit.stat=c("ser"))


## IV Models

# Regressions

reg_iv_1  = ivreg(as.formula(paste0('ln_load_rel ~ ln_price_rel ',
                                  '| . -ln_price_rel + ln_coal_rel')),
                data = reg_data)

reg_iv_2  = ivreg(as.formula(paste0('ln_load_rel ~ (CDD_1) + (CDD_2) + (HDD_1)',
                                  ' + (HDD_2) + ln_price_rel ',
                                  ' | . -ln_price_rel + ln_coal_rel')),
                data = reg_data)

reg_iv_3  = ivreg(as.formula(paste0('ln_load_rel ~ time_diff + (CDD_1)',
                                  ' + (CDD_2) + (HDD_1) + (HDD_2) ',
                                  ' + ln_price_rel | . -ln_price_rel ',
                                  ' + ln_coal_rel')),
                data = reg_data)

reg_data_dmd <- reg_data %>%
    group_by(state) %>%
    mutate_at(c('ln_price_rel', 'ln_load_rel', 'time_diff',
                'CDD_1', 'CDD_2', 'HDD_1', 'HDD_2', 'ln_coal_rel'),
              funs(. - mean(.)))

reg_fiv_1  = ivreg(as.formula(paste0('ln_load_rel ~  ~ -1 + ln_price_rel ',
                                    '| . -ln_price_rel + ln_coal_rel')),
                  data = reg_data_dmd)

reg_fiv_2  = ivreg(as.formula(paste0('ln_load_rel ~ (CDD_1) + (CDD_2) + (HDD_1)',
                                    ' + (HDD_2) + ln_price_rel  ~ -1 ',
                                    ' | . -ln_price_rel + ln_coal_rel')),
                  data = reg_data_dmd)

reg_fiv_3  = ivreg(as.formula(paste0('ln_load_rel ~ -1 + time_diff + (CDD_1)',
                                    ' + (CDD_2) + (HDD_1) + (HDD_2) ',
                                    ' + ln_price_rel | . -ln_price_rel ',
                                    ' + ln_coal_rel')),
                  data = reg_data_dmd)



# Stargazer

fits       = list(reg_iv_1,  reg_iv_2,  reg_iv_3,
                  reg_fiv_1,  reg_fiv_2, reg_fiv_3)

robust_ses = lapply(fits, function(x) {coeftest(x, vcovHC)[,2]})

robust_ps = lapply(fits, function(x) {coeftest(x, vcovHC)[,4]})

extra_lines = list(
    c('State FEs', ' ', ' ', ' ', 'Yes', 'Yes', 'Yes')
)

stargazer(fits,
          type = 'latex',
          covariate.labels =  c('Delta_{t,s}', 'CDD_t', 'CDD_s',
                                'HDD_t', 'HDD_s', 'ln (P_{t,i} / P_{s,i})'),
          dep.var.labels.include = FALSE,
          star.cutoffs = c(0.05, 0.01, 0.001),
          se = robust_ses,
          p  = robust_ps,
          add.lines = extra_lines,
          column.separate = c(3, 3),
          model.names = FALSE,
          omit.stat=c("ser"))



