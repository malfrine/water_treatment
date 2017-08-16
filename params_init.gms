$Title params_init

$Ontext

The parameters for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

***PARAMETERS ARE FOR CASE 1 ONLY FOR NOW***
***NEED TO FIND INFO FOR F_loss(tu), C_in_max(tu,c), C_loss(tu,c), and ALL cost parameters
$Offtext

*FLOW RATES-------------------------------------------------------------------------------

scalar F_BFW	'boiler feed water flow'
	/ 			625 /;

parameter F_s(s) 'flow of stream s'
	/ 	  pw	475 
		  bbd	0
		  	/;

	F_s('muw') = F_BFW - F_s('pw') - F_s('bbd');

parameter F_loss(tu)	'flow loss in tu'
	/ 	  st	1
		  igf	1
		  orf	1
		  hcy	1
		  ls	1
		  evap	1
		  wac	1	/;
		  
*CONCENTRATIONS---------------------------------------------------------------------------
*did not include C(s,tu,c) and C_ave(c) - they were not used in the equations

table C_c_s(s,c)	'concentration of c in s'
	   			o		s		th		tss
      pw        2000  	350		20		50
      muw		0  		15		245		0
      bbd       10  	150		1		1	;
**pw and muw data collected from Forshomi thesis Table 3-1
**muw is assumed to be fresh no brackish
**bbd data collected from Forshomi appendix A Table A3 for OTSG
      
table C_in_max(tu,c)	'maximum allowable inlet concentration of c in tu'
      			o		s		th		tss
      	st		1		1		1		1
      	igf		1		1		1		1
		orf		1		1		1		1
	    hcy		1		1		1		1
		ls		1		1		1		1
		evap	1		1		1		1
		wac		1		1		1		1	;
	
table C_loss(tu,c)	'concentration loss of c in tu'
      			o		s		th		tss
      	st		1		1		1		1
      	igf		1		1		1		1
		orf		1		1		1		1
	    hcy		1		1		1		1
		ls		1		1		1		1
		evap	1		1		1		1
		wac		1		1		1		1	;

parameter C_target(c)	'target concentration required at discharge'
	/	o		10
		s		150
		th		1
		tss		1	/;

*MASS LOADS-------------------------------------------------------------------------------
*did not include ML_tot(c) - it was not used in the equations

parameter ML_rem_c(c)	'mass load of contaminant to be removed from the system';
	ML_rem(c) = sum( s, F(s) * (C_c_s(s,c) - C_target(c)) );
** E17 - double check this formula, there might be problems with brackets**
	
*COST PARAMETERS--------------------------------------------------------------------------

parameter cost_var_s(s)	'variable cost of s'
	/	pw		1
		muw		1
		bbd		1	/;

parameter cost_fix_s(s)	'fixed cost of s'
	/	pw		1
		muw		1
		bbd		1	/;

parameter cost_var_tu(tu)	'variable cost of tu'
	/ 	st		1
		igf		1
		orf		1
		hcy		1
		ls		1
		evap	1
		wac		1	/;

parameter cost_fix_tu_a(tu)	'fixed cost of tu - function slope'
	/ 	st		1
		igf		1
		orf		1
		hcy		1
		ls		1
		evap	1
		wac		1	/;

parameter cost_fix_tu_b(tu)	'fixed cost of tu - function intercept'
	/ 	st		1
		igf		1
		orf		1
		hcy		1
		ls		1
		evap	1
		wac		1	/;

*OTHER PARAMETERS-------------------------------------------------------------------------

table RR(tu,c)	'removal ratio of contaminant c'
      			o		s		th		tss
      	st		0.9		0		0		0.5
      	igf		0.9		0		0		0.7
		orf		0.91	0		0		0.95
	    hcy		0.93	0		0		0
		ls		0		0.9		0.5		0
		evap	0.99	0.99	0.99	0.99
		wac		0		0		0.99	0	;
		
scalar Bound_up	'upper bound for stream flow rates';
	Bound_up = sum(s, sum(F(s)));
*EQN 20

scalar Bound_low	'lower bound for stream flow rates'
	/200/;
*arbitrary values - model values not given by Forshomi
	
parameter NS_max(tu)	'maximum number of streams that can go through tu'
	/ 	  st	10
		  igf	10
		  orf	10
		  hcy	10
		  ls	10
		  evap	10
		  wac	10	/;
*arbitrary values - model values not given by Forshomi

scalar HY	'number of operational hours per year'
	/8322/;
**assuming 95% on-stream time


	



		

		





