clear
import delimited D:\Users\saketh\Documents\GitHub\BECCS-Case-Study\data\processed\merged_data.csv


/// Logs

// Quantities
gen ln_snge = log(1 + net_gen_elc_solar)
gen ln_wnge = log(1 + net_gen_elc_wind)
gen ln_cnge = log(1 + net_gen_elc_coal)
gen ln_hnge = log(1 + net_gen_elc_hydro)
gen ln_nnge = log(1 + net_gen_elc_nuclear)
gen ln_onge = log(1 + net_gen_elc_oil)
gen ln_gnge = log(1 + net_gen_elc_geothermal)
gen ln_bnge = log(1 + net_gen_elc_biomass)

// Prices
gen ln_epa = log(1 + elc_price_all)

// Instruments
gen scap = land_area*solar_avg_rad

gen ln_cdd = log(1+cdd)
gen ln_hdd = log(1+hdd)
gen ln_pop = log(1+population)
gen ln_sar = log(1+solar_avg_rad)
gen ln_aws = log(1+avg_wind_speed)
gen ln_land_area = log(1+land_area)
gen ln_water_coastal_area = log(1+water_coastal_area)
gen ln_water_inland_area = log(1+water_inland_area)
gen ln_scap = log(1+scap)


gen t = month
gen t2 = month^2


/// Regressions

reg ln_pop ln_cdd ln_hdd ln_land_area ln_water_inland_area ln_water_coastal_area

reg3 (ln_snge = ln_epa ln_sar land_area) ///
	(ln_snge = ln_epa ln_pop ln_cdd ln_hdd) ///
	(ln_wnge = ln_epa avg_wind_speed land_area) ///
	(ln_wnge = ln_epa ln_cdd ln_hdd ln_pop) ///
	, endog(ln_epa)
