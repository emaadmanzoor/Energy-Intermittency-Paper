$title A Standard CGE Model in Ch. 6 (STDCGE,SEQ=276)

$onText
No description.


Hosoe, N, Gasawa, K, and Hashimoto, H
Handbook of Computible General Equilibrium Modeling
University of Tokyo Press, Tokyo, Japan, 2004

Keywords: nonlinear programming, computable general equilibrium model


With Modified IMPLAN Sectors
Government employment split
All industries aggregated
$offText

Set
   u     'SAM entry' / AGR_CRP,AGR_LIV,CAP,CORP,ELC_BIOMASS,ELC_DIST,ELC_FF,ELC_GEO,
                    ELC_HYDRO,ELC_NUC,ELC_OTHER,ELC_SOLAR,ELC_WIND,FORE,GOV_FED,GOV_FED_EMP,
                    GOV_FED_ENT,GOV_STT,GOV_STT_EMP,GOV_STT_ENT,HOH,LAB,MAN,NonIndustry,PAP,
                    PROF,PROP,SER,TAX,TRD,ELC_BECCS,ELC_RNW  /
   i(u)  'goods'     / AGR_CRP,AGR_LIV,ELC_BIOMASS,ELC_DIST,ELC_FF,ELC_GEO,
                    ELC_HYDRO,ELC_NUC,ELC_OTHER,ELC_SOLAR,ELC_WIND,FORE,GOV_FED_EMP,
                    GOV_FED_ENT,GOV_STT_EMP,GOV_STT_ENT,MAN,NonIndustry,PAP,
                    SER,ELC_BECCS,ELC_RNW       /
   h(u)  'factor'    /           LAB, PROF, PROP                  /
   ge(u) 'government enterprises' / GOV_FED_EMP,GOV_FED_ENT,GOV_STT_EMP,GOV_STT_ENT /
   tr(u) 'trade'  / TRD /
   fe(u) 'factor endowers'  / HOH, GOV_FED, GOV_STT, CORP, CAP, TRD /
   g(fe)  'government'              / GOV_FED, GOV_STT /
;

Alias (u,v), (i,j,ii), (h,k), (g,gg);

