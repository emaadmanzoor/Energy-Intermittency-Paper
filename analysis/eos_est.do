clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\esp_jan_eos_est.csv

// Generate variables
gen ln_edbj = log(elc_demand_by_jan)
gen ln_epbj = log(elc_price_by_jan)


reg elc_demand_by_jan elc_price_by_jan

nl (ln_edbj = {c=0} + (-{sigma=1})*(ln_epbj) + {sigma=1}*(sin((month_num-1)/11*2*3.14159 + {shift=10})) + (-{sigma=1})*sin({shift}))
