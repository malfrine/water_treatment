$Title ipoints1

$Ontext

The starting points for the local solver of the water_treatment problem
is provided in this file

$Offtext

*Binary Variables

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