Table SAM(u,v) 'social accounting matrix'
$onDelim
,AGR_CRP,AGR_LIV,CAP,CORP,ELC_BIOMASS,ELC_DIST,ELC_FF,ELC_GEO,ELC_HYDRO,ELC_NUC,ELC_OTHER,ELC_SOLAR,ELC_WIND,FORE,GOV_FED,GOV_FED_EMP,GOV_FED_ENT,GOV_STT,GOV_STT_EMP,GOV_STT_ENT,HOH,LAB,MAN,NonIndustry,PAP,PROF,PROP,SER,TAX,TRD,ELC_BECCS,ELC_RNW
AGR_CRP,27919.473163,672.578536,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,869.869648,-0.000000,-0.000000,-0.000000,32.156155,0.000000,0.000000,7043.635607,-0.000000,17164.379353,1081.786535,0.000000,0.000000,0.000000,4052.041465,0.000000,18237.044112,15.599429,0.000000
AGR_LIV,69.355435,28542.965630,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,331.103121,-0.000000,-0.000000,-0.000000,30.426826,0.000000,0.000000,933.593197,-0.000000,23698.417527,132.393320,0.000000,0.000000,0.000000,3670.143305,0.000000,4561.463033,0.000000,0.000000
CAP,0.000000,0.000000,0.000000,157531.923398,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,382205.079174,0.000000,0.000000,0.000000,0.000000,0.000000,865703.675598,0.000000,0.000000,773824.133110,0.000000,0.000000
CORP,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,582468.825575,0.000000,0.000000,0.000000,0.000000,0.000000
ELC_BIOMASS,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1436.931749,0.000000,291.549412
ELC_DIST,1249.996007,1102.731432,-0.000000,-0.000000,41.000606,93558.482516,2651.268620,-0.000000,30.964062,126.491374,3.700505,3.236798,24.826325,976.125681,1023.885616,-0.000000,921.532669,1963.954229,0.000000,933.367449,46244.795891,-0.000000,19256.055648,0.000000,2489.415725,0.000000,0.000000,47906.773647,0.000000,3249.899580,144.198410,0.000000
ELC_FF,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,60479.416725,0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,7174.085331,0.000000,0.000000
ELC_GEO,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1110.660100,0.000000,193.038376
ELC_HYDRO,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,4729.970417,-0.000000,0.000000,6331.753617,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,947.409572,0.000000,55451.353853
ELC_NUC,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,3799.218828,0.000000,15317.666528
ELC_OTHER,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1169.310485,0.000000,171.584255
ELC_SOLAR,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1124.569736,0.000000,265.598124
ELC_WIND,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1509.938284,0.000000,167.050919
FORE,4930.833015,814.416020,-0.000000,-0.000000,0.999015,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,8336.772173,-0.000000,-0.000000,-0.000000,26.878259,0.000000,-0.000000,199.617134,-0.000000,2489.827374,-0.000000,443.285223,-0.000000,-0.000000,3460.175492,-0.000000,365.202020,0.997553,-0.000000
GOV_FED,0.000000,0.000000,368853.215788,129521.462031,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,461469.897425,374971.733423,0.000000,0.000000,0.000000,17943.026095,13916.870895,0.000000,43614.303420,2191.845283,0.000000,0.000000
GOV_FED_EMP,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,255207.531928,255615.450589,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,16.453124,0.000000,0.000000
GOV_FED_ENT,198.007841,117.195386,0.000000,0.000000,0.000000,4113.200965,1729.997611,0.000000,179.715570,121.453762,-0.000000,0.000000,0.000000,12.493031,359.961286,0.000000,20243.042415,50.849471,0.000000,15.109860,1644.148263,0.000000,857.244083,0.000000,0.000000,0.000000,0.000000,25258.445455,0.000000,6128.534186,101.948099,0.000000
GOV_STT,0.000000,0.000000,144488.083276,20100.556410,-0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,174947.377050,-0.000000,-0.000000,0.000000,0.000000,0.000000,157109.260041,5713.614028,0.000000,0.000000,0.000000,0.000000,18398.490203,-0.000000,339740.220770,13281.217391,0.000000,0.000000
GOV_STT_EMP,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,394283.185574,429921.234041,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000
GOV_STT_ENT,0.000000,0.000000,-0.000000,-0.000000,-0.000000,6393.326302,1783.636107,-0.000000,2780.396388,140.081231,-0.000000,-0.000000,-0.000000,0.000000,213.121703,-0.000000,91.295102,61.509797,0.000000,20528.199654,16315.704175,-0.000000,12360.365895,-0.000000,273.337216,0.000000,-0.000000,28753.741040,0.000000,12189.125664,118.181531,0.000000
HOH,0.000000,0.000000,349295.530073,275314.947882,-0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,751915.383418,-0.000000,-0.000000,212028.537635,0.000000,0.000000,0.000000,2797468.182257,0.000000,0.000000,0.000000,363228.479389,384329.305493,-0.000000,0.000000,70006.125792,0.000000,0.000000
LAB,3968.819424,2149.249575,-0.000000,-0.000000,960.774187,9360.251602,5142.489621,896.472464,1425.084184,3004.320364,915.385667,914.875050,1026.841572,3188.332091,-0.000000,162975.410833,20963.083152,0.000000,355027.853676,24218.710150,0.000000,0.000000,481603.605577,25849.171726,11824.481255,0.000000,0.000000,2060378.792069,0.000000,0.000000,1510.342620,849.169076
MAN,6693.859406,5952.976699,324069.107446,-0.000000,3.484969,79.286698,15313.331869,1.525532,68.337324,2901.376283,1.302561,2.315609,2.639729,1324.243093,41556.080707,-0.000000,1176.167674,82216.190303,0.000000,11147.541742,355761.321484,-0.000000,2364136.158862,9438.196554,10884.142131,0.000000,0.000000,218944.248339,0.000000,1244411.206226,217.299789,0.000000
NonIndustry,719.347785,47.150291,5295.836158,-0.000000,-0.000000,2.074650,1510.493692,-0.000000,4.751148,54.343249,-0.000000,-0.000000,-0.000000,104.082717,1916.626354,-0.000000,1.082353,28.608728,0.000000,0.000000,16754.629544,-0.000000,8571.699324,5.205206,244.891764,0.000000,0.000000,10388.088078,0.000000,3793.996786,1.005904,0.000000
PAP,118.739285,135.452780,-0.000000,-0.000000,-0.000000,0.000000,1426.549935,-0.000000,0.000000,103.880091,-0.000000,-0.000000,-0.000000,0.000000,500.891718,-0.000000,5.227460,317.953718,0.000000,6.743102,4833.429728,-0.000000,18756.529798,243.463172,56205.111978,0.000000,0.000000,11041.503011,0.000000,34418.956799,1.000562,0.000000
PROF,2762.858433,2784.852172,-0.000000,-0.000000,0.997553,1.704184,1040.288649,1.077166,3.435379,10.140360,0.999040,0.997553,0.997553,2158.691327,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,73620.489023,-0.000000,17.931200,0.000000,-0.000000,298756.763225,0.000000,0.000000,6.702216,2.608067
PROP,5983.222842,4831.497341,-0.000000,-0.000000,534.575996,22009.063078,11183.098268,402.620851,1023.804764,5827.755505,416.069907,465.600565,424.101047,0.000000,-0.000000,92248.620054,2585.113935,0.000000,39255.195946,8064.231267,0.000000,-0.000000,434880.250251,0.000000,8099.104585,0.000000,0.000000,1264532.551479,0.000000,0.000000,770.361598,452.406617
SER,9907.992563,5046.807501,305544.384153,-0.000000,156.822395,737.714527,5924.666384,0.997553,970.748650,3440.704697,2.509498,2.188249,194.519533,1290.881069,129285.197536,-0.000000,6423.815939,101633.119307,0.000000,18407.801700,3077575.965503,0.000000,529234.885666,2794.117156,16658.685852,0.000000,0.000000,7711786.845019,0.000000,463693.781948,786.740359,0.000000
TAX,-0.000000,227.815211,-0.000000,-0.000000,-0.000000,8569.321792,5686.045832,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,236.316368,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,42158.899568,-0.000000,131.722526,0.000000,-0.000000,326245.098767,0.000000,0.000000,69.237555,30.100745
TRD,12566.047650,9544.190096,681718.702226,-0.000000,29.834202,4360.261610,14261.635982,1.070333,493.814876,3386.318324,0.997553,0.997553,3.093928,2240.084242,55556.305499,-0.000000,3281.453102,81105.439486,0.000000,11649.000194,675495.429846,-0.000000,667513.528233,9899.547986,20843.327821,-0.000000,39172.062833,376326.718627,-0.000000,0.000000,-0.000000,-0.000000
ELC_BECCS,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,1525.887614,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,709.539248,-0.000000,0.000000,699.536683,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,808.673021,25.207310,0.000000
ELC_RNW,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,73192.116527,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000
$offDelim
;
* SAM may not be perfectly balanced due to rounding errors

* Loading the initial values
Parameter

    F0(h,j)    'the h-th factor input by the j-th firm'
    Fg0(h,g)   'government factor consumption'
    Fen0(fe,h) 'factor h endowment from source fe'
    FF(h)      'total factor endowment'
    
    Y0(j)     'composite factor'
    X0(i,j)   'intermediate input'
    Z0(j)     'output of the j-th good'


    Hbud0     'household income'
    TRh0(tr)  'household consumption of traded goods'
    Htr0(tr)  'household supply of traded goods'

    hoh_trd_rt(tr) 'percent of household income used on traded goods'

    Xp0(i)    'household consumption of the i-th good '
    Xg0(i,g)  'government consumption'
    
    Sh0       'household saving'
    Sg0(g)    'government saving'
    Stot0     'total savings'

    invest_g_rt(g)  'investment rate in government'
    invest_h_rt     'investment rate in households'
    invest_t_rt(tr) 'investment rate in foreign and domestic regions'

    Xv0(i)     'investment demand in goods'
    Gv0(g)     'investment demand in government'
    Hv0        'investment demand in household'
    TRv0(tr)   'investment demand in foreign and domestic regions'

    gov_hoh_rt(g)     'percent of gov revenue spent on households'
    gov_trd_rt(g,tr)  'percent of gov revenue spent on trade'
    gov_gov_rt(g,gg)  'percent of gov revenue transferred to other gov'
   
    tax_z_rt(i)   'production tax rate on each sector'
    tax_z_shr(g)  'share of production taxes going to government g'
    tax_h_rt(g)   'household tax rate'
    tax_c_rt(g)   'corporate tax rate'
    tax_k_rt(g)   'capital tax rate'
    tax_i_rt(i,g) 'direct industry tax'

    gov_tr_rt(g,tr) 'proportion of gov revenue from trade'
    Gtr0(g,tr)      'gov revenue from trade'

    Tz0(i,g)     'production tax revenue'
    Tza0(g)      'aggregate production tax revenue'
    Td0(g)       'household tax revenue'
    Tc0(g)       'corporate tax revenue'
    Tk0(g)       'capital tax revenue'
    Ti0(i,g)     'direct industry tax revenue'
    Gtot0(g)     'government total revenue'

    Cpr0         'corporate profit'
    Re0          'corporate retained earnings'
    div_rt       'percent of corp profits going to dividends'   

