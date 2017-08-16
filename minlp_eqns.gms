$Title vars_init

$Ontext

The variables for the MINLP algorithm are provided in this file

$Offtext

Equations
    eq4		'overall mass balance'   
    eq5   	'mass balance around splitter 1'
    eq6   	'mass balance around mixer 1'
	eq7		'mass balance around splitter 2'
	eq8		'mass balance around mixer 3'
	eq9		'mass balance around tu'
	eq12	'definition of ML_in'
	eq13	'definition of ML_out'
	eq10	'component mass balance around each tu - 1'
	eq11	'component mass balance around each tu - 2'
	eq14	'concentration limit for tu inlet'
	eq15	'discharge concentration to meet BFW requirement'
	eq16	'total mass load of c removed from system'
	eq18	'cost of tu'
	eq19	'eliminating cycles'
	eq21	's,tu upper bound'
	eq22	'tu,tup upper bound'
	eq23	'exit tu upper bound'
	eq24	'in tu upper bound' 
	eq25	's,tu lower bound'
	eq26	'tu,tup lower bound'
	eq27	'exit tu lower bound'
	eq28	'in tu lower bound'
	eq29	'maximum number of streams going through a tu'

eq4 ..         z  =e=  sum(s, F(s)) - F_BFW =e= sum(tu, F_loss(tu))

supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;
