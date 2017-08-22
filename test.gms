
*SUPERSETS

sets

        tu              'treatment unit'
                / st    skim tank
                  igf   induced gas flotation
                  orf   oil removal filter
                  hcy   hydro-cyclone
                  ls    warm-hot lime softener
                  evap  evaporator
                  wac   weak acid cation exchanger
                /

        c               'contaminant'
                / o             oil
                  s             silica
                  th    total hardness
                  tss   total suspended solids
                /

        s               'water source'
                / pw    produced water
                  muw   make-up water
                  bbd   boiler blowdown
                /

        cs      'steam generation cases'
                /1*4/ ;

alias(tu,tup);


$Ontext

The parameters for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

***PARAMETERS ARE FOR CASE 1 ONLY FOR NOW***
***NEED TO FIND INFO FOR F_loss(tu), C_in_max(tu,c), C_loss(tu,c), and ALL cost parameters
$Offtext

*FLOW RATES-------------------------------------------------------------------------------

scalar F_BFW    'boiler feed water flow'
        /                       625 /;

$Ontext
parameter F_s(s) 'flow of stream s'
        /         pw    475
                  bbd   0
                        /;
F_s('muw') = F_BFW - F_s('pw') - F_s('bbd');
$Offtext


parameter F_loss(tu)    'flow loss in tu'
        /         st    0
                  igf   0
                  orf   0
                  hcy   0
                  ls    0
                  evap  0
                  wac   0       /;

*CONCENTRATIONS---------------------------------------------------------------------------
*did not include C(s,tu,c) and C_ave(c) - they were not used in the equations

table C_c_s(s,c)        'concentration of c in s'
                   o         s       th      tss
          pw       2000     350     20      50
          muw      0        15      245     0
          bbd      10       150     1       1       ;
**pw and muw data collected from Forshomi thesis Table 3-1
**muw is assumed to be fresh no brackish
**bbd data collected from Forshomi appendix A Table A3 for OTSG

table C_in_max(tu,c)    'maximum allowable inlet concentration of c in tu'
                o               s               th              tss
st              2500            400             400             100
igf             2500            400             400             100
orf             2500            400             400             100
hcy             2500            400             400             100
ls              2500            400             400             100
evap            2500            400             400             100
wac             2500            400             400             100     ;

table C_loss(tu,c)      'concentration loss of c in tu'
                o               s               th              tss
st              0               0               0               0
igf             0               0               0               0
orf             0               0               0               0
hcy             0               0               0               0
ls              0               0               0               0
evap            0               0               0               0
wac             0               0               0               0       ;

parameter C_target(c)   'target concentration required at discharge'
        /       o               10
                s               150
                th              1
                tss             1       /;

*MASS LOADS-------------------------------------------------------------------------------
*did not include ML_tot(c) - it was not used in the equations

$Ontext
parameter ML_rem_c(c)   'mass load of contaminant to be removed from the system';
        ML_rem_c(c) = sum( s, F_s(s) * (C_c_s(s,c) - C_target(c)) );
** E17 - double check this formula, there might be problems with brackets**
$Offtext

*COST PARAMETERS--------------------------------------------------------------------------

parameter cost_var_s(s) 'variable cost of s'
        /       pw              1
                muw             1
                bbd             1       /;

parameter cost_fix_s(s) 'fixed cost of s'
        /       pw              1
                muw             1
                bbd             1       /;

parameter cost_var_tu(tu)       'variable cost of tu'
                /  st              1
                   igf             1
                   orf             1
                   hcy             1
                   ls              1
                   evap            1
                   wac             1       /;


parameter cost_fix_tu_a(tu)     'fixed cost of tu - function slope'
           /       st              1
                   igf             1
                   orf             1
                   hcy             1
                   ls              1
                   evap            1
                   wac             1       /;


parameter cost_fix_tu_b(tu)     'fixed cost of tu - function intercept'
           /       st              1
                   igf             1
                   orf             1
                   hcy             1
                   ls              1
                   evap            1
                   wac             1       /;

*OTHER PARAMETERS-------------------------------------------------------------------------

table RR(tu,c)  'removal ratio of contaminant c'
                           o       s       th      tss
           st              0.9     0       0       0.5
           igf             0.9     0       0       0.7
           orf             0.91    0       0       0.95
           hcy             0.93    0       0       0
           ls              0       0.9     0.5     0
           evap            0.99    0.99    0.99    0.99
           wac             0       0       0.99    0       ;