*    tauz(i)    'tax rate'
    taum(i)    'tariff rate (keep at 0)'

    E0(i)   'exports to rest of world'
    ED0(i)  'exports domestic'
    M0(i)   'imports from rest of world'
    MD0(i)  'imports domestic'
    Q0(i)   "Armington's composite ROW good (M + D)"
    D0(i)   'locally produced good within state'
    
;

F0(h,j)    = SAM(h,j);
Fg0(h,g)   = SAM(h,g);
Fen0(fe,h) = SAM(fe,h);

Y0(j)   = sum(h, F0(h,j));

X0(i,j) = SAM(i,j);
Z0(j)   = Y0(j) + sum(i, X0(i,j));
Xp0(i)  = SAM(i,"HOH");
Xg0(i,g)  = SAM(i,g);

FF(h)     = sum(u, SAM(u,h));

Hbud0     = sum(u, SAM("HOH", u));
TRh0(tr)  = SAM(tr, "HOH");
Htr0(tr)  = SAM("HOH", tr);

hoh_trd_rt(tr) = TRh0(tr) / Hbud0;

Sh0     = SAM("CAP","HOH");
Sg0(g)  = SAM("CAP", g);
Stot0   = sum(u, SAM("CAP", u));

invest_g_rt(g)  = SAM(g, "CAP")/Stot0;
invest_h_rt     = SAM("HOH", "CAP")/Stot0;
invest_t_rt(tr) = SAM(tr, "CAP")/Stot0;

Xv0(i)  = SAM(i,"CAP");
Gv0(g)  = SAM(g,"CAP");
Hv0     = SAM("HOH", "CAP");
TRv0(tr) = SAM(tr, "CAP");

gov_hoh_rt(g) = SAM("HOH", g) / sum(u, SAM(g, u));
gov_trd_rt(g,tr) = SAM(tr, g) / sum(u, SAM(g, u));
gov_gov_rt(g,gg) = SAM(gg, g) / sum(u, SAM(g, u));

Cpr0     = SAM("CORP", "PROP");
Re0       = SAM("CAP", "CORP");
div_rt    = SAM("HOH", "CORP") / Cpr0;

tax_z_rt(i)   = SAM("TAX", i) / Z0(i);
tax_z_shr(g)  = SAM(g, "TAX") / sum(gg, SAM(gg, "TAX"));
tax_h_rt(g)   = SAM(g, "HOH") / Hbud0;
tax_c_rt(g)   = SAM(g, "CORP") / Cpr0;
tax_k_rt(g)   = SAM(g, "CAP") / sum(u, SAM("CAP", u));
tax_i_rt(i,g) = SAM(g, i) / Z0(i);

gov_tr_rt(g,tr) = SAM(g, tr) / sum(u, SAM(g, u));
Gtr0(g,tr)      = SAM(g, tr);

Tz0(i,g)  = tax_z_rt(i)*tax_z_shr(g)*Z0(i);
Tza0(g)   = sum(i, Tz0(i,g));
Td0(g)    = SAM(g, "HOH");   
Tc0(g)    = SAM(g, "CORP");
Tk0(g)    = SAM(g, "CAP");
Ti0(i,g)  = SAM(g, i);
Gtot0(g)  = sum(u, SAM(g, u));

taum(i) = 0;

M0(i)   = SAM("TRD" ,i);
E0(i)   = SAM(i, "TRD");
Q0(i)   = Xp0(i) + sum(g, Xg0(i,g)) + Xv0(i) + sum(j, X0(i,j));
D0(i)   = (1+tax_z_rt(i)+sum(g, tax_i_rt(i,g)))*Z0(i)-E0(i);


display Tza0, tax_z_rt, Y0, X0, Z0, Sh0, Q0, M0, D0, E0, Xg0, Fen0;

** Calibration
* Known params
Parameter
   esp(i)   'elasticity of substition for production factors'
   esp_p(i) 'substitution elasticity parameter (esp)'
   etp(i)   'elasticity of transformation for composite goods'
   etp_p(i) 'transformation elasticity parameter (etp)'

   sigma_q(i) 'elasticity of substitution for ROW exports'
   sigma_d(i) 'elasticity of substitution for Domestic exports'
   psi(i)     'elasticity of transformation for local composite '
   eta_q(i)   'substitution elasticity parameter (sigma)'   
   eta_d(i)   'substitution elasticity parameter (sigma)'
   phi(i)     'transformation elasticity parameter (psi)'

   rr     'rental rate for capital'
;

esp(i)   =  1.1;
esp_p(i) = (esp(i)-1)/esp(i);
etp(i)   =  2;
etp_p(i) = (etp(i)+1)/etp(i);
etp_p('ELC_DIST') = 11;

sigma_q(i) =  2;
sigma_d(i) =  2;
psi(i)     =  2;
eta_q(i)   = (sigma_q(i)-1)/sigma_q(i);
eta_d(i)   = (sigma_d(i)-1)/sigma_d(i);
phi(i)     = (psi(i)+1)/psi(i);

rr = 0.025;

* Calibrated
Parameter
    beta_util(i)    'share coeff for utility'

    alpha_fac(h, j)  'share coeff for firm factor aggregation'
    theta_fac(j)     'scale coeff for firm factor aggregation'
    
    ssh       'average propensity for household saving'
    ssg(g)    'average propensity for gov. saving'
 
    gdp_shr_x(i,j)  'share parameter for gdp of int inputs'
    gdp_shr_y(j)    'share parameter for gdp of factors'
    gdp_scl(i)      'scale parameter for gdp'
    
    xie(i)     'share par. in transformation func.'
    xid(i)     'share par. in transformation func.'
    theta(i)   'scale par. in transformation func.'

    deltam(i)  'share par. in Armington func. (nonlocal)'
    deltad(i)  'share par. in Armington func. (local)'
    gamma(i)   'scale par. in Armington func.'

    alpha_c    'scale param for corporate revenue'
    beta_c     'elasticity of corporate revenue'

    mu(i,g)     'government consumption share'
    lambda(i)   'investment demand share'
