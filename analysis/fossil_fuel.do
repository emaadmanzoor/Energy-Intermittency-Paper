clear
import delimited D:\Users\saketh\Documents\GitHub\BECCS-Case-Study\data\processed\merged_data.csv

xtset statefips month

// Quantities
gen ln_cfg_coal        = log(1 + con_for_gen_coal)
gen ln_cfg_natural_gas = log(1 + con_for_gen_natural_gas)
gen ln_cfg_oil         = log(1 + con_for_gen_oil)

gen ln_cfg_coalng_diff = ln_cfg_coal - ln_cfg_natural_gas
gen ln_cfg_coaloil_diff = ln_cfg_coal - ln_cfg_oil
gen ln_cfg_oilng_diff = ln_cfg_oil - ln_cfg_natural_gas

// Prices
gen ln_avg_cost_coal = log(1 + average_cost_coal)
gen ln_avg_cost_natural_gas = log(1 + average_cost_natural_gas)
gen ln_avg_cost_oil = log(1 + average_cost_oil)

gen ln_avg_cost_ngcoal_diff = ln_avg_cost_natural_gas - ln_avg_cost_coal
gen ln_avg_cost_oilcoal_diff = ln_avg_cost_oil - ln_avg_cost_coal
gen ln_avg_cost_ngoil_diff = ln_avg_cost_natural_gas - ln_avg_cost_oil


// Coal - Nat Gas
xtreg ln_cfg_coalng_diff ln_avg_cost_ngcoal_diff, re

est store re

xtreg ln_cfg_coalng_diff ln_avg_cost_ngcoal_diff, fe

est store fe

hausman fe re

if r(p) < 0.05 {
	est restore fe
}
else {
	est restore re
}

est store coal_natgas


// Coal - Oil
xtreg ln_cfg_coaloil_diff ln_avg_cost_oilcoal_diff, re

est store re

xtreg ln_cfg_coaloil_diff ln_avg_cost_oilcoal_diff, fe

est store fe

hausman fe re

if r(p) < 0.05 {
	est restore fe
}
else {
	est restore re
}

est store coal_oil


// Oil - Natural Gas
xtreg ln_cfg_oilng_diff ln_avg_cost_ngoil_diff, re

est store re

xtreg ln_cfg_oilng_diff ln_avg_cost_ngoil_diff, fe

est store fe

hausman fe re

if r(p) < 0.05 {
	est restore fe
}
else {
	est restore re
}

est store oil_natgas

constraint define 1 ln_avg_cost_ngcoal_diff = ln_avg_cost_oilcoal_diff
sureg (ln_cfg_coalng_diff = ln_avg_cost_ngcoal_diff i.statefips) ///
	(ln_cfg_coaloil_diff = ln_avg_cost_oilcoal_diff i.statefips) ///
	, constraint(1)

est store s1
	
constraint define 2 ln_avg_cost_ngcoal_diff = ln_avg_cost_ngoil_diff
sureg (ln_cfg_coalng_diff = ln_avg_cost_ngcoal_diff i.statefips) ///
	(ln_cfg_oilng_diff = ln_avg_cost_ngoil_diff i.statefips) ///
	, constraint(2)
	
est store s2
	
constraint define 3 ln_avg_cost_oilcoal_diff = ln_avg_cost_ngoil_diff
sureg (ln_cfg_coaloil_diff = ln_avg_cost_oilcoal_diff i.statefips) ///
	(ln_cfg_oilng_diff = ln_avg_cost_ngoil_diff i.statefips) ///
	, constraint(3)

est store s3

	
// Graphs of Coal - Nat Gas

