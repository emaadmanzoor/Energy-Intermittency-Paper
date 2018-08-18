clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\merged_data.csv

xtset statefips

egen state_dummy = group(statefips)

bysort state_dummy: egen intg_1 = total(solar_avg_rad*elc_price_all)
bysort state_dummy: egen intg_2 = total(avg_wind_speed*elc_price_all)


gen ln_solar_cap = log(solar_capacity + 1)
gen ln_wind_cap = log(wind_capacity + 1)
gen ln_intg_1 = log(intg_1 + 1)
gen ln_intg_2 = log(intg_2 + 1)
gen ln_intg_div = ln_intg_1 - ln_intg_2

reg ln_solar_cap ln_intg_div ln_wind_cap