;

beta_util(i) = Xp0(i)/sum(j, Xp0(j));

alpha_fac(h, j) = F0(h,j)/sum(k, F0(k,j));
theta_fac(j)    = Y0(j)/prod(h, F0(h,j)**alpha_fac(h,j));

ssh       =  Sh0/sum(u, SAM("HOH",u));
ssg(g)    =  Sg0(g)/sum(u, SAM(g,u));

gdp_shr_x(i,j)$(X0(i,j)>0) = X0(i,j)**(1-etp_p(j))/(sum(ii$(X0(ii,j)>0), X0(ii,j)**(1-etp_p(j))) + Y0(j)**(1-etp_p(j)));
gdp_shr_y(j) = Y0(j)**(1-etp_p(j))/(sum(ii$(X0(ii,j)>0), X0(ii,j)**(1-etp_p(j))) + Y0(j)**(1-etp_p(j)));
gdp_scl(j) = Z0(j)/((sum(i, gdp_shr_x(i,j)*X0(i,j)**etp_p(j)) + gdp_shr_y(j)*Y0(j)**etp_p(j))**(1/etp_p(j)));

deltam(i)    = (1+taum(i))*M0(i) **(1-eta_q(i))/((1+taum(i))*M0(i)**(1-eta_q(i)) + D0(i)**(1-eta_q(i)));
deltad(i)   =             D0(i)**(1-eta_q(i))/((1+taum(i))*M0(i)**(1-eta_q(i)) + D0(i)**(1-eta_q(i)));
gamma(i)   =  Q0(i)/((deltam(i)*M0(i)**eta_q(i)+deltad(i)*D0(i)**eta_q(i))**(1/eta_q(i)));

xie(i)     =  0;
xie(i)     $ (E0(i) > 0) = E0(i)**(1-phi(i))/(E0(i)**(1-phi(i))+D0(i)**(1-phi(i)));
xid(i)     =  1;
xid(i)     $ (E0(i) > 0) =  D0(i)**(1-phi(i))/(E0(i)**(1-phi(i))+D0(i)**(1-phi(i)));
theta(i)   =  Z0(i)/(xie(i)*E0(i)**phi(i)+xid(i)*D0(i)**phi(i))**(1/phi(i));

beta_c   = (rr*Re0*(1-div_rt-sum(g, tax_c_rt(g)))) / ( rr*Re0*(1-div_rt-sum(g, tax_c_rt(g))) + Cpr0 );
alpha_c  = rr / (beta_c*Re0**(beta_c-1));

mu(i,g)    =  Xg0(i,g)/sum(j, Xg0(j,g));
lambda(i)  =  Xv0(i)/(Stot0);

display ssh, ssg, alpha_fac, gdp_shr_x, gdp_shr_y, alpha_c, beta_c, deltam, gamma, gdp_scl;


Variable
    UU       'utility [fictitious]'
    Y(j)     'composite factor'
    
    F(h,j)    'the h-th factor input by the j-th firm'
    Fen(fe,h) 'the h-th factor endowment from source fe'
    F_gov(h)  'the h-th factor input into government'
    
    X(i,j)   'intermediate input'
    Z(j)     'output of the j-th good'
    Xp(i)    'household consumption of the i-th good'
    pf(h)    'the h-th factor price'
    py(j)    'composite factor price'
    pz(j)    'supply price of the i-th good'

    Indtot(i) 'industry total budget'
    
    Hbud      'household income'
    TRh(tr)   'household spending on traded goods'
    Htr(tr)   'household supply of traded goods'
    Hc      'household dividends from corporations'
    
    Tz(j,g)  'production tax revenue'
    Td(g)    'household tax revenue'
    Tc(g)    'corporate tax revenue'
    Tk(g)    'capital tax revenue'
    Ti(j,g)  'direct industry tax revenue'
    Gtr(g,tr) 'government revenue from trade'
    Gtot(g)  'government total tax revenue'

    Sg(g)     'government savings'
    Xg(i,g)   'government demand for good j'
    Lg(g)     'government employment'
    Hg(g)     'government spending on households'
    Trg(g,tr) 'government spending on trade'
    G2g(g,gg)  'government transfers'

    Xv(i)    'investment demand for good i'
    Gv(g)    'investment demand for gov g'
    Hv       'investment demand for households'
    TRv(tr)  'investment demand in foreign and domestic regions'
    
    E(i)    'exports to rest of world'
    ED(i)   'exports domestic'
    M(i)    'imports from rest of world'
    Q(i)    "Armington's composite ROW good (M + D)"
    D(i)   'locally produced good within state'

    Crv     'Corporate revenue'
    Cpr     'Corporate profit'
    Re      'Retained earnings'
    Dv      'Dividends paid to households'

    Sg(g)   'government savings'
    Sh      'household savings'
    Sf(tr)  'foreign savings'
    Stot    'total savings'
    Itot    'total investment'

    
    pq(i)   'Price of Q'
    pm(i)   'Price of M'
    pmd(i)  'Price of MD'
    pd(i)   'Price of D'
    pe(i)   'Price of E'

    epsilon 'exchange rate'
    pWe(i)  'export price in US dollars'
    pWm(i)  'import price in US dollars'

    temp 'temporary for debugging'

    slack_1(i) 'slack var for Industry Totals'
    slack_2(i) 'slack var for Domestic supply (eqD)'
;

