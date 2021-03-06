$Title params_init

$Ontext

The parameters for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

***PARAMETERS ARE FOR CASE 2 ONLY FOR NOW***
***NEED TO FIND INFO FOR F_loss(tu), C_in_max(tu,c), C_loss(tu,c), and ALL cost parameters
$Offtext

*FLOW RATES-------------------------------------------------------------------------------

*scalar F_BFW    'boiler feed water flow'
*        /                       625 /;

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
          pw       2000     350     20       50
          muw      0        15      150      0
          bbd      10       150     1        1       ;
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

table C_target(c,sgu)   'target concentration required at discharge'
                                hrsg     db     otsg
                o               10       10     10
                s               150      150    150
                th              1        1      1
                tss             1        1      1

*MASS LOADS-------------------------------------------------------------------------------
*did not include ML_tot(c) - it was not used in the equations

$Ontext
parameter ML_rem_c(c)   'mass load of contaminant to be removed from the system';
        ML_rem_c(c) = sum( s, F_s(s) * (C_c_s(s,c) - C_target(c)) );
** E17 - double check this formula, there might be problems with brackets**
$Offtext

*COST PARAMETERS--------------------------------------------------------------------------

parameter cost_var_s(s) 'variable cost of s'
        /       pw              0
                muw             1.59e-6
                bbd             0       /;

parameter cost_fix_s(s) 'fixed cost of s'
        /       pw              0
                muw             0
                bbd             0       /;

parameter cost_var_tu_a(tu)       'variable cost of tu'
                /  st              109.26e-6
                   igf             432.94e-6
                   orf             0
                   hcy             1e-6
                   ls              5388e-6
                   evap            15529e-6
                   wac             494.23e-6       /;

parameter cost_var_tu_b(tu)       'variable cost of tu'
                /  st              0
                   igf             23585e-6
                   orf             0
                   hcy             1e-6
                   ls              -479602e-6
                   evap            10626e-6
                   wac             -31.142e-6       /;


parameter cost_fix_tu_a(tu)     'fixed cost of tu - function slope'
           /       st              2989.5e-6
                   igf             1906.7e-6
                   orf             1248.9e-6
                   hcy             3000e-6
                   ls              9705.5e-6
                   evap            28723e-6
                   wac             1550.9e-6       /;


parameter cost_fix_tu_b(tu)     'fixed cost of tu - function intercept'
           /       st              0
                   igf             12292e-6
                   orf             -401.99e-6
                   hcy             50000e-6
                   ls              -860733e-6
                   evap            12926e-6
                   wac             -317.74e-6       /;

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


*EQN 20
scalar Bound_low        'lower bound for stream flow rates'
        /0/;
*arbitrary values - model values not given by Forshomi

parameter NS_max(tu)    'maximum number of streams that can go through tu'
        /         st    9
                  igf   9
                  orf   9
                  hcy   9
                  ls    9
                  evap  9
                  wac   9      /;
*arbitrary values - model values not given by Forshomi

scalar HY       'number of operational hours per year'
        /8322/;
**assuming 95% on-stream time

scalar a_hrsg 'linear constant for hrsg power gen'
         /1/;

scalar a_eg   'linear constant for eg power gen'
         /1/;

scalar F_wi_demand 'demand flow into wi'
         /675/;

scalar pow_demand   'total power demand from hrsg and eg'
         /5000/;

scalar Bound_up 'upper bound for stream flow rates';
        Bound_up = F_wi_demand * 2;
*chose factor of 2 - might be greater. check to see if any flows exceed.










