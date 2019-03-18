clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\ercot_load_price_2018.csv

//// Generate variables

gen ln_lr   = log(load_rel)
gen ln_pr   = log(price_rel)
gen ln_temp = log(temperature + 30)
gen ln_ws   = log(wind_speed + 1)
gen temp2   = temperature^2
gen temp3   = temperature^3
gen temp4   = temperature^4
gen temp5   = temperature^5


//// Regressions

/// NLS -> NLS

// Polynomial 2

nl (ln_pr = {b0=0} + {b1}*(log({t1_coef}*temperature + {t2_coef}*temp2 + ///
			{d=100})) + {b1}*wind_speed) ///
			if !missing(ln_pr) & !missing(temperature)
predict ln_pr_hat_nl2

nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr_hat_nl2) +                           ///
	{sigma=0.04}*log({t1_coef}*temperature + {t2_coef}*temp2 + {d=10})                                                         ///  
	)                                                                        ///
	if !missing(ln_pr) & !missing(temperature)

// Polynomial 3

nl (ln_pr = {b0=0} + {b1}*(log({t1_coef}*temperature + {t2_coef}*temp2 + ///
			{t3_coef}*temp3 + {d=100})) + {b1}*wind_speed) ///
			if !missing(ln_pr) & !missing(temperature)
predict ln_pr_hat_nl3

nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr_hat_nl3) +                           ///
	{sigma=0.04}*log({t1_coef}*temperature + {t2_coef}*temp2 + {d=10} +      ///
	{t3_coef}*temp3)                                                         ///  
	)                                                                        ///
	if !missing(ln_pr) & !missing(temperature)

// Polynomial 4

nl (ln_pr = {b0=0} + {b1}*(log({t1_coef}*temperature + {t2_coef}*temp2 + ///
			{t3_coef}*temp3 + {t4_coef}*temp4 + {d=100})) + {b1}*wind_speed) ///
			if !missing(ln_pr) & !missing(temperature)
predict ln_pr_hat_nl4

nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr_hat_nl4) +                           ///
	{sigma=0.04}*log({t1_coef}*temperature + {t2_coef}*temp2 + {d=10} +      ///
	{t3_coef}*temp3 + {t4_coef}*temp4)                                       ///  
	)                                                                        ///
	if !missing(ln_pr) & !missing(temperature)
	
	
/// OLS -> NLS (not consistent)

// Polynomial 4		

reg ln_pr temperature temp2 temp3 wind_speed, robust 
predict ln_pr_hat_3

nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr_hat_3) +                           ///
	{sigma=0.04}*log({t1_coef}*temperature + {t2_coef}*temp2 + {d=10} +  ///
	{t3_coef}*temp3)  ///            ///
	)                                                                    ///
	if !missing(ln_pr) & !missing(temperature)

// Polynomial 4

reg ln_pr temperature temp2 temp3 temp4 wind_speed, robust 
predict ln_pr_hat_4

nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr_hat_4) +                           ///
	{sigma=0.04}*log({t1_coef}*temperature + {t2_coef}*temp2 + {d=10} +  ///
	{t3_coef}*temp3 + {t4_coef}*temp4)  ///            ///
	)                                                                    ///
	if !missing(ln_pr) & !missing(temperature)
	

// Polynomial 5

reg ln_pr temperature temp2 temp3 temp4 temp5 wind_speed, robust
predict ln_pr_hat_5

nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr_hat_5) +                           ///
	{sigma=0.04}*log({t1_coef}*temperature + {t2_coef}*temp2 + {d=10} +  ///
	{t3_coef}*temp3 + {t4_coef}*temp4 + {t5_coef}*temp5)  ///            ///
	)                                                                    ///
	if !missing(ln_pr) & !missing(temperature)
	

	