// gen coalng_group = statename if !missing(ln_avg_cost_ngcoal_diff) & !missing(ln_cfg_coalng_diff)
// twoway (lfitci ln_cfg_coalng_diff ln_avg_cost_ngcoal_diff, fcolor(%10)) (scatter ln_cfg_coalng_diff ln_avg_cost_ngcoal_diff if !missing(ln_avg_cost_ngcoal_diff) & !missing(ln_cfg_coalng_diff), mcolor(navy%90) msize(small)), ytitle(Difference in Log Inputs) ytitle(, size(small)) yscale(range(0 5)) xtitle(Difference in Log Prices) xtitle(, size(small)) by(, title(Coal versus Natural Gas) subtitle(Difference in Log Inputs versus Difference in Log Prices) note(., color(%0))) legend(order(1 "95% CL" 2 "Fitted Values" 3 "Log(Natural Gas Price / Coal Price)")) xsize(16) ysize(9) by(coalng_group) subtitle(, size(small))
// graph export "D:\Users\saketh\Documents\GitHub\BECCS-Case-Study\documents\exhibits\coal_natgas_scatter.pdf", as(pdf) replace
//
//
// gen coaloil_group = statename if !missing(ln_cfg_coaloil_diff) & !missing(ln_avg_cost_oilcoal_diff)
// twoway (lfitci ln_cfg_coaloil_diff ln_avg_cost_oilcoal_diff, fcolor(%10)) (scatter ln_cfg_coaloil_diff ln_avg_cost_oilcoal_diff if !missing(ln_avg_cost_oilcoal_diff) & !missing(ln_cfg_coaloil_diff), mcolor(navy%90) msize(small)), ytitle(Difference in Log Inputs) ytitle(, size(small)) yscale(range(0 5)) xtitle(Difference in Log Prices) xtitle(, size(small)) by(, title(Coal versus Oil) subtitle(Difference in Log Inputs versus Difference in Log Prices) note(., color(%0))) legend(order(1 "95% CL" 2 "Fitted Values" 3 "Log(Oil Price / Coal Price)")) xsize(16) ysize(9) by(coaloil_group) subtitle(, size(small))
// graph export "D:\Users\saketh\Documents\GitHub\BECCS-Case-Study\documents\exhibits\coal_oil_scatter.pdf", as(pdf) replace
//
//
// gen oilng_group = statename if !missing(ln_cfg_oilng_diff) & !missing(ln_avg_cost_ngoil_diff)
// twoway (lfitci ln_cfg_oilng_diff ln_avg_cost_ngoil_diff, fcolor(%10)) (scatter ln_cfg_oilng_diff ln_avg_cost_ngoil_diff if !missing(ln_avg_cost_ngoil_diff) & !missing(ln_cfg_oilng_diff), mcolor(navy%90) msize(small)), ytitle(Difference in Log Inputs) ytitle(, size(small)) yscale(range(0 5)) xtitle(Difference in Log Prices) xtitle(, size(small)) by(, title(Oil versus Natural Gas) subtitle(Difference in Log Inputs versus Difference in Log Prices) note(., color(%0))) legend(order(1 "95% CL" 2 "Fitted Values" 3 "Log(Natural Gas Price / Oil Price)")) xsize(16) ysize(9) by(oilng_group) subtitle(, size(small))
// graph export "D:\Users\saketh\Documents\GitHub\BECCS-Case-Study\documents\exhibits\oil_natgas_scatter.pdf", as(pdf) replace

// relevant fip
 
forvalues i = 1/100 {
    gen byte fips_`i' = (statefips == `i') 
}


gen ln_all_nge = log(1+net_gen_elc_all)

