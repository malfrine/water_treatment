$Title params_init

$Ontext

The parameters for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

$Offtext

*FLOW RATES

parameter F_loss(tu)	'flow loss in tu'
	/ 	  st	1
		  igf	1
		  orf	1
		  hcy	1
		  ls	1
		  evap	1
		  wac	1	/;
		  
scalar F_BFW	'boiler feed water flow'
	/ 1 /;
	
*CONCENTRATIONS
*did not include C(s,tu,c) and C_ave(c) - they were not used in the equations

table C(s,c)	'concentration of c in s'
	   			o		s		th		tss
      pw        1  		1		1		1
      muw		1  		1		1		1
      bbd       1  		1		1		1	;
      
table C_in_max(tu,c)	'maximum allowable inlet concentration of c in tu'
      			o		s		th		tss
      	st		1		1		1		1
      	igf		1		1		1		1
		orf		1		1		1		1
	    hcy		1		1		1		1
		ls		1		1		1		1
		evap	1		1		1		1
		wac		1		1		1		1	;
	
table C_loss(tu,c)	'distance in thousands of miles'
      			o		s		th		tss
      	st		1		1		1		1
      	igf		1		1		1		1
		orf		1		1		1		1
	    hcy		1		1		1		1
		ls		1		1		1		1
		evap	1		1		1		1
		wac		1		1		1		1	;

parameter C_target(c)	'target concentration required at discharge'
	/	o		1
		s		1
		th		1
		tss		1	/;
		
*MASS LOADS
*did not include ML_tot(c) - it was not used in the equations

** ML_rem(s) is likely	a formula (E17) and will be adjusted soon **
parameter ML_rem(c)	'mass load of contaminant to be removed from the system'
	/	o		1
		s		1
		th		1
		tss		1	/;
		
*COST PARAMETERS

parameter cost_var(s)	'variable cost of s'
	/	pw		1
		muw		1
		bbd		1	/;

parameter cost_fix(s)	'fixed cost of s'
	/	pw		1
		muw		1
		bbd		1	/;

parameter cost_var(tu)	'variable cost of tu'
	/ 	  st	1
		  igf	1
		  orf	1
		  hcy	1
		  ls	1
		  evap	1
		  wac	1	/;

parameter cost_fix(tu)	'fixed cost of tu'
	/ 	  st	1
		  igf	1
		  orf	1
		  hcy	1
		  ls	1
		  evap	1
		  wac	1	/;

** OTHER PARAMETERS

table RR(tu,c)	'removal ratio of contaminant c'
      			o		s		th		tss
      	st		1		1		1		1
      	igf		1		1		1		1
		orf		1		1		1		1
	    hcy		1		1		1		1
		ls		1		1		1		1
		evap	1		1		1		1
		wac		1		1		1		1	;
		
scalar Bound_up	'upper bound for stream flow rates'
	/1/;

scalar Bound_low	'lower bound for stream flow rates'
	/1/;
	
parameter NS_max(tu)	'maximum number of streams that can go through tu'
	/ 	  st	1
		  igf	1
		  orf	1
		  hcy	1
		  ls	1
		  evap	1
		  wac	1	/;

scalar HY	'number of operational hours per year'
	/1/;




	



		

		





