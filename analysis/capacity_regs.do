clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\capacity_reg_data.csv


//// Set Up Variables

/// Bundle renewable pairs 

gen bionuc = biomass + nuclear
gen geohyd = geo + hydro
gen solwin = solar + wind

/// Create logged variables

gen ln_wind        = log(wind + 1)
gen ln_solar       = log(solar + 1)
gen ln_biomass     = log(biomass + 1)
gen ln_nuclear     = log(nuclear + 1)
gen ln_geo         = log(geo + 1)
gen ln_hydro       = log(hydro + 1)
gen ln_bionuc      = log(bionuc + 1)
gen ln_geohyd      = log(geohyd + 1)
gen ln_solwin      = log(solwin + 1)
gen ln_renew       = log(renew + 1)
gen ln_fossil      = log(fossil + 1)
gen ln_all_sec_gen = log(all_sec_gen + 1)

/// Prodiuct of Logged Variables

gen ln_solar_solar      = ln_solar * ln_solar
gen ln_wind_wind        = ln_wind * ln_wind
gen ln_geo_geo          = ln_geo * ln_geo
gen ln_biomass_biomass  = ln_biomass * ln_biomass
gen ln_nuclear_nuclear  = ln_nuclear * ln_nuclear
gen ln_hydro_hydro      = ln_hydro * ln_hydro

gen ln_solar_wind       = ln_solar * ln_wind
gen ln_solar_geo        = ln_solar * ln_geo
gen ln_solar_biomass    = ln_solar * ln_biomass
gen ln_solar_nuclear    = ln_solar * ln_nuclear
gen ln_solar_hydro      = ln_solar * ln_hydro
gen ln_wind_geo         = ln_wind * ln_geo
gen ln_wind_biomass     = ln_wind * ln_biomass
gen ln_wind_nuclear     = ln_wind * ln_nuclear
gen ln_wind_hydro       = ln_wind * ln_hydro
gen ln_geo_biomass      = ln_geo * ln_biomass
gen ln_geo_nuclear      = ln_geo * ln_nuclear
gen ln_geo_hydro        = ln_geo * ln_hydro
gen ln_biomass_nuclear  = ln_biomass * ln_nuclear
gen ln_biomass_hydro    = ln_biomass * ln_hydro
gen ln_nuclear_hydro    = ln_nuclear * ln_hydro

gen ln_solwin_solwin = ln_solwin * ln_solwin
gen ln_geohyd_geohyd = ln_geohyd * ln_geohyd
gen ln_bionuc_bionuc = ln_bionuc * ln_bionuc

gen ln_solwin_geohyd    = ln_solwin * ln_geohyd 
gen ln_geohyd_bionuc    = ln_geohyd * ln_bionuc
gen ln_bionuc_solwin    = ln_bionuc * ln_solwin


/// Differenced Logged Pairs Squared

gen g_solar_wind       = (ln_solar - ln_wind)^2
gen g_solar_geo        = (ln_solar - ln_geo)^2
gen g_solar_biomass    = (ln_solar - ln_biomass)^2
gen g_solar_nuclear    = (ln_solar - ln_nuclear)^2
gen g_solar_hydro      = (ln_solar - ln_hydro)^2
gen g_wind_geo         = (ln_wind - ln_geo)^2
gen g_wind_biomass     = (ln_wind - ln_biomass)^2
gen g_wind_nuclear     = (ln_wind - ln_nuclear)^2
gen g_wind_hydro       = (ln_wind - ln_hydro)^2
gen g_geo_biomass      = (ln_geo - ln_biomass)^2
gen g_geo_nuclear      = (ln_geo - ln_nuclear)^2
gen g_geo_hydro        = (ln_geo - ln_hydro)^2
gen g_nuclear_biomass  = (ln_nuclear - ln_biomass)^2
gen g_biomass_hydro    = (ln_biomass - ln_hydro)^2
gen g_nuclear_hydro    = (ln_nuclear - ln_hydro)^2
gen g_bionuc_geohyd    = (ln_bionuc - ln_geohyd)^2
gen g_renew_fossil     = (ln_renew - ln_fossil)^2


