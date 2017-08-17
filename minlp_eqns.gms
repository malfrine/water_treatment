$Title minlp_eqns

$Ontext

The variables for the MINLP algorithm are provided in this file

$Offtext

Equations
    eq4				'overall mass balance'   
    eq5(s)  		'mass balance around splitter 1'
    eq6(tu)   		'mass balance around mixer 1'
	eq7(tu)			'mass balance around splitter 2'
	eq8				'mass balance around mixer 3'
	eq9(tu)			'mass balance around tu'
	eq12(tu,c)		'definition of ML_in'
	eq13(tu,c)		'definition of ML_out'
	eq10(tu,c)		'component mass balance around each tu - 1'
	eq11(tu,c)		'component mass balance around each tu - 2'
	eq14(tu,c)		'concentration limit for tu inlet'
	eq15(c)			'discharge concentration to meet BFW requirement'
	eq16(c)			'total mass load of c removed from system'
	eq18(tu)		'cost of tu'
	eq19(tu)		'eliminating cycles'
	eq21(s,tu)		's,tu upper bound'
	eq22(tu)		'tu,tup upper bound'
	eq23(tu)		'exit tu upper bound'
	eq24(tu)		'in tu upper bound' 
	eq25(s,tu)		's,tu lower bound'
	eq26(tu)		'tu,tup lower bound'
	eq27(tu)		'exit tu lower bound'
	eq28(tu)		'in tu lower bound'
	eq29(tu)		'maximum number of streams going through a tu'
	OF_cost			'objective cost function' ;

eq4 ..			sum(s, F_s(s)) - F_BFW =e= sum(tu, F_loss(tu)) ;

eq5(s) ..		F_s(s) =e= sum(tu, F_s_tu(s,tu)) ;

eq6(tu) ..	    sum(s, F_s_tu(s,tu)) + sum(tup$(ord(tup) ne ord(tu)), F_rec(tu,tup))  =e= F_in(tu) ;

eq7(tu) ..		F_out(tu) =e= sum(tup$(ord(tup) ne ord(tu)), F_rec(tu,tup)) + F_exit(tu) ;

eq8 ..			sum(tu, F_exit(tu)) =e= F_BFW ;

eq9(tu) ..		F_in(tu) - F_out(tu) =e= F_loss(tu) ;

eq12(tu,c) ..	sum(tup$(ord(tup) ne ord(tu)), F_rec(tu,tup) * C_rout(tu,tup,c)) + sum(s, F_s_tu(s,tu) * C_c_s(s,c)) =e= ML_in(tu,c) ;

eq13(tu,c) ..	C_out(tu,c) * ( sum(tup$(ord(tup) ne ord(tu)), F_rec(tu,tup)) + sum(s, F_s_tu(s,tu) ) - F_loss(tu) ) =e= ML_out(tu,c) ;

eq10(tu,c) ..	(1 - RR(tu,c)) * ML_in(tu,c) - ML_out(tu,c) - F_loss(tu) * C_loss(tu,c) =e= 0 ;

eq11(tu,c) ..	ML_in(tu,c) - ML_out(tu,c) - ML_rem_tu_c(tu,c) =e= F_loss(tu) * C_loss(tu,c) ;
				
eq14(tu,c) ..	ML_in(tu,c) =l= C_in_max(tu,c) * F_in(tu) ;		

eq15(c) ..		sum(tu, F_exit(tu) * C_out(tu,c)) =l= C_target(c) * sum(tu, F_exit(tu)) ;

eq16(c) ..		ML_rem_c(c) =l= sum(tu, ML_rem_tu_c(tu,c)) + sum(tu, RR(tu,c) * ML_in(tu,c)) ;

eq18(tu) ..		Cost_tot(tu) =e= Cost_var_tu(tu) * F_in(tu) + cost_fix_tu_a(tu) * F_in(tu) + cost_fix_tu_b(tu) ;

eq19(tu) ..		B_tu_tup$(ord(tup) ne ord(tu)) + B_tu_tup$(ord(tu) ne ord(tup)) =l= 1 ;

eq21(s,tu) .. 	F_s_tu(s,tu) - B_s_tu(s,tu) * Bound_up =l= 0 ;

eq22(tu) .. 	F_rec(tu,tup)$(ord(tup) ne ord(tu)) - B_tu_tup$(ord(tup) ne ord(tu)) * Bound_up =l= 0 ;
				
eq23(tu) .. 	F_exit(tu) - B_exit(tu) * Bound_up =l= 0 ;

eq24(tu) ..		F_in(tu) - B_tu(tu) * Bound_up =l= 0 ;

eq25(s,tu) ..	F_s_tu(s,tu) - B_s_tu(s,tu) * Bound_low =g= 0 ;

eq26(tu) .. 	F_rec(tu,tup)$(ord(tup) ne ord(tu)) - B_tu_tup$(ord(tup) ne ord(tu)) * Bound_low =g= 0 ;

eq27(tu) .. 	F_exit(tu) - B_exit(tu) * Bound_low =g= 0 ;

eq28(tu) ..		F_in(tu) - B_tu(tu) * Bound_low =g= 0 ;

eq29(tu) ..		sum(s, B_s_tu(t,su)) + sum( tup$(ord(tup) ne ord(tu)), B_tu_tup(tu,tup)) =l= NS_max(tu) ;

OF_cost ..		Cost_tot =e= sum(tu, cost_tot(tu)) + HY * sum(s, F_s(s) * cost_var_s(s)) ;

				



