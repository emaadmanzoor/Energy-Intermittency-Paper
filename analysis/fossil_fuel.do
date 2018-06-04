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
constraint define 2 ln_avg_cost_ngcoal_diff = ln_avg_cost_ngoil_diff
reg3 (ln_cfg_coalng_diff = ln_avg_cost_ngcoal_diff) ///
	(ln_cfg_coaloil_diff = ln_avg_cost_oilcoal_diff) ///
	(ln_cfg_oilng_diff = ln_avg_cost_ngoil_diff) ///
	, constraint(1 2)

//
// // View results
// esttab coal_natgas
// esttab coal_oil
// esttab oil_natgas