Equation
    obj      'utility function'

    eqpy(j)  'composite factor agg function'
    eqF(h,j) 'factor demand'
    
    eqTRh(tr) 'household demand for traded goods'
    eqSh      'household savings'
    eqHtr(tr) 'household supply of traded goods'
    eqHc      'household dividends from corporations'

    eqSf(tr)  'foreign savings'

    eqZ(j)   'production function'
    eqX(i,j) 'intermediate good demand'
    eqY(j)   'composite factor demand'

    eqHBudS   'household budget spending side'
    eqHBudI   'household budget income side'
    eqStot    'total savings'
    eqItot    'total investment'
    eqIndtotS(i) 'industry total spending'
    eqIndtotI(i) 'industry total income'
    eqGtotI(g)   'government total income'
    eqGtotS(g)   'government total spending'
    
    eqXv(i)   'investment demand for good i'
    eqGv(g)   'investment demand for gov g'
    eqHv      'investment demand for households'
    eqTRv(tr) 'investment demand in foreign and domestic regions'

    eqpzs(j)   'production unit cost'

    eqTz(j,g)    'government production tax revenue'
    eqTd(g)      'government household tax revenue'
    eqTc(g)      'government corporate tax revenue'
    eqTk(g)      'government capital tax revenue'
    eqTi(i,g)    'government industry tax revenue'
    eqGtr(g,tr)  'government revenue from trade'

    eqSg(g)      'government savings'    
    eqXg(i,g)    'government demand function'
    eqHg(g)      'government spending on households'
    eqTrg(g,tr)  'government spending on trade'
    eqG2g(g,gg)  'government transfers'
    

    eqpqs(i)  'Armington function for Q'
    eqM(i)    'import demand function'
    eqD(i)    'composite domestic good demand function'

    eqpzd(i)   'Armington function for Z'
    eqE(i)
    eqDs(i)
    
    eqCrv      'Corporate Revenue'
    eqCpr      'Corporate Profit function'
    eqCF       'Corporate Factor output'

*    eqpe(i)   'world export price equation'
*    eqpm(i)   'world import price equation'

    eqFM(h)   'Factor market'
    eqpqd(i)  'market clearing cond. for comp. good'
    eqpqu(i)  'unit cost of q'

    eqbop     'Balance of payments'

*    eqtemp(g)  'for debugging'
;

*** Equations

* factor functions
eqpy(j)..   Y(j)   =e= theta_fac(j)*prod(h, F(h,j)**alpha_fac(h,j));
eqF(h,j)..  F(h,j) =e= alpha_fac(h, j)*py(j)*Y(j)/pf(h);


* production
eqZ(j)..                          Z(j)  =e= gdp_scl(j)*((sum(i, gdp_shr_x(i,j)*X(i,j)**etp_p(j)) + gdp_shr_y(j)*Y(j)**etp_p(j))**(1/etp_p(j)));
eqX(i,j)$(gdp_shr_x(i,j) > 0)..  X(i,j) =e= (gdp_scl(j)**etp_p(j)*gdp_shr_x(i,j)*pz(j)/pz(i))**(1/(1-etp_p(j)))*Z(j);
eqY(j)..                          Y(j)  =e= (gdp_scl(j)**etp_p(j)*gdp_shr_y(j)*pz(j)/py(j))**(1/(1-etp_p(j)))*Z(j);
eqpzs(j)..                  pz(j)*Z(j)  =e= sum(i, pz(i)*X(i,j)) + py(j)*Y(j);


* household
eqTRh(tr)..   TRh(tr)   =e= hoh_trd_rt(tr)*Hbud;
eqHtr(tr)..   Htr(tr)   =e= (SAM("HOH", "TRD")/Hbud0)*Hbud;
eqHc..        Hc        =e=  div_rt*(Cpr);

* government
eqTz(j,g)..   Tz(j,g)   =e= tax_z_rt(j)*pz(j)*Z(j)*tax_z_shr(g);
eqTd(g)..     Td(g)     =e= tax_h_rt(g)*Hbud;
eqTc(g)..     Tc(g)     =e= (Cpr)*tax_c_rt(g);
eqTk(g)..     Tk(g)     =e= tax_k_rt(g)*Stot;
eqTi(i,g)..   Ti(i,g)   =e= tax_i_rt(i,g)*Z(i)*pz(i);

eqGtr(g,tr).. Gtr(g,tr) =e= gov_tr_rt(g,tr)*Gtot(g);

eqHg(g)..      Hg(g)      =e= gov_hoh_rt(g)*Gtot(g);
eqTrg(g,tr)..  Trg(g,tr)  =e= gov_trd_rt(g,tr)*Gtot(g);
eqG2g(g,gg)..  G2g(g,gg)  =e= gov_gov_rt(g,gg)*Gtot(g);
eqXg(i,g)..    Xg(i,g)    =e= mu(i,g)/pq(i)*(Gtot(g) - Sg(g) - Hg(g) - (sum(tr, Trg(g,tr))) - sum(gg, G2g(g,gg)));



* Temporary total functions, need to be filled in

eqHbudS..     Hbud    =e= Sh + sum(g, Td(g)) + sum(tr, Trh(tr)) + sum(i, pq(i)*Xp(i));
eqHbudI..     Hbud    =e= sum(h, Fen("HOH", h)) + sum(tr, Htr(tr)) + sum(g, Hg(g)) + Hv + Hc;

eqStot..          Stot       =e= Re + sum(g, Sg(g)) + Sh + Fen('CAP', 'PROP') + sum(tr, Sf(tr));
eqItot..          Itot       =e= sum(i, pq(i)*Xv(i)) + sum(g, Gv(g)) + Hv + sum(tr, TRv(tr));
              
eqIndtotS(i)..    Indtot(i)  =e= pz(i)*Z(i)*(1+tax_z_rt(i)) + M(i)*pm(i)*epsilon + slack_1(i);                       
eqIndtotI(i)..    Indtot(i)  =e= Xv(i)*pq(i) + sum(g, Xg(i,g))*pq(i) + sum(j, X(i,j)*pq(j)) + Xp(i)*pq(i) + E(i)*pe(i)*epsilon;    

eqGtotI(g)..   Gtot(g)  =e=  sum(j, Tz(j,g)) + Td(g) + Tc(g) + Tk(g) + sum(j, Ti(j,g))
                               + sum(tr, Gtr(g,tr)) + sum(h, Fen(g, h)) + sum(gg, G2g(gg,g));
eqGtotS(g)..   Gtot(g)  =e= Sg(g) + sum(i, pq(i)*Xg(i,g))  + sum(gg, G2g(g,gg)) + Hg(g) + sum(tr, Trg(g, tr));

                        
* Savings
eqSg(g)..     Sg(g)  =e= ssg(g)*Gtot(g);
eqSh..        Sh     =e= ssh*Hbud;
eqSf(tr)..    TRv(tr) + sum(i,epsilon*pm(i)*M(i)) + sum(h, Fen("TRD",h)) + sum(g, Trg(g, tr)) + Trh(tr)=e=
               Sf(tr) + sum(i, epsilon*pe(i)*E(i))  + Htr(tr) + sum(g, Gtr(g,tr));

