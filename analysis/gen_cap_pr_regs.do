clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\gen_cap_reg_data.csv

/// Regressions

// ln_all_sec_gen on gen
nl (ln_all_sec_gen = {c=2} + (exp({ln_alpha_solar=1})*(ln_solar_gen^{phi}) + exp({ln_alpha_wind=0})*(ln_wind_gen^{phi}) + exp({ln_alpha_geothermal=0})*(ln_geothermal_gen^{phi}) + exp({ln_alpha_biomass=0})*(ln_biomass_gen^{phi}) + exp({ln_alpha_nuclear=0})*(ln_nuclear_gen^{phi}) + exp({ln_alpha_hydro=0})*(ln_hydro_gen^{phi}) + exp({ln_alpha_fossil=0})*(ln_fossil_gen^{phi}))^(1/{phi=10})), hasconstant(c) nolog
est sto ln_all_sec_gen_gen

// ln_all_sec_gen on cap
nl (ln_all_sec_gen = {c=1} + (exp({ln_alpha_solar=0})*(ln_solar_cap^{phi}) + exp({ln_alpha_wind=0})*(ln_wind_cap^{phi}) + exp({ln_alpha_geothermal=0})*(ln_geothermal_cap^{phi}) + exp({ln_alpha_biomass=0})*(ln_biomass_cap^{phi}) + exp({ln_alpha_nuclear=0})*(ln_nuclear_cap^{phi}) + exp({ln_alpha_hydro=0})*(ln_hydro_cap^{phi}) + exp({ln_alpha_fossil=0})*(ln_fossil_cap^{phi}))^(1/{phi=1})), hasconstant(c) nolog
est sto ln_all_sec_gen_cap

// ln_all_sec_gen on gen_hat
nl (ln_all_sec_gen = {c=1} * (exp({ln_alpha_solar=0})*(ln_solar_gen_hat^{phi}) + exp({ln_alpha_wind=0})*(ln_wind_gen_hat^{phi}) + exp({ln_alpha_geothermal=0})*(ln_geothermal_gen_hat^{phi}) + exp({ln_alpha_biomass=0})*(ln_biomass_gen_hat^{phi}) + exp({ln_alpha_nuclear=0})*(ln_nuclear_gen_hat^{phi}) + exp({ln_alpha_hydro=0})*(ln_hydro_gen_hat^{phi}) + exp({ln_alpha_fossil=0})*(ln_fossil_gen_hat^{phi}))^(1/{phi=1})), hasconstant(c) nolog
est sto ln_all_sec_gen_gen_hat

// ln_all_sec_pr on gen
nl (ln_all_sec_pr = {c=1} + (exp({ln_alpha_solar=0})*(ln_solar_gen^{phi}) + exp({ln_alpha_wind=0})*(ln_wind_gen^{phi}) + exp({ln_alpha_geothermal=0})*(ln_geothermal_gen^{phi}) + exp({ln_alpha_biomass=0})*(ln_biomass_gen^{phi}) + exp({ln_alpha_nuclear=0})*(ln_nuclear_gen^{phi}) + exp({ln_alpha_hydro=0})*(ln_hydro_gen^{phi}) + exp({ln_alpha_fossil=0})*(ln_fossil_gen^{phi}))^(1/{phi=1})), hasconstant(c) nolog
est sto ln_all_sec_pr_gen

// ln_all_sec_pr on cap
nl (ln_all_sec_pr = {c=2} + (exp({ln_alpha_solar=0})*(ln_solar_cap^{phi}) + exp({ln_alpha_wind=0})*(ln_wind_cap^{phi}) + exp({ln_alpha_geothermal=1})*(ln_geothermal_cap^{phi}) + exp({ln_alpha_biomass=0})*(ln_biomass_cap^{phi}) + exp({ln_alpha_nuclear=0})*(ln_nuclear_cap^{phi}) + exp({ln_alpha_hydro=0})*(ln_hydro_cap^{phi}) + exp({ln_alpha_fossil=0})*(ln_fossil_cap^{phi}))^(1/{phi=1})), hasconstant(c) nolog
est sto ln_all_sec_pr_cap

// ln_all_sec_pr on gen_hat
nl (ln_all_sec_pr = {c=1} + (exp({ln_alpha_solar=0})*(ln_solar_gen_hat^{phi}) + exp({ln_alpha_wind=0})*(ln_wind_gen_hat^{phi}) + exp({ln_alpha_geothermal=0})*(ln_geothermal_gen_hat^{phi}) + exp({ln_alpha_biomass=0})*(ln_biomass_gen_hat^{phi}) + exp({ln_alpha_nuclear=0})*(ln_nuclear_gen_hat^{phi}) + exp({ln_alpha_hydro=0})*(ln_hydro_gen_hat^{phi}) + exp({ln_alpha_fossil=0})*(ln_fossil_gen_hat^{phi}))^(1/{phi=1})), hasconstant(c) nolog
est sto ln_all_sec_pr_gen_hat




