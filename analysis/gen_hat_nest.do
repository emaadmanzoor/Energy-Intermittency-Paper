clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\gen_cap_reg_data.csv

/// Variables
// Bundle Generation Vars
gen geo_hydro_bio_gen = geo_hydro_gen + biomass_gen
gen wind_solar_gen    = wind_gen + solar_gen
gen renew_gen         = nuclear_gen + geo_hydro_bio_gen + wind_solar_gen
gen all_gen           = renew_gen + fossil_gen

/// Regressions

// Bio Geo Hydro
nl (geo_hydro_bio_gen = {c=1} + (exp({ln_alpha_biomass=0})*(biomass_gen_hat^{phi}) + exp({ln_alpha_geothermal=0})*(geothermal_gen_hat^{phi}) + exp({ln_alpha_hydro=0})*(hydro_gen_hat^{phi}))^(1/{phi=1})) if (!missing(biomass_gen_hat) & !missing(geothermal_gen_hat) & !missing(hydro_gen_hat))

// Wind Solar
nl (wind_solar_gen = {c=1} + (exp({ln_alpha_wind=1})*(wind_gen_hat^{phi}) + exp({ln_alpha_solar=1})*(solar_gen_hat^{phi}))^(1/{phi=1})) if (!missing(solar_gen_hat) & !missing(wind_gen_hat))
