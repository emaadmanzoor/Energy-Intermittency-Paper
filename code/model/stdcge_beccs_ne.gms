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
   u     'SAM entry' / AGR_CRP,AGR_LIV,CAP,CORP,ELC_BIOMASS,ELC_DIST,ELC_FF,
                    ELC_HYDRO,ELC_NUC,ELC_OTHER,ELC_SOLAR,ELC_WIND,FORE,GOV_FED,GOV_FED_EMP,
                    GOV_FED_ENT,GOV_STT,GOV_STT_EMP,GOV_STT_ENT,HOH,LAB,MAN,NonIndustry,PAP,
                    PROF,PROP,SER,TAX,TRD,ELC_BECCS,ELC_RNW  /
   i(u)  'goods'     / AGR_CRP,AGR_LIV,ELC_BIOMASS,ELC_DIST,ELC_FF,
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
,AGR_CRP,AGR_LIV,CAP,CORP,ELC_BIOMASS,ELC_DIST,ELC_FF,ELC_HYDRO,ELC_NUC,ELC_OTHER,ELC_SOLAR,ELC_WIND,FORE,GOV_FED,GOV_FED_EMP,GOV_FED_ENT,GOV_STT,GOV_STT_EMP,GOV_STT_ENT,HOH,LAB,MAN,NonIndustry,PAP,PROF,PROP,SER,TAX,TRD,ELC_BECCS,ELC_RNW
AGR_CRP,4580.374579,78.526910,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,93.082521,-0.000000,-0.000000,0.000000,3.152626,-0.000000,-0.000000,2172.818131,-0.000000,2608.364541,31.030356,0.000000,-0.000000,-0.000000,693.241526,0.000000,2021.511672,2.807468,-0.000000
AGR_LIV,3.847129,8115.833397,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,60.062313,-0.000000,-0.000000,0.000000,4.852484,-0.000000,-0.000000,942.081617,-0.000000,6746.229890,27.150570,0.000000,-0.000000,-0.000000,639.020279,0.000000,748.284697,0.000000,-0.000000
CAP,0.000000,0.000000,0.000000,52469.513148,0.000000,0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,383027.230893,0.000000,0.000000,0.000000,0.000000,0.000000,527071.263600,0.000000,0.000000,806877.783870,0.000000,0.000000
CORP,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,353995.776844,0.000000,0.000000,0.000000,0.000000,0.000000
ELC_BIOMASS,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,330.604249,0.000000,197.515720
ELC_DIST,249.036922,264.772577,-0.000000,-0.000000,1.909475,53038.289724,96.552203,147.552450,116.419590,1.103314,2.446492,3.152432,193.974608,314.759140,-0.000000,145.041499,1910.948997,-0.000000,275.875999,28210.460224,0.000000,7648.604733,0.000000,1031.647928,0.000000,-0.000000,29948.266514,0.000000,8455.045122,10.347819,0.000000
ELC_FF,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,27846.869346,-0.000000,-0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1916.664244,0.000000,0.000000
ELC_HYDRO,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,-0.000000,0.000000,1092.989856,-0.000000,-0.000000,3818.903014,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,741.824158,0.000000,27014.058745
ELC_NUC,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1511.324991,0.000000,9367.700255
ELC_OTHER,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,323.832676,0.000000,109.678608
ELC_SOLAR,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,-0.000000,364.101115,0.000000,125.306480
ELC_WIND,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,312.499257,0.000000,72.368723
FORE,763.873856,352.413026,-0.000000,-0.000000,2.390680,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,3103.186535,-0.000000,-0.000000,-0.000000,2.913839,-0.000000,-0.000000,542.191860,-0.000000,1239.900632,-0.000000,348.272475,-0.000000,-0.000000,604.244475,-0.000000,485.484084,9.534452,-0.000000
GOV_FED,0.000000,0.000000,15470.364039,79152.341997,0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,0.000000,365487.227685,239159.829122,0.000000,0.000000,0.000000,12464.446343,8546.760632,0.000000,24314.917185,427.044212,0.000000,0.000000
GOV_FED_EMP,0.000000,0.000000,0.000000,-0.000000,0.000000,0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,84925.641459,84762.068024,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
GOV_FED_ENT,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,1497.013514,78.074607,118.989799,55.968687,-0.000000,0.000000,-0.000000,0.000000,132.603846,-0.000000,10464.913706,351.106260,-0.000000,25.376731,1317.875966,-0.000000,262.347348,-0.000000,0.000000,-0.000000,-0.000000,11209.430868,-0.000000,694.051525,42.823686,-0.000000
GOV_STT,0.000000,0.000000,124014.792315,22634.221314,0.000000,0.000000,0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,116892.821338,0.000000,0.000000,0.000000,-0.000000,0.000000,135218.053619,4120.987991,0.000000,0.000000,0.000000,0.000000,10449.961488,0.000000,222375.947837,14524.453876,0.000000,0.000000
GOV_STT_EMP,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,283273.120590,290518.457072,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
GOV_STT_ENT,0.000000,0.000000,0.000000,-0.000000,0.000000,4050.744595,95.645884,2726.672646,40.330576,-0.000000,0.000000,-0.000000,0.000000,214.762836,0.000000,24.695265,619.345986,-0.000000,13387.472474,11582.886365,0.000000,8664.601733,0.000000,152.729936,0.000000,0.000000,16982.906100,0.000000,11772.729325,27.722442,0.000000
HOH,0.000000,0.000000,81541.049282,199739.780364,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,477056.576602,-0.000000,0.000000,167723.838603,-0.000000,-0.000000,0.000000,1844581.732664,0.000000,0.000000,0.000000,263409.085002,275974.095715,0.000000,0.000000,29777.341406,0.000000,-0.000000
LAB,2414.438714,1138.128334,-0.000000,-0.000000,279.587637,6604.308050,3250.109538,151.601176,2451.030451,203.127847,222.904118,257.875277,1673.641163,-0.000000,37062.222188,12225.083257,-0.000000,251962.778790,22736.423388,0.000000,0.000000,235775.002647,15644.460138,6285.531665,0.000000,-0.000000,1518219.520118,0.000000,0.000000,426.394724,134.670635
MAN,537.133055,1216.511852,152908.417061,-0.000000,1.839854,7.966042,5929.632009,290.297642,1111.927384,1.439044,2.809091,1.456079,215.854281,9684.537699,-0.000000,14.401553,47907.015340,-0.000000,6159.410290,166619.212850,-0.000000,880600.203441,3607.304619,4029.815450,0.000000,-0.000000,106702.170145,0.000000,469530.225013,62.403568,-0.000000
NonIndustry,30.263061,20.965258,4584.886207,-0.000000,0.000000,0.000000,66.155156,79.133181,52.946257,-0.000000,0.000000,-0.000000,33.408471,791.241981,-0.000000,10.553359,5.507843,-0.000000,-0.000000,10743.609002,0.000000,2989.034461,2.215732,154.664590,0.000000,-0.000000,5058.477131,0.000000,1084.667245,1.014543,-0.000000
PAP,13.224329,9.088781,-0.000000,-0.000000,-0.000000,-0.000000,62.299690,-0.000000,54.827206,-0.000000,-0.000000,-0.000000,-0.000000,191.892705,-0.000000,16.117515,1058.888447,-0.000000,2.231966,3262.437910,-0.000000,6582.161763,75.603005,25661.878703,-0.000000,-0.000000,5048.155392,-0.000000,18454.489550,0.999540,-0.000000
PROF,512.430976,769.679701,-0.000000,-0.000000,3.699295,714.042399,477.346473,166.066304,-0.000000,1.074867,32.677037,40.208798,984.413495,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,52777.555471,0.000000,397.687431,0.000000,-0.000000,218879.086409,0.000000,0.000000,66.736907,50.830436
PROP,610.339168,870.951528,0.000000,-0.000000,210.314892,12699.856277,6092.813066,454.670586,3060.988605,224.352380,223.226054,76.738588,0.000000,-0.000000,47863.432247,428.344660,-0.000000,31310.371815,0.000000,0.000000,0.000000,140161.296557,0.000000,3627.410149,0.000000,0.000000,927584.299118,0.000000,0.000000,282.005285,256.426749
SER,1242.260804,1541.975589,190650.839368,-0.000000,26.829527,340.811740,3201.609602,489.213368,2173.612101,1.490059,2.998432,3.587635,508.200276,38500.853897,-0.000000,1188.001582,81639.037717,-0.000000,14337.232984,1904618.834513,-0.000000,205752.699592,1560.988515,8343.209990,0.000000,-0.000000,4811140.552797,0.000000,795163.036375,74.197643,-0.000000
TAX,26.884405,88.947581,-0.000000,-0.000000,0.000000,5860.682551,2598.820137,-0.000000,-0.000000,-0.000000,0.000000,-0.000000,71.327918,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,-0.000000,0.000000,0.000000,20109.526576,0.000000,240.890906,0.000000,-0.000000,217512.985549,0.000000,0.000000,102.033682,78.772114
TRD,1300.744470,2819.515467,1200275.448484,-0.000000,1.570180,9235.419832,7814.520697,196.691601,1761.076610,0.999258,2.282070,1.852065,517.216826,16317.227192,-0.000000,527.015391,65731.474805,-0.000000,9432.369134,326058.587261,31256.269726,285224.443799,4760.010881,10220.486190,0.000000,-0.000000,192279.704970,0.000000,0.000000,0.000000,-0.000000
ELC_BECCS,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,609.747299,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,113.414240,-0.000000,-0.000000,168.005881,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,-0.000000,217.905215,11.715674,-0.000000
ELC_RNW,0.000000,0.000000,0.000000,-0.000000,0.000000,37407.322681,-0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,-0.000000,-0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
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
    Z.l('ELC_BECCS') = Z.l('ELC_BECCS')*1.001;
    pz.l('ELC_BECCS') = pz.l('ELC_BECCS')*0.999;
    Z.l('ELC_RNW') = Z.l('ELC_RNW')*(1.01**iteration_count);
    Z.l('ELC_BECCS') = Z.l('ELC_BECCS')*0.999;
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








