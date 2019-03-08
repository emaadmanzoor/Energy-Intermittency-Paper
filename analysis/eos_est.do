clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\esp_jan_eos_est.csv

// Generate variables
gen ln_edbj = log(elc_demand_by_jan)
gen ln_epbj = log(elc_price_by_jan)


reg ln_edbj ln_epbj

nl (ln_edbj = {c=0} + (-{sigma=1})*(ln_epbj) + {sigma=1}*(sin((month_num-1)/11*2*3.14159 + {shift=10})) + (-{sigma=1})*sin({shift}))



// With Load data

clear
import delimited C:\Users\saket\GitHub\BECCS-Case-Study\data\processed\ercot_load_price_2018.csv

// Generate variables
gen ln_lr  = log(load_rel)
gen ln_pr  = log(price_rel)
gen m1   = month == 1
gen m2   = month == 2
gen m3   = month == 3
gen m4   = month == 4
gen m5   = month == 5
gen m6   = month == 6
gen m7   = month == 7
gen m8   = month == 8
gen m9   = month == 9
gen m10  = month == 10
gen m11  = month == 11
gen m12  = month == 12
gen ms1  = month == 1
gen ms2  = month == 2
gen ms3  = month == 3
gen ms4  = month == 4
gen ms5  = month == 5
gen ms6  = month == 6
gen ms7  = month == 7
gen ms8  = month == 8
gen ms9  = month == 9
gen ms10 = month == 10
gen ms11 = month == 11
gen ms12 = month == 12
gen h1   = hour == 1
gen h2   = hour == 2
gen h3   = hour == 3
gen h4   = hour == 4
gen h5   = hour == 5
gen h6   = hour == 6
gen h7   = hour == 7
gen h8   = hour == 8
gen h9   = hour == 9
gen h10  = hour == 10
gen h11  = hour == 11
gen h12  = hour == 12
gen h13  = hour == 13
gen h14  = hour == 14
gen h15  = hour == 15
gen h16  = hour == 16
gen h17  = hour == 17
gen h18  = hour == 18
gen h19  = hour == 19
gen h20  = hour == 20
gen h21  = hour == 21
gen h22  = hour == 22
gen h23  = hour == 23
gen h24  = hour == 24

/// Temporary
// Only hourly sine wave
nl (ln_lr = ///
	({ms1_dummy}*m1 + {ms2_dummy}*m2 + {ms3_dummy}*m3 + {ms4_dummy}*m4 +       ///
	{ms5_dummy}*m5 + {ms6_dummy}*m6 + {ms7_dummy}*m7 + {ms8_dummy}*m8 +       ///
	{ms9_dummy}*m9 + {ms10_dummy}*m10 + {ms11_dummy}*m11 + {ms12_dummy}*m12)*(sin((hour-1)/ 23*2*3.14159 + {shift=10})) + ///
	{m1_dummy}*m1 + {m2_dummy}*m2 + {m3_dummy}*m3 + {m4_dummy}*m4 +       ///
	{m5_dummy}*m5 + {m6_dummy}*m6 + {m7_dummy}*m7 + {m8_dummy}*m8 +       ///
	{m9_dummy}*m9 + {m10_dummy}*m10 + {m11_dummy}*m11 + {m12_dummy}*m12 ///
	) if !missing(ln_pr)

nl (ln_lr = ///
	({amp=1})*(sin((hour-1)/ 23*2*3.14159 + {shift=10})) + ///
	{m1=1}*month + {m2=1}*(month^2) + {m3=1}*month^3 + {m4=1}*month^4 ///
	) if !missing(ln_pr)
	
// Sin wave hourly +temp
nl (ln_lr = (-{sigma=1})*(ln_pr) +                                ///
    {sigma=1}*((sin((hour-1)/23*2*3.14159 + {shift=10})) +                ///
	{m1_dummy}*m1 + {m2_dummy}*m2 + {m3_dummy}*m3 + {m4_dummy}*m4 +       ///
	{m5_dummy}*m5 + {m6_dummy}*m6 + {m7_dummy}*m7 + {m8_dummy}*m8 +       ///
	{m9_dummy}*m9 + {m10_dummy}*m10 + {m11_dummy}*m11 + {m12_dummy}*m12)  ///
	 + (-{sigma=1})*(sin({shift} + {m2_dummy}*m2))) if !missing(ln_pr)
	 
	 
nl (ln_lr = {c=0} + ({ampt}*sin((day-1)/364*2*3.14159+{shiftt=1})+{base_amp=1})*sin((hour-1)/23*2*3.14159+{shifth=1})	 + /// 
	 {ampd}*sin((day-1)/364*2*3.14159+{shiftd=1}))	
	 

/// Main
// Sin wave hourly + y shift monthly dummies
nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr) +                                ///
	{sigma=0.04}*((sin((hour-1)/23*2*3.14159 + {shift=10})) +              ///
	{m1_dummy}*m1 + {m2_dummy}*m2 + {m3_dummy}*m3 + {m4_dummy}*m4 +       ///
	{m5_dummy}*m5 + {m6_dummy}*m6 + {m7_dummy}*m7 + {m8_dummy}*m8 +       ///
	{m9_dummy}*m9 + {m10_dummy}*m10 + {m11_dummy}*m11 + {m12_dummy}*m12)  ///
	+ (-{sigma=1})*(sin({shift})+1) +                                     ///           
	{m2_dummy}*m2) ///
	if !missing(ln_pr)
	
// Sin wave hourly + x shift monthly dummies
nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr) +                                ///
	{sigma=1}*(sin((hour-1)/23*2*3.14159 +             ///
	{m1_dummy}*m1 + {m2_dummy}*m2 + {m3_dummy}*m3 + {m4_dummy}*m4 +       ///
	{m5_dummy}*m5 + {m6_dummy}*m6 + {m7_dummy}*m7 + {m8_dummy}*m8 +       ///
	{m9_dummy}*m9 + {m10_dummy}*m10 + {m11_dummy}*m11 + {m12_dummy}*m12)) ///
	+ (-{sigma=1})*(sin({shift} + {m2_dummy}*m2))) if !missing(ln_pr)
	

// Sine wave monthly + hourly dummies
nl (ln_lr = {c=0} + (-{sigma=1})*(ln_pr) +                                ///
    {sigma=1}*({h1_dummy}*h1 + {h2_dummy}*h2 + {h3_dummy}*h3 +            /// 
	{h4_dummy}*h4 + {h5_dummy}*h5 + {h6_dummy}*h6 + {h7_dummy}*h7 +       ///
	{h8_dummy}*h8 + {h9_dummy}*h9 + {h10_dummy}*h10 + {h11_dummy}*h11 +   ///
	{h12_dummy}*h12 + {h13_dummy}*h13 + {h14_dummy}*h14 +                 ///
	{h15_dummy}*h15 + {h16_dummy}*h16 + {h17_dummy}*h17 +                 ///
	{h18_dummy}*h18 + {h19_dummy}*h19 + {h20_dummy}*h20 +                 ///
	{h21_dummy}*h21 + {h22_dummy}*h22 + {h23_dummy}*h23 +                 ///
	{h24_dummy}*h24 +                                                     ///
	(sin((month-1)/11*2*3.14159 + {shift=10})))                           ///
	+ (-{sigma=1})*(  {h1_dummy}*h1 +                                     ///
	(sin((2-1)/11*2*3.14159 + {shift=10}))))                              ///
	if !missing(ln_pr) 