// nl ( (ln_all_nge) = log({theta}) + (1/{phi})*log( exp({ln_alpha_coal})*(con_for_gen_coal^{phi}) + exp({ln_alpha_ng})*(con_for_gen_natural_gas^{phi}) + exp({ln_alpha_oil})*(con_for_gen_oil^{phi}))  + {gamma_1}*fips_1 + {gamma_2}*fips_2 + {gamma_3}*fips_3 + {gamma_4}*fips_4 + {gamma_5}*fips_5 + {gamma_6}*fips_6 + {gamma_7}*fips_7 + {gamma_8}*fips_8 + {gamma_9}*fips_9 + {gamma_10}*fips_10 + {gamma_11}*fips_11 + {gamma_12}*fips_12 + {gamma_13}*fips_13 + {gamma_14}*fips_14 + {gamma_15}*fips_15 + {gamma_16}*fips_16 + {gamma_17}*fips_17 + {gamma_18}*fips_18 + {gamma_19}*fips_19 + {gamma_20}*fips_20 + {gamma_21}*fips_21 + {gamma_22}*fips_22 + {gamma_23}*fips_23 + {gamma_24}*fips_24 + {gamma_25}*fips_25 + {gamma_26}*fips_26 + {gamma_27}*fips_27 + {gamma_28}*fips_28 + {gamma_29}*fips_29 + {gamma_30}*fips_30 + {gamma_31}*fips_31 + {gamma_32}*fips_32 + {gamma_33}*fips_33 + {gamma_34}*fips_34 + {gamma_35}*fips_35 + {gamma_36}*fips_36 + {gamma_37}*fips_37 + {gamma_38}*fips_38 + {gamma_39}*fips_39 + {gamma_40}*fips_40 + {gamma_41}*fips_41 + {gamma_42}*fips_42 + {gamma_43}*fips_43 + {gamma_44}*fips_44 + {gamma_45}*fips_45 + {gamma_46}*fips_46 + {gamma_47}*fips_47  ) ///
//  if !missing(con_for_gen_coal) & !missing(con_for_gen_natural_gas) & !missing(con_for_gen_oil) ///
//  & con_for_gen_coal > 0, ///
//  initial(theta 1 phi 2 ln_alpha_coal 0.23 ln_alpha_ng 0.2 ln_alpha_oil 0.2)
// 
//
// nl ( (ln_all_nge) = log({theta}) + (1/{phi})*log( exp({ln_alpha_coal})*(con_for_gen_coal^{phi}) + exp({ln_alpha_ng})*(con_for_gen_natural_gas^{phi}) )) /// + {gamma_1}*fips_1 + {gamma_2}*fips_2 + {gamma_3}*fips_3 + {gamma_4}*fips_4 + {gamma_5}*fips_5 + {gamma_6}*fips_6 + {gamma_7}*fips_7 + {gamma_8}*fips_8 + {gamma_9}*fips_9 + {gamma_10}*fips_10 + {gamma_11}*fips_11 + {gamma_12}*fips_12 + {gamma_13}*fips_13 + {gamma_14}*fips_14 + {gamma_15}*fips_15 + {gamma_16}*fips_16 + {gamma_17}*fips_17 + {gamma_18}*fips_18 + {gamma_19}*fips_19 + {gamma_20}*fips_20 + {gamma_21}*fips_21 + {gamma_22}*fips_22 + {gamma_23}*fips_23 + {gamma_24}*fips_24 + {gamma_25}*fips_25 + {gamma_26}*fips_26 + {gamma_27}*fips_27 + {gamma_28}*fips_28 + {gamma_29}*fips_29 + {gamma_30}*fips_30 + {gamma_31}*fips_31 + {gamma_32}*fips_32 + {gamma_33}*fips_33 + {gamma_34}*fips_34 + {gamma_35}*fips_35 + {gamma_36}*fips_36 + {gamma_37}*fips_37 + {gamma_38}*fips_38 + {gamma_39}*fips_39 + {gamma_40}*fips_40 + {gamma_41}*fips_41 + {gamma_42}*fips_42 + {gamma_43}*fips_43 + {gamma_44}*fips_44 + {gamma_45}*fips_45 + {gamma_46}*fips_46 + {gamma_47}*fips_47  ) ///
//  if !missing(con_for_gen_coal) & !missing(con_for_gen_natural_gas) & !missing(con_for_gen_oil) ///
//  & con_for_gen_coal > 0, ///
//  initial(theta 1 phi 1 ln_alpha_coal 0.5 ln_alpha_ng 0.5)
// 
// 
 
 
 /// Total cost approaches
 
 gen ln_tc_coal = ln_avg_cost_coal + ln_cfg_coal
 gen ln_tc_natgas = ln_avg_cost_natural_gas + ln_cfg_natural_gas
 
 gen ln_tc_natgascoal_diff = ln_tc_natgas - ln_tc_coal
 
 reg ln_cfg_coalng_diff ln_tc_natgascoal_diff i.statefips
 // sigma = 51
