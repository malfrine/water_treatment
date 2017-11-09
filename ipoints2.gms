$Title ipoints2

$Ontext

The starting points for the local solver of the water_treatment problem
is provided in this file

$Offtext

*Binary Variables

*Binary Variables

*s_tu
B_s_tu.lo('pw','st') = 0;
B_s_tu.lo('muw','wac') = 0;

*tu
B_tu.lo('st') = 0;
B_tu.lo('igf') = 0;
B_tu.lo('orf') = 0;
B_tu.lo('ls') = 0;
B_tu.lo('wac') = 0;

*tu_tup
B_tu_tup.lo('st','igf') = 0;
B_tu_tup.lo('st','orf') = 0;
B_tu_tup.lo('igf','orf') = 0;
B_tu_tup.lo('orf','ls') = 0;
B_tu_tup.lo('ls','wac') = 0;

*exit
B_exit.lo('igf','otsg') = 0;
B_exit.lo('orf','otsg') = 0;
B_exit.lo('ls','otsg') = 0;
B_exit.lo('wac','otsg') = 0;
B_exit.lo('igf','db') = 0;
B_exit.lo('orf','db') = 0;
B_exit.lo('ls','db') = 0;
B_exit.lo('wac','db') = 0;
B_exit.lo('igf','hrsg') = 0;
B_exit.lo('orf','hrsg') = 0;
B_exit.lo('ls','hrsg') = 0;
B_exit.lo('wac','hrsg') = 0;

*exit sgu
*B_exit_sgu.lo('otsg','wi') = 0;
*B_exit_sgu.lo('otsg','eg') = 0;

*rec otsg to bbd
*B_rec_otsg_bbd.lo = 0;