* Investment
eqXv(i)..     Xv(i)   =e= lambda(i)*Stot/pq(i);
eqGv(g)..     Gv(g)   =e= invest_g_rt(g)*Stot;
eqHv..        Hv      =e= invest_h_rt*Stot;
eqTRv(tr)..   TRv(tr) =e= invest_t_rt(tr)*Stot;

* international trade
*eqpe(i)..   pe(i)  =e= epsilon*pWe(i);
*eqpm(i)..   pm(i)  =e= epsilon*pWm(i);
*eqepsilon.. sum(i, pWe(i)*E(i)) + Sf("TRD") =e= SAM("TRD", "CAP") + sum(i, pWm(i)*M(i));


* corporations
eqCrv..   Crv =e= alpha_c*(Re**beta_c);
eqCpr..   Cpr =e= pf('PROF')*(Crv - rr*Re)*(1 - div_rt - sum(g, tax_c_rt(g)));
eqCF..    Fen("CORP", "PROP") =e= Cpr;

* Close factor market
eqFM(h)..   sum(fe, Fen(fe, h)) =g= sum(j, F(h,j));

* Market clearing condition
eqpqd(i)..   pq(i)*Q(i)   =e=  pq(i)*Xp(i) + sum(g,  pq(i)*Xg(i,g)) + pq(i)*Xv(i) + sum(j, pq(j)*X(i,j));
eqpqu(i)..   Q(i)*pq(i)   =e= epsilon*pm(i)*M(i) + pd(i)*D(i);

*eqpcdu(i)..  CD(i)*pcd(i) =e= pmd(i)*MD(i) + pld(i)*LD(i);


*** Armington functions
** Imports
eqpqs(i)..     Q(i)  =e= gamma(i)*((deltam(i)*M(i)**eta_q(i)+deltad(i)*D(i)**eta_q(i))**(1/eta_q(i)));

eqM(i)..       M(i)  =e= ((gamma(i)**eta_q(i)*deltam(i)*pq(i)/pm(i))**(1/(1-eta_q(i))))*Q(i);

eqD(i)..       D(i)  =e= ((gamma(i)**eta_q(i)*deltad(i)*pq(i)/pd(i))**(1/(1-eta_q(i))))*Q(i) + slack_2(i);

** Exports
eqpzd(i)..                 Z(i)   =e=  theta(i)*(xie(i)*E(i)**phi(i)+xid(i)*D(i)**phi(i))**(1/phi(i));

eqE(i)$ (xie(i) > 0)..     E(i)   =e= ((theta(i)**phi(i)*xie(i)*(1+tax_z_rt(i))*pz(i)/pe(i))**(1/(1-phi(i))))*Z(i)  ;

eqDs(i)..                  D(i)   =e= ((theta(i)**phi(i)*xid(i)*(1+tax_z_rt(i))*pz(i)/pd(i))**(1/(1-phi(i))))*Z(i);

*** Capital Column = Capital Row
 eqbop..      Stot =n= Itot;

* fictitious objective function
obj..       UU     =e= prod(i, Xp(i)**beta_util(i));



* Set zero vars to zero


* Initializing variables

UU.l  = prod(i, Xp0(i)**beta_util(i));

Y.l(j)      = Y0(j);
F.l(h,j)    = F0(h,j);
Fen.l(fe,h) = Fen0(fe,h);

X.l(i,j)    = X0(i,j);
Z.l(i)      = Z0(i);
Xp.l(i)     = Xp0(i);

Indtot.l(i) = sum(u, SAM(i, u));
Stot.l      = sum(u, SAM("CAP", u));
Gtot.l(g)   = sum(u, SAM(g, u));
Itot.l      = Stot0;

Hbud.l      = Hbud0;
TRh.l(tr)   = TRh0(tr);
Htr.l(tr)   = Htr0(tr);
Hc.l        = Cpr0*div_rt;

Tz.l(j,g)   = Tz0(j,g);
Td.l(g)     = Td0(g);
Tc.l(g)     = Tc0(g);
Tk.l(g)     = Tk0(g);
Ti.l(j,g)   = Ti0(j,g);
Gtr.l(g,tr) = Gtr0(g,tr);

Sg.l(g)       = Sg0(g);
Xg.l(i,g)     = Xg0(i,g);
Hg.l(g)       = gov_hoh_rt(g)*Gtot0(g);   
Trg.l(g,tr)   = gov_trd_rt(g,tr)*Gtot0(g);
G2g.l(g,gg)   = gov_gov_rt(g,gg)*Gtot0(g);

Sf.l(tr)   = SAM("CAP", tr);

Xv.l(j)    = Xv0(j);
Gv.l(g)    = Gv0(g);
Hv.l       = Hv0;       
TRv.l(tr)  = TRv0(tr);

E.l(i)     = E0(i);   
M.l(i)     = M0(i);   
Q.l(i)     = Q0(i);   
D.l(i)    = D0(i);  

Crv.l   = alpha_c*(Re0**beta_c);
Cpr.l   = Cpr0;
Re.l    = Re0;

Sg.l(g)   = Sg0(g);
Sh.l      = Sh0;

pf.l(h)   = 1;
py.l(j)   = 1;
pz.l(j)   = 1;
pq.l(i)   = 1;
pm.l(i)   = 1;
pmd.l(i)  = 1;
pe.l(i)   = 1;
pd.l(i)   = 1;
pWe.l(i)  = 1;
pWm.l(i)  = 1;

epsilon.l = 1;


* Bounds
Xp.lo(i)$(Xp0(i) > 0)       = 0.0001;
Xp.fx(i)$(Xp0(i) = 0)       = 0;
X.lo(i,j)$(X0(i,j) > 0)     = 0.0001;
X.fx(i,j)$(X0(i,j) = 0)     = 0;
Fen.lo(fe,h)$(Fen0(fe,h)>0) = 0.0001;
Fen.fx(fe,h)$(Fen0(fe,h)=0) = 0;
F.lo(h,j)$(F0(h,j) > 0)     = 0.0001;
F.fx(h,j)$(F0(h,j) = 0)     = 0;
D.lo(i)$(D0(i) > 0)         = 0.0001;
D.fx(i)$(D0(i) = 0)         = 0;
M.lo(i)$(M0(i) > 0)         = 0.0001;
M.fx(i)$(M0(i) = 0)         = 0;
E.lo(i)$(E0(i) > 0)         = 0.0001;
E.fx(i)$(E0(i) = 0)         = 0;
Xv.lo(i)$(Xv0(i) > 0)       = 0.0001;
Xv.fx(i)$(Xv0(i) = 0)       = 0;

Re.lo = 0.0001;