scalar Bound_up 'upper bound for stream flow rates';
        Bound_up = F_BFW + sum(tu, F_loss(tu));
*EQN 20

scalar Bound_low        'lower bound for stream flow rates'
        /200/;
*arbitrary values - model values not given by Forshomi

parameter NS_max(tu)    'maximum number of streams that can go through tu'
        /         st    10
                  igf   10
                  orf   10
                  hcy   10
                  ls    10
                  evap  10
                  wac   10      /;
*arbitrary values - model values not given by Forshomi

scalar HY       'number of operational hours per year'
        /8322/;
**assuming 95% on-stream time






$Title vars_init

$Ontext

The variables for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

$Offtext

*FLOW RATES

positive variables
        F_s(s)                  'flow rate of source water'
        F_s_tu(s,tu)    'flow rate of s entering tu'
        F_rec(tu,tup)   'flow rate of streams exiting tu that enter tup for recycle'
        F_exit(tu)              'flow rate of streams leaving tu to the discharge point'
        F_in(tu)                'flow rate of streams entering tu'
        F_out(tu)               'flow rate of streams directly exiting tu'      ;

F_s.fx('pw') = 475 ;
F_s.fx('bbd') = 0 ;

*CONCENTRATIONS

positive variables
        C_in(tu,c)              'concentration of c in tu inlet'
        C_rout(tu,tup,c)        'concentration of c exiting tu and entering tup for recycle'
        C_exit(tu,c)    'concentration of c leaving tu to the discharge point'
        C_out(tu,c)             'concentration of streamt directly exiting tu'
        C_BFW(c)                'concentration of c in BFW'     ;

*MASS LOADS

positive variables
        ML_rem_tu_c(tu,c)       'mass load of c removed from tu'
        ML_in(tu,c)             'mass load of c entering tu'
        ML_out(tu,c)    'mass load of c exiting tu'
        ML_rem_c(c)             'mass load of c removed from system'    ;

*COST AND ENERGY VARIABLES

positive variables
        Cost_tot_tu(tu) 'total cost of tu'
        Cost_op                 'operating cost of the system'
        Cost_cap                'capital cost of the system'
        Cost_tot                'total capital cost of the system'
        energy_var(tu)  'energy consumption of tu'
        energy_tot              'total energy consumption of the system' ;

*BINARY VARIABLES

binary variables
        B_s_tu(s,tu)    'binary variable to show the existence of stream s into tu'
        B_tu_tup(tu,tup)        'binary variable to show the existence of tu into tup recylce'
        B_exit(tu)              'binary variable to show the existence of stream from tu to discharge'
        B_tu(tu)                'binary variable to show the existence of tu' ;

variable
obj      ;









$Title minlp_eqns

$Ontext

The variables for the MINLP algorithm are provided in this file

$Offtext

Equations
eq4                         'overall mass balance'
eq5(s)              'mass balance around splitter 1'
eq6(tu)             'mass balance around mixer 1'
eq7(tu)                 'mass balance around splitter 2'
eq8                             'mass balance around mixer 3'
eq9(tu)                 'mass balance around tu'
eq12(tu,c)              'definition of ML_in'
eq13(tu,c)              'definition of ML_out'
*eq10(tu,c)              'component mass balance around each tu - 1'
*eq11(tu,c)              'component mass balance around each tu - 2'
*eq14(tu,c)              'concentration limit for tu inlet'
*eq15(c)                 'discharge concentration to meet BFW requirement'
*eq16(c)                 'total mass load of c removed from system'
**eq17(c)                 'defining ML_rem_c(c)'
**eq18(tu)                'cost of tu'
*eq19(tu,tup)    'eliminating cycles'
*eq21(s,tu)              's,tu upper bound'
*eq22(tu,tup)            'tu,tup upper bound'
eq23(tu)                'exit tu upper bound'
eq24(tu)                'in tu upper bound'
eq25(s,tu)              's,tu lower bound'
eq26(tu,tup)            'tu,tup lower bound'
eq27(tu)                'exit tu lower bound'
eq28(tu)                'in tu lower bound'
eq29(tu)                'maximum number of streams going through a tu'
**OF_cost                 'objective cost function'
equation_o
 ;

eq4 ..                  sum(s, F_s(s)) - F_BFW =e= sum(tu, F_loss(tu)) ;



