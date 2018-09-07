// clear
// import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\merged_data.csv
//
// xtset statefips
//
// egen state_dummy = group(statefips)
//
// bysort state_dummy: egen intg_1 = total(solar_avg_rad*elc_price_all)
// bysort state_dummy: egen intg_2 = total(avg_wind_speed*elc_price_all)
//
//
// gen ln_solar_cap = log(solar_capacity + 1)
// gen ln_wind_cap = log(wind_capacity + 1)
// gen ln_intg_1 = log(intg_1 + 1)
// gen ln_intg_2 = log(intg_2 + 1)
// gen ln_intg_div = ln_intg_1 - ln_intg_2
//
// reg ln_solar_cap ln_intg_div ln_wind_cap

clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\elasticity_data.csv

gen log_nsea_rel = log(nsea_rel)

nl (log_nsea_rel = ///
	(-{sigma=0.1})*log((sin({b0=1}+month*3.14/6)/sin({b0}+3.14/6))+2) ///
	+ {sigma}*log(epa_rel)), ///
	vce(robust)
	
gen log_alpha_rel = log((sin(0.496+month*3.14/6)/sin(0.496+3.14/6))+2)