pf.lo(h)   = 0.0001;
py.lo(j)   = 0.0001;
pz.lo(j)   = 0.0001;
pq.lo(i)   = 0.0001;
pm.lo(i)   = 0.0001;
pmd.lo(i)  = 0.0001;
pe.lo(i)   = 0.0001;
pd.lo(i)   = 0.0001;

* maybe need this?
Fen.fx(fe,h)$(not sameas(fe, "CORP")) = Fen0(fe,h);
*Fen.fx(fe,h) = Fen0(fe,h);
pf.fx(h) = 1;

* small region assumption => no impact on foreign prices
pm.fx(i) = 1;
pe.fx(i) = 1;

* remove this eventually, added slack to help convergence
slack_1.l(i)  =  0;
slack_1.up(i) =  0.001;
slack_1.lo(i) = -0.001;
slack_2.fx(i)  =  0;
slack_2.up(i) =  0.001;
slack_2.lo(i) = -0.001;

* numeraire
* pf.fx("LAB") = 1;

Model stdcge / all /;

solve stdcge maximizing UU using nlp;

* Debugging some initial values
Parameter
    Hg0(g)
    Crv0
    Ng0(g)
;
Hg0(g) = gov_hoh_rt(g)*Gtot0(g);
Crv0   = alpha_c*(Re0**beta_c);



display Sf.l, tax_i_rt, Tz.l, slack_1.l, slack_2.l, Htr.l;

display Y.l, X.l, Z.l, Sg.l, Trg.l, Xg.l, pq.l, mu, Re.l, Crv.l, Cpr.l, Gv.l, Tz.l, Xp.l, Fen.l, F.l, Trg.l, Td.l
        Ti.l, Hbud.l, Sg.l, Gtr.l, Gtot.l, Sh.l, Stot.l, Itot.l, Indtot.l, 
        Q.l, M.l, D.l, E.l, pf.l, pq.l, pd.l, pz.l,pm.l, epsilon.l;



*gdp_scl('ELC_BECCS') = gdp_scl('ELC_BECCS')*1.1;

*tax_i_rt('FER',g) = -10;

*solve stdcge maximizing UU using nlp;

display Tz.l, Ti.l;

* List8.1: Display of changes
Parameter
   dY(j), dF(h,j), dX(i,j), dZ(j),    dXp(i),     dXg(i,g), dXv(i)
   dE(i), dM(i),   dQ(i),   dD(i),    dpf(h),     dpy(j),   dpz(i), dpq(i)
   dpe(i),dpm(i),  dpd(i),  depsilon;


dF(h,j)  $(F0(h,j) > 0)  = (F.l(h,j)/F0(h,j)-1)*100;
dXp(i)   $(Xp0(i) > 0)   = (Xp.l(i) /Xp0(i) -1)*100;
dXg(i,g) $(Xg0(i,g) > 0) = (Xg.l(i,g) /Xg0(i,g) -1)*100;
dXv(i)   $(Xv0(i) > 0)   = (Xv.l(i) /Xv0(i) -1)*100;
dE(i)    $(E0(i) > 0)    = (E.l(i)  /E0(i)  -1)*100;
dX(i,j)  $(X0(i,j) > 0)  = (X.l(i,j)/X0(i,j)-1)*100;
dM(i)    $(M0(i) > 0)    = (M.l(i)  /M0(i)  -1)*100;


dY(j)    = (Y.l(j)/Y0(j)  -1)*100;
dZ(j)    = (Z.l(j)/Z0(j)  -1)*100;
dQ(i)    = (Q.l(i)/Q0(i)  -1)*100;
dD(i)    = (D.l(i)/D0(i)  -1)*100;
depsilon = (epsilon.l/1   -1)*100;

dpf(h)   = (pf.l(h) /1 -1)*100;
dpy(j)   = (py.l(j) /1 -1)*100;
dpz(j)   = (pz.l(j) /1 -1)*100;
dpq(i)   = (pq.l(i) /1 -1)*100;
dpe(i)   = (pe.l(i) /1 -1)*100;
dpm(i)   = (pm.l(i) /1 -1)*100;
dpd(i)   = (pd.l(i) /1 -1)*100;

display Gtot.l, Stot.l;

display dY,  dF,  dX,  dZ,  dXp,      dXg, dXv, dE,  dM,  dQ, dD, dpf, dpy, dpz
        dpq, dpe, dpm, dpd, depsilon;


Set t 'time iterations' / 0*30 /;

Parameter
    Z_run_sum(i) 'Running sum of Z' 

    Res_Z(i,t)   'Results for Z (production) of good i in iteration t'
    Res_pz(i,t)  '... ... for price of Z ... '

    Res_Q(i,t)       'Results for Q ...'
    Res_Xp(i,t)      '...         household consumption'
    Res_Xg(i,g,t)    '...         gov consumption'
    Res_E(i,t)       '...         E ...'
    Res_M(i,t)       '...         M ...'
    Res_Zpz(i,t)     '...         Z*pz ...'
    Res_Xv(i,t)      '...         industry investment'
    Res_TRv(tr,t)    '...         investment demand for non-local institutions'
    Res_TrdDef(tr,t) 'Trade deficit'
    
    iteration_count
    
    efficiency_0_gdp_scl(i)  'initial gdp_scl'
    efficiency_0_theta(i)    'initial theta'
    efficiency_0_gamma(i)    'initial theta'

    tax0_z_rt(i)        'initial tax rates'
    Res_tax(i,t)        'tax rates over time'  
    elc_conv            'conversion rate from $ to MWh'
    co2_output_rt(i)    'co2 produced per MWh'
    co2_tax_rt(t)       'tax $ per ton of co2'
    Res_co2(t)          'co2 output of region'
    
    L_Mult(t)    'Learning multiplier'
    L_max        'Maximum Learning Improvement'
    L_curve      'Rate of learning increase'

    debug(i,t)
    debug2(i,t)
;

Alias (t,tt);

efficiency_0_gdp_scl(i) = gdp_scl(i);
efficiency_0_theta(i)   = theta(i);
efficiency_0_gamma(i)   = gamma(i);

tax0_z_rt(i) = tax_z_rt(i);
elc_conv = 74;
co2_output_rt(i) = 0;
co2_output_rt('ELC_BECCS') = -0.396;
co2_output_rt('ELC_FF')    =  0.331;
Res_co2(t) = 0;

L_max = 1.4;
L_curve = 8*10**(-5);

