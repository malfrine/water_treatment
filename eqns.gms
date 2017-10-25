$Title eqns

$Ontext

The equations for the MINLP algorithm are provided in this file

$Offtext


*ML of C to be Removed from System
*equation eq17(c); eq17(c) .. ML_rem_c(c) =e= sum( s, F_s(s) * (C_c_s(s,c) - C_target(c,'hrsg')) );

*Production to Source Mass Balance
*equation eq4; eq4 .. sum(s, F_s(s)) - F_BFW =e= sum(tu, F_loss(tu)) ;
equation eq4(s);
eq4('muw') .. F_s('muw') =e= sum(tu, F_loss(tu));
eq4('pw') .. F_s('pw') =e= F_pro('wi');
eq4('bbd') .. F_s('bbd') =e= F_pro('eg') + F_rec_otsg_bbd;

*Splitter 1 Mass Balance
equation eq5(s); eq5(s) .. F_s(s) =e= sum(tu, F_s_tu(s,tu)) ;

*Limiting Flow from S to TU
equation eq21(s,tu); eq21(s,tu) .. F_s_tu(s,tu) - B_s_tu(s,tu) * Bound_up =l= 0 ;
equation eq25(s,tu); eq25(s,tu) .. F_s_tu(s,tu) - B_s_tu(s,tu) * Bound_low =g= 0 ;

*Mixer 1 Mass Balance
equation eq6(tu); eq6(tu) .. sum(s, F_s_tu(s,tu)) + sum(tup, F_rec(tup,tu))  =e= F_in(tu) ;


*Limiting TU Inlet Flow
equation eq24(tu); eq24(tu) .. F_in(tu) - B_tu(tu) * Bound_up * 2 =l= 0 ;
equation eq28(tu); eq28(tu) .. F_in(tu) - B_tu(tu) * Bound_low =g= 0 ;

*TU Mass Balance
equation eq9(tu); eq9(tu) .. F_in(tu) - F_out(tu) =e= F_loss(tu) ;

*TU Component Mass Balance
equation eq12(tu,c); eq12(tu,c) .. sum(tup, F_rec(tup,tu) * C_out(tup,c)) + sum(s, F_s_tu(s,tu) * C_c_s(s,c)) =e= ML_in(tu,c) ;
equation eq13(tu,c,sgu); eq13(tu,c,sgu) .. C_out(tu,c) * ( sum(tup, F_rec(tu,tup)) + F_exit(tu,sgu) ) =e= ML_out(tu,c) ;
equation eq10(tu,c); eq10(tu,c) .. (1 - RR(tu,c)) * ML_in(tu,c) - ML_out(tu,c) - F_loss(tu) * C_loss(tu,c) =e= 0 ;
*equation eq11(tu,c); eq11(tu,c) .. ML_in(tu,c) - ML_out(tu,c) - ML_rem_tu_c(tu,c) =e= F_loss(tu) * C_loss(tu,c) ;

*Concentration Limit for TUs
equation eq14(tu,c); eq14(tu,c) .. ML_in(tu,c) =l= C_in_max(tu,c) * F_in(tu);

*Splitter 2 Mass Balance - Recycle
equation eq7(tu,sgu); eq7(tu,sgu) .. F_out(tu) =e= sum(tup, F_rec(tu,tup)) + F_exit(tu,sgu) ;

*Eliminiating Repeated Recycle
equation eq19(tu,tup); eq19(tu,tup)$(ord(tup) ne ord(tu)) .. B_tu_tup(tu,tup) + B_tu_tup(tup,tu) =l= 1 ;

*Limiting Maximum Number of Strems in TU
equation eq29(tu); eq29(tu) .. sum(s, B_s_tu(s,tu)) + sum( tup, B_tu_tup(tu,tup)) =l= NS_max(tu) ;

*Limiting Flow from Recycles
equation eq22(tu,tup); eq22(tu,tup) .. F_rec(tu,tup) - B_tu_tup(tu,tup) * Bound_up =l= 0 ;
equation eq26(tu,tup); eq26(tu,tup) .. F_rec(tu,tup) - B_tu_tup(tu,tup) * Bound_low =g= 0 ;

*Mixer 3 Mass Balance
equation eq8(sgu); eq8(sgu) .. sum(tu, F_exit(tu,sgu)) =e= F_in_sgu(sgu) ;

*Mixer 3 Component Mass Balance
equation eq30(c,sgu); eq30(c,sgu) .. sum(tu, F_exit(tu,sgu) * C_out(tu,c)) =e= C_sgu(c,sgu) * F_in_sgu(sgu) ;

*Limiting TU Exit Flow
equation eq23(tu,sgu); eq23(tu,sgu) .. F_exit(tu,sgu) - B_exit(tu,sgu) * Bound_up =l= 0 ;
equation eq27(tu,sgu); eq27(tu,sgu) .. F_exit(tu,sgu) - B_exit(tu,sgu) * Bound_low =g= 0 ;

*sgu Concentration Requirements
equation eq15(c,sgu); eq15(c,sgu) .. C_sgu(c,sgu) * F_in_sgu(sgu) =l= C_target(c,sgu) * sum(tu, F_exit(tu,sgu)) ;

*Constraint to Ensure ML of C is Removed from the System
*equation eq16(c); eq16(c) .. ML_rem_c(c) =l= sum(tu, RR(tu,c) * ML_in(tu,c)) ;

*sgu Mass Balance
equation eq31(sgu);
eq31('hrsg') .. F_in_sgu('hrsg') =e= sum(pro, F_exit_sgu('hrsg',pro));
eq31('db') .. F_in_sgu('db') =e= sum(pro, F_exit_sgu('db',pro));
eq31('otsg') .. F_in_sgu('otsg') =e= sum(pro, F_exit_sgu('otsg',pro)) + F_rec_otsg_bbd;

*Mixer 4 Mass Balance
equation eq32(pro); eq32(pro) .. sum(sgu, F_exit_sgu(sgu,pro)) =e= F_pro(pro);

*wi Flow Demand
equation dem_F; dem_F .. F_pro('wi') =e= F_wi_demand;

*Power Generation Demand
equation dem_pow; dem_pow .. a_hrsg * F_in_sgu('hrsg') + a_eg * F_pro('eg') =e= pow_demand;

*Cost / Energy of TUs
equation eq18(tu); eq18(tu) .. Cost_tot_tu(tu) =e= Cost_var_tu_a(tu) * F_in(tu) + Cost_var_tu_b(tu) * B_tu(tu) + cost_fix_tu_a(tu) * F_in(tu) + cost_fix_tu_b(tu) * B_tu(tu);

*Cost / Energy of System
equation eq2; eq2 .. Cost_tot =e= sum(tu, Cost_tot_tu(tu)) + HY * sum(s, F_s(s) * cost_var_s(s)) ;

*Objective Equation
equation objective; objective .. obj =e= Cost_tot ;