eq5(s) ..               F_s(s) =e= sum(tu, F_s_tu(s,tu)) ;

eq6(tu) ..          sum(s, F_s_tu(s,tu)) + sum(tup$(ord(tup) ne ord(tu)), F_rec(tu,tup))  =e= F_in(tu) ;

eq7(tu) ..              F_out(tu) =e= sum(tup$(ord(tup) ne ord(tu)), F_rec(tu,tup)) + F_exit(tu) ;

eq8 ..                  sum(tu, F_exit(tu)) =e= F_BFW ;

eq9(tu) ..              F_in(tu) - F_out(tu) =e= F_loss(tu) ;

eq12(tu,c) ..   sum(tup, F_rec(tup,tu) * C_out(tu,c)) + sum(s, F_s_tu(s,tu) * C_c_s(s,c)) =e= ML_in(tu,c) ;

eq13(tu,c) ..   C_out(tu,c) * ( sum(tup, F_rec(tup,tu)) + sum(s, F_s_tu(s,tu) ) - F_loss(tu) ) =e= ML_out(tu,c) ;

*eq10(tu,c) ..   (1 - RR(tu,c)) * ML_in(tu,c) - ML_out(tu,c) - F_loss(tu) * C_loss(tu,c) =e= 0 ;

*eq11(tu,c) ..   ML_in(tu,c) - ML_out(tu,c) - ML_rem_tu_c(tu,c) =e= F_loss(tu) * C_loss(tu,c) ;

*eq14(tu,c) ..   ML_in(tu,c) =l= C_in_max(tu,c) * F_in(tu) ;

*eq15(c) ..              sum(tu, F_exit(tu) * C_out(tu,c)) =l= C_target(c) * sum(tu, F_exit(tu)) ;

*eq16(c) ..              ML_rem_c(c) =l= sum(tu, ML_rem_tu_c(tu,c)) + sum(tu, RR(tu,c) * ML_in(tu,c)) ;

*eq17(c) ..              ML_rem_c(c) =e= sum( s, F_s(s) * (C_c_s(s,c) - C_target(c)) );

*eq18(tu) ..            Cost_tot_tu(tu) =e= Cost_var_tu(tu) * F_in(tu) + cost_fix_tu_a(tu) * F_in(tu) + cost_fix_tu_b(tu) ;

*eq19(tu,tup)$(ord(tup) ne ord(tu)) .. B_tu_tup(tu,tup) + B_tu_tup(tup,tu) =l= 1 ;

*eq21(s,tu) ..   F_s_tu(s,tu) - B_s_tu(s,tu) * Bound_up =l= 0 ;

*eq22(tu,tup) ..         F_rec(tu,tup) - B_tu_tup(tu,tup)$(ord(tup) ne ord(tu)) * Bound_up =l= 0 ;

eq23(tu) ..     F_exit(tu) - B_exit(tu) * Bound_up =l= 0 ;

eq24(tu) ..             F_in(tu) - B_tu(tu) * Bound_up =l= 0 ;

eq25(s,tu) ..   F_s_tu(s,tu) - B_s_tu(s,tu) * Bound_low =g= 0 ;

eq26(tu,tup) ..         F_rec(tu,tup)$(ord(tup) ne ord(tu)) - B_tu_tup(tu,tup)$(ord(tup) ne ord(tu)) * Bound_low =g= 0 ;

eq27(tu) ..     F_exit(tu) - B_exit(tu) * Bound_low =g= 0 ;

eq28(tu) ..             F_in(tu) - B_tu(tu) * Bound_low =g= 0 ;

eq29(tu) ..             sum(s, B_s_tu(s,tu)) + sum( tup$(ord(tup) ne ord(tu)), B_tu_tup(tu,tup)) =l= NS_max(tu) ;

*OF_cost ..             Cost_tot =e= sum(tu, Cost_tot_tu(tu)) + HY * sum(s, F_s(s) * cost_var_s(s)) ;

equation_o .. obj =e= F_s('muw') ;



model water /all/ ;

Solve  water using minlp minimization obj ;

$Ontext

file solFile /"water.txt"/;
solFile.pw = 1300;
put solFile;


put 'obj.(M$) '; put obj.l:10:1'                ' ;  put /;
put /;
put /;



put 'X(DR).(bpd)      '; loop (tu, put F_exit.l(tu):8:1'  ' ;)   put /;

$Offtext