Z_run_sum(i) = 0;
Res_Z(i,t) = Z.l(i);
iteration_count = 0;

loop(t,


    iteration_count = iteration_count + 1;
    L_mult(t) = L_max + (1-L_max)*exp(Z_run_sum('ELC_BECCS')*(-L_curve));
    co2_tax_rt(t) = (-6.6667 + 6.6666*iteration_count)/1e6;


    tax_z_rt(i) = tax0_z_rt(i) + 3*co2_output_rt(i)*co2_tax_rt(t)*elc_conv/pz.l(i);
    debug(i,t)  = co2_tax_rt(t)*1e6;
    debug2(i,t) = tax_z_rt(i);

    
    gdp_scl('ELC_BECCS')  = efficiency_0_gdp_scl('ELC_BECCS') * L_mult(t);
    theta_fac('ELC_RNW')  = theta_fac('ELC_RNW')  *0.98;

    solve stdcge maximizing UU using nlp;

    loop(i,
        Z_run_sum(i)     = Z_run_sum(i)+Z.l(i);
        Res_Z(i,t)       = Z.l(i);
        Res_Q(i,t)       = Q.l(i);
        Res_E(i,t)       = E.l(i);
        Res_M(i,t)       = M.l(i);
        Res_pz(i,t)      = pz.l(i);
        Res_Xp(i,t)      = Xp.l(i);
        Res_Xg(i,g,t)    = Xg.l(i,g);
        Res_Zpz(i,t)     = Z.l(i)*pz.l(i);
        Res_Xv(i,t)      = Xv.l(i);
        Res_tax(i,t)     = tax_z_rt(i);
    );

    loop(tr,
        Res_TRv(tr,t)    = TRv.l(tr);
        Res_TrdDef(tr,t) = sum(j, E.l(j) - M.l(j));
     );

*   possibly issues with units here
    Res_co2(t) = sum(i, co2_output_rt(i)*elc_conv*Z.l(i));

*   speed up convergence with guess
    Z.l('ELC_BECCS') = Z.l('ELC_BECCS')*1.1;
    loop(i,
* pz.l(i) = pz.l(i)*(1*0.999+(pz.l(i)/Res_pz(i, t-1))*0.0001);
    );
    Z.l('ELC_RNW') = Z.l('ELC_RNW')*(1.01**iteration_count);
*    Z.l(i) = Z0(i)*1;

    
);

display L_mult, gdp_scl, debug, debug2, Res_Z, Res_Zpz, Res_Q, Res_E, Res_M, Res_pz,
            Res_xp, Res_Xg, Res_TRv, Res_TrdDef, Res_co2, Res_tax;

execute_unload 'results.gdx', Res_Zpz, Res_Z, Res_co2, Res_tax, Res_pz, co2_tax_rt, L_mult;


$ontext
Set t 'time iterations' / 1*5 /
    s 'tax  iterations' / 1*3  /;

Parameter
    Z_run_sum(i,s) 'Running sum of Z' 

    Res_Z(i,t,s)   'Results for Z (production) of good i in iteration t'
    Res_pz(i,t,s)  '... ... for price of Z ... '

    Res_Q(i,t,s)       'Results for Q ...'
    Res_Xp(i,t,s)      '...         household consumption'
    Res_Xg(i,g,t,s)    '...         gov consumption'
    Res_E(i,t,s)       '...         E ...'
    Res_Zpz(i,t,s)     '...         Z*pz ...'
    Res_Xv(i,t,s)      '...         industry investment'
    Res_TRv(tr,t,s)    '...         investment demand for non-local institutions'
    Res_TrdDef(tr,t,s) 'Trade deficit'
    
    iteration_count
    
    efficiency_0_gdp_scl 'initial gdp_scl'
    efficiency_0_theta   'initial theta'
    efficiency_0_gamma   'initial theta' 
    tax_0_z              'initial tax rate'
    
    L_Mult(t,s)    'Learning multiplier'
    L_max          'Maximum Learning Improvement'
    L_curve        'Rate of learning increase'

    debug(i,t,s) 'debug'
;

Alias (t,tt), (s,ss);

* initial values
efficiency_0_gdp_scl = gdp_scl('ELC_BECCS');
efficiency_0_theta   = theta('ELC_BECCS');
efficiency_0_gamma   = gamma('ELC_BECCS');
tax_0_z = tax_z_rt('ELC_FF');

* Learning params
L_max   = 1.3;
L_curve = 5*10**(-4);

* Running values
Z_run_sum(i,s)  = 0;
Res_Z(i,t,s)    = Z.l(i);

loop(s,

    iteration_count = 0;

    loop(t,

        iteration_count = iteration_count + 1;    
    
        L_mult(t,s) = L_max + (1-L_max)*exp(Z_run_sum('ELC_BECCS',s)*(-L_curve));
    
        tax_z_rt('ELC_FF') = tax_0_z+(iteration_count*0.1);
        debug('ELC_FF', t, s) =     tax_z_rt('ELC_FF');
        
        gdp_scl('ELC_BECCS')  = efficiency_0_gdp_scl * L_mult(t,s);
*       theta('ELC_BECCS')    = efficiency_0_theta * L_mult(t);
*       gamma('ELC_BECCS')    = efficiency_0_gamma * L_mult(t);
    
        solve stdcge maximizing UU using nlp;
    
        loop(i,
            Z_run_sum(i,s)     = Z_run_sum(i,s)+Z.l(i);
            Res_Z(i,t,s)       = Z.l(i);
            Res_Q(i,t,s)       = Q.l(i);
            Res_E(i,t,s)       = E.l(i);
            Res_pz(i,t,s)      = pz.l(i);
            Res_Xp(i,t,s)      = Xp.l(i);
            Res_Xg(i,g,t,s)    = Xg.l(i,g);
            Res_Zpz(i,t,s)     = Z.l(i)*pz.l(i);
            Res_Xv(i,t,s)      = Xv.l(i);
        );
    
        loop(tr,
            Res_TRv(tr,t,s)    = TRv.l(tr);
            Res_TrdDef(tr,t,s) = sum(j, E.l(j) - M.l(j));
         );
    
        Z.l(i) = Z0(i)*1.01;
        
    );
);

display debug;
display L_mult, gdp_scl, Res_Z, Res_Zpz, Res_Q, Res_E, Res_pz, Res_xp, Res_Xg, Res_TRv, Res_TrdDef;

execute_unload 'results.gdx', Res_Zpz, Res_Z;

$offtext