//// Regressions

/// OLS Unconstrained 

// Solar-Wind
reg ln_all_sec_gen ln_solar ln_wind g_solar_wind
est sto ols_solar_wind

// Nuclear-Biomass
reg ln_all_sec_gen ln_nuclear ln_biomass g_nuclear_biomass
est sto ols_nuclear_biomass

// Geo-Hydro
reg ln_all_sec_gen ln_geo ln_hydro g_geo_hydro
est sto ols_geo_hydro

// Bionuc-Geohyd
reg ln_all_sec_gen ln_bionuc ln_geohyd g_bionuc_geohyd
est sto ols_bionuc_geohyd

// Renew-Fossil
reg ln_all_sec_gen ln_renew ln_fossil g_renew_fossil
est sto ols_renew_fossil

// Renewables Seperate
reg ln_all_sec_gen ln_solar ln_wind ln_geo ln_biomass ln_nuclear ln_hydro ///
	ln_solar_wind ln_solar_geo ln_solar_biomass ln_solar_nuclear ///
	ln_solar_hydro ln_wind_geo ln_wind_biomass ln_wind_nuclear ///
	ln_wind_hydro ln_geo_biomass ln_geo_nuclear ln_geo_hydro ///
	ln_biomass_nuclear ln_biomass_hydro ln_nuclear_hydro ln_solar_solar ///
	ln_wind_wind ln_geo_geo ln_biomass_biomass ln_nuclear_nuclear ///
	ln_hydro_hydro
est sto ols_renew_sep
	
reg ln_all_sec_gen ln_solwin ln_geohyd ln_bionuc ln_solwin_geohyd ///
	ln_geohyd_bionuc ln_bionuc_solwin ln_solwin_solwin ///
	ln_geohyd_geohyd ln_bionuc_bionuc
est sto ols_renew_pairs

/// Non-Linear Regressions

// Solar-Wind
nl (ln_all_sec_gen = ({alpha_solar}*(ln_solar^{phi=1}) + {alpha_wind}*(ln_wind^{phi}))^(1/{phi})), variables(ln_wind ln_solar)

// Nuclear-Biomass
nl (ln_all_sec_gen = ({alpha_nuclear}*(ln_nuclear^{phi=1}) + {alpha_biomass}*(ln_biomass^{phi}))^(1/{phi})), variables(ln_biomass ln_nuclear)

// Geo-Hydro
nl (ln_all_sec_gen = ({alpha_geo}*(ln_geo^{phi=1}) + {alpha_hydro}*(ln_hydro^{phi}))^(1/{phi})), variables(ln_hydro ln_geo)

// Bionuc-Geohyd
nl (ln_all_sec_gen = ({alpha_bionuc}*(ln_bionuc^{phi=1}) + {alpha_geohyd}*(ln_geohyd^{phi}))^(1/{phi})), variables(ln_geohyd ln_bionuc)

// Renew-Fossil
nl (ln_all_sec_gen = ({alpha_renew}*(ln_renew^{phi=1}) + {alpha_fossil}*(ln_fossil^{phi}))^(1/{phi})), variables(ln_fossil ln_renew)

// Renewables Paired
nl (ln_all_sec_gen = ({alpha_bionuc}*(ln_bionuc^{phi=1}) + {alpha_geohyd}*(ln_geohyd^{phi}) + {alpha_solwin}*(ln_solwin^{phi}))^(1/{phi}))

// Renewables Seperate
nl (ln_all_sec_gen = ({alpha_solar}*(ln_solar^{phi=1}) + {alpha_wind}*(ln_wind^{phi}) + {alpha_geo}*(ln_geo^{phi}) + {alpha_hydro}*(ln_hydro^{phi}) + {alpha_biomass}*(ln_biomass^{phi}) + {alpha_nuclear}*(ln_nuclear^{phi}))^(1/{phi}))

