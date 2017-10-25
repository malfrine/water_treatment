$Title vars

$Ontext

The variables for flow rates, concentrations, mass loads, cost, and others are
initialized in this script.

$Offtext

*FLOW RATES

positive variables
        F_s(s)                  'flow rate of source water'
        F_s_tu(s,tu)    'flow rate of s entering tu'
        F_rec(tup,tu)   'flow rate of streams exiting tu that enter tup for recycle'
        F_exit(tu,sgu)              'flow rate of streams leaving tu to sgu'
        F_in(tu)                'flow rate of streams entering tu'
        F_out(tu)               'flow rate of streams directly exiting tu'
        F_in_sgu(sgu)    'flow rate of streams entering sgu'
        F_exit_sgu(sgu,pro)   'flow rate of streams exiting sgu'
        F_rec_otsg_bbd   'flow rate of recycle from otsg to bbd'
        F_pro(pro)      'flow rate of streams exiting and entering pro';

F_rec.fx('st','st') = 0;
F_rec.fx('igf','igf') = 0;
F_rec.fx('orf','orf') = 0;
F_rec.fx('hcy','hcy') = 0;
F_rec.fx('ls','ls') = 0;
F_rec.fx('evap','evap') = 0;
F_rec.fx('wac','wac') = 0;
*CONCENTRATIONS

positive variables
        C_in(tu,c)              'concentration of c in tu inlet'
        C_rout(tu,tup,c)        'concentration of c exiting tu and entering tup for recycle'
        C_exit(tu,c,sgu)    'concentration of c leaving tu to the discharge point'
        C_out(tu,c)             'concentration of stream directly exiting tu'
        C_sgu(c,sgu)                'concentration of c in BFW'     ;

C_in.up(tu,'o') = 2000;
C_in.up(tu,'s') = 350;
C_in.up(tu,'th') = 245;
C_in.up(tu,'tss') = 50;

C_rout.up(tu,tup,'o') = 2000;
C_rout.up(tu,tup,'s') = 350;
C_rout.up(tu,tup,'th') = 245;
C_rout.up(tu,tup,'tss') = 50;

C_exit.up(tu,'o',sgu) = 2000;
C_exit.up(tu,'s',sgu) = 350;
C_exit.up(tu,'th',sgu) = 245;
C_exit.up(tu,'tss',sgu) = 50;

C_out.up(tu,'o') = 2000;
C_out.up(tu,'s') = 350;
C_out.up(tu,'th') = 245;
C_out.up(tu,'tss') = 50;

C_sgu.up('o',sgu) = 2000;
C_sgu.up('s',sgu) = 350;
C_sgu.up('th',sgu) = 245;
C_sgu.up('tss',sgu) = 50;


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
        energy_var(tu)          'energy consumption of tu'
        energy_tot              'total energy consumption of the system' ;

*BINARY VARIABLES

binary variables
        B_s_tu(s,tu)    'binary variable to show the existence of stream s into tu'
        B_tu_tup(tu,tup)        'binary variable to show the existence of tu into tup recylce'
        B_exit(tu,sgu)              'binary variable to show the existence of stream from tu to discharge'
        B_tu(tu)                'binary variable to show the existence of tu' ;

*OBJECT

variable
        obj                             'objective variable' ;

