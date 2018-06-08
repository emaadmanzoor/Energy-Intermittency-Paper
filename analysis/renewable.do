clear
import delimited D:\Users\saketh\Documents\GitHub\BECCS-Case-Study\data\processed\merged_data.csv

xtset statefips

/// Logs

// Quantities
gen ln_snge = log(1 + net_gen_elc_solar)
gen ln_wnge = log(1 + net_gen_elc_wind)
gen ln_cnge = log(1 + net_gen_elc_coal)
gen ln_ngnge = log(1 + net_gen_elc_natural_gas)
gen ln_hnge = log(1 + net_gen_elc_hydro)
gen ln_nnge = log(1 + net_gen_elc_nuclear)
gen ln_onge = log(1 + net_gen_elc_oil)
gen ln_gnge = log(1 + net_gen_elc_geothermal)
gen ln_bnge = log(1 + net_gen_elc_biomass)

gen ln_snga = log(1 + net_gen_all_solar)
gen ln_wnga = log(1 + net_gen_all_wind)
gen ln_cnga = log(1 + net_gen_all_coal)
gen ln_ngnga = log(1 + net_gen_all_natural_gas)
gen ln_hnga = log(1 + net_gen_all_hydro)
gen ln_nnga = log(1 + net_gen_all_nuclear)
gen ln_onga = log(1 + net_gen_all_oil)
gen ln_gnga = log(1 + net_gen_all_geothermal)
gen ln_bnga = log(1 + net_gen_all_biomass)

gen ln_net_gen_solarwind_diff = ln_snge - ln_wnge
gen ln_net_gen_solarhydro_diff = ln_snge - ln_hnge
gen ln_net_gen_solargeo_diff = ln_snge - ln_gnge
gen ln_net_gen_solarbio_diff = ln_snge - ln_bnge
gen ln_net_gen_windhydro_diff = ln_wnge - ln_hnge
gen ln_net_gen_windgeo_diff = ln_wnge - ln_gnge


// Prices
gen ln_epa = log(1 + elc_price_all)

gen ln_avgcost_solar = log(solar_tot_input_costs) - ln_snge
gen ln_avgcost_wind  = log(wind_tot_input_costs) - ln_wnge
gen ln_avgcost_hydro = log(hydro_tot_input_costs) - ln_hnge
gen ln_avgcost_geo   = log(geothermal_tot_input_costs) - ln_gnge
gen ln_avgcost_bio   = log(biomass_tot_input_costs) - ln_bnge

gen ln_avgcost_windsolar_diff = ln_avgcost_wind - ln_avgcost_solar
gen ln_avgcost_hydrosolar_diff = ln_avgcost_hydro - ln_avgcost_solar
gen ln_avgcost_geosolar_diff = ln_avgcost_geo - ln_avgcost_solar
gen ln_avgcost_biosolar_diff = ln_avgcost_bio - ln_avgcost_solar

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
	
est store all_elas

constraint define 1 ln_avgcost_windsolar_diff = ln_avgcost_hydrosolar_diff
constraint define 2 ln_avgcost_hydrosolar_diff = ln_avgcost_geosolar_diff
constraint define 3 ln_avgcost_geosolar_diff = ln_avgcost_biosolar_diff
reg3 (ln_net_gen_solarwind_diff = ln_avgcost_windsolar_diff i.statefips) ///
	(ln_net_gen_solarhydro_diff = ln_avgcost_hydrosolar_diff i.statefips) ///
	(ln_net_gen_solargeo_diff = ln_avgcost_geosolar_diff i.statefips) ///
	(ln_net_gen_solarbio_diff = ln_avgcost_biosolar_diff i.statefips) ///
	, constraint(1-3)

	
gen ln_solarwind_gen = log(net_gen_elc_solar + net_gen_elc_wind + 1)	


/// Print

esttab all_elas, se unstack scalars(r2 chi2) nomtitle nonumber



/// Scratch

gen ln_solarwind_value = log(1+ solar_tot_input_costs + wind_tot_input_costs)

nl ( (ln_solarwind_value) = log({theta}) + (exp({sigma})/(exp({sigma}) - 1))*log( exp({exp_alpha_solar})*(net_gen_elc_solar^((exp({sigma})-1)/exp({sigma}))) + exp({exp_alpha_wind})*(net_gen_elc_solar^((exp({sigma})-1)/exp({sigma}))) ) + {gamma_1}*fips_1 + {gamma_2}*fips_2 + {gamma_3}*fips_3 + {gamma_4}*fips_4 + {gamma_5}*fips_5 + {gamma_6}*fips_6 + {gamma_7}*fips_7 + {gamma_8}*fips_8 + {gamma_9}*fips_9 + {gamma_10}*fips_10 + {gamma_11}*fips_11 + {gamma_12}*fips_12 + {gamma_13}*fips_13 + {gamma_14}*fips_14 + {gamma_15}*fips_15 + {gamma_16}*fips_16 + {gamma_17}*fips_17 + {gamma_18}*fips_18 + {gamma_19}*fips_19 + {gamma_20}*fips_20 + {gamma_21}*fips_21 + {gamma_22}*fips_22 + {gamma_23}*fips_23 + {gamma_24}*fips_24 + {gamma_25}*fips_25 + {gamma_26}*fips_26 + {gamma_27}*fips_27 + {gamma_28}*fips_28 + {gamma_29}*fips_29 + {gamma_30}*fips_30 + {gamma_31}*fips_31 + {gamma_32}*fips_32 + {gamma_33}*fips_33 + {gamma_34}*fips_34 + {gamma_35}*fips_35 + {gamma_36}*fips_36 + {gamma_37}*fips_37 + {gamma_38}*fips_38 + {gamma_39}*fips_39 + {gamma_40}*fips_40 + {gamma_41}*fips_41 + {gamma_42}*fips_42 + {gamma_43}*fips_43 + {gamma_44}*fips_44 + {gamma_45}*fips_45 + {gamma_46}*fips_46 + {gamma_47}*fips_47  ) ///
 if !missing(net_gen_elc_solar) & !missing(net_gen_elc_solar) ///
 & net_gen_elc_solar > 0 & net_gen_elc_solar > 0, ///
 initial(theta 1 sigma 2 exp_alpha_solar 0.5 exp_alpha_wind 0.5)
 
 forvalues i = 1/100 {
    gen byte fips_`i' = (statefips == `i') 
}

