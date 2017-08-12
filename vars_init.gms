$Title vars_init

$Ontext

The variables for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

$Offtext

*FLOW RATES

positive variable F(s)	'flow rate of s';
F.fx('pw') = 1;
F.fx('bbd') = 1;

positive variables
	F(s,tu) 		'flow rate of s entering tu'
	F_rec(tu_tup)	'flow rate of streams exiting tu that enter tup for recycle'
	F_exit(tu) 		'flow rate of streams leaving tu to the discharge point'
	F_in(tu)		'flow rate of streams entering tu'
	F_out(tu)		'flow rate of streams directly exiting tu'	;

*CONCENTRATIONS

positive variables
	C_in(tu,c)		'concentration of c in tu inlet'
	C_rout(tu_tup,c)	'concentration of c exiting tu and entering tup for recycle'
	C_exit(tu,c)	'concentration of c leaving tu to the discharge point'
	C_out(tu,c)		'concentration of streamt directly exiting tu'
	C_BFW(c)		'concentration of C in BFW'	;

*MASS LOADS

positive variables
	ML_rem(tu,c)	'mass Load of c removed in tu'
	ML_in(tu,c)		'mass load of c entering tu'
	ML_out(tu,c)	'mass load of c exiting tu'	;

*COST AND ENERGY VARIABLES

positive variables
	Cost_tot(tu)	'total cost of tu'
	Cost_op			'operating cost of the system'
	Cost_cap		'capital cost of the system'
	Cost_tot		'total capital cost of the system'
	energy_var(tu)	'energy consumption of tu'
	energy_tot		'total energy consumption of the system'

*BINARY VARIABLES

binary variables
	B_s_tu(s,tu)	'binary variable to show the existence of stream s into tu'
	B_tu_tup(tu_tup)	'binary variable to show the existence of tu into tup recylce'
	B_exit(tu)		'binary variable to show the existence of stream from tu to discharge'
	B_tu(tu)		'binary variable to show the existence of tu'

	
	