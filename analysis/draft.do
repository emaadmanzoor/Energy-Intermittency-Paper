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

egen mean_lnr = mean(log_nsea_rel), by(statefips)
gen log_nsea_rel_dmd = log_nsea_rel - mean_lnr

nl (log_nsea_rel = ({sigma=1})*log( (sin({b1=1}*month + {b2=1})) / (sin({b1}*1 + {b2})) + {c0=1.25}) -{sigma}*log(epa_rel))

nl (log_nsea_rel_dmd = ({sigma=1})*log( (sin({b1=1}*month + {b2=1})) / (sin({b1}*1 + {b2})) + {c0=1.25}) -{sigma}*log(epa_rel))

// gen temp = sin(0.86*(month) + 1.5)*0.1259 + 0.9706
//
// nl (nsea_rel = (((sin({b1=1}*month + {b2=1})) / (sin({b1}*1 + {b2})))^(sigma=1})*(epa_rel^(sigma=1}) + {c0=1})
