$Title ipoints1

$Ontext

The starting points for the local solver of the water_treatment problem
is provided in this file

$Offtext

*Binary Variables

*   B_s_tu.fx(s,tu)=0;
*   B_tu_tup.fx(tu,tup)=0;
*  B_exit.fx(tu,sgu)=0;
*   B_tu.fx(tu)=0;





*s_tu
B_s_tu.fx('pw','st') = 1;
B_s_tu.fx('muw','wac') = 1;

*tu
B_tu.fx('st') = 1;
B_tu.fx('igf') = 1;
B_tu.fx('orf') = 1;
B_tu.fx('ls') = 1;
B_tu.fx('wac') = 1;

*tu_tup
B_tu_tup.fx('st','igf') = 1;
B_tu_tup.fx('st','orf') = 1;
B_tu_tup.fx('igf','orf') = 1;
B_tu_tup.fx('orf','ls') = 1;
B_tu_tup.fx('ls','wac') = 1;

*exit
B_exit.fx('igf','otsg') = 1;
B_exit.fx('orf','otsg') = 1;
B_exit.fx('ls','otsg') = 1;
B_exit.fx('wac','otsg') = 1;

$ontext
B_exit.fx('igf','db') = 1;
B_exit.fx('orf','db') = 1;
B_exit.fx('ls','db') = 1;
B_exit.fx('wac','db') = 1;

B_exit.fx('igf','hrsg') = 1;
B_exit.fx('orf','hrsg') = 1;
B_exit.fx('ls','hrsg') = 1;
B_exit.fx('wac','hrsg') = 1;

$offtext

*exit sgu
B_exit_sgu.fx('otsg','wi') = 1;
B_exit_sgu.fx('otsg','eg') = 1;

*rec otsg to bbd
B_rec_otsg_bbd.fx = 1;
