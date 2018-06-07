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
reg3 (ln_cfg_coalng_diff = ln_avg_cost_ngcoal_diff) ///
	(ln_cfg_coaloil_diff = ln_avg_cost_oilcoal_diff) ///
	, constraint(1)

constraint define 2 ln_avg_cost_ngcoal_diff = ln_avg_cost_ngoil_diff
reg3 (ln_cfg_coalng_diff = ln_avg_cost_ngcoal_diff) ///
	(ln_cfg_oilng_diff = ln_avg_cost_ngoil_diff) ///
	, constraint(2)
	
constraint define 3 ln_avg_cost_oilcoal_diff = ln_avg_cost_ngoil_diff
reg3 (ln_cfg_coaloil_diff = ln_avg_cost_oilcoal_diff) ///
	(ln_cfg_oilng_diff = ln_avg_cost_ngoil_diff) ///
	, constraint(3)

// Graphs of Coal - Nat Gas
twoway (lfitci ln_cfg_coalng_diff ln_avg_cost_ngcoal_diff, fcolor(%10)) ///
(scatter ln_cfg_coalng_diff ln_avg_cost_ngcoal_diff if !missing(ln_avg_cost_ngcoal_diff)///
 & !missing(ln_cfg_coalng_diff), mcolor(navy%90) msize(small)),///
 ytitle(Log(Coal Input / Natural Gas Input)) ytitle(, size(small))///
 xtitle(Log(Natural Gas Price / Coal Price)) xtitle(, size(small))///
 by(, title(Coal versus Natural Gas) subtitle(Difference in Log Inputs///
 versus Difference in Log Prices) note(., color(%0))) ///
 legend(order(1 "95% CL" 2 "Fitted Values" 3 "Log(Coal Price / Natural Gas Price)")) ///
 xsize(16) ysize(9) by(coalng_group) subtitle(, size(small))
