$Title starting_points

$Ontext

The starting points for the local solver of the water_treatment problem
is provided in this file

$Offtext

*Binary Variables

*s_tu
B_s_tu.l('pw','st') = 1;
B_s_tu.l('muw','wac') = 1;

*tu
B_tu.l('st') = 1;
B_tu.l('igf') = 1;
B_tu.l('orf') = 1;
B_tu.l('ls') = 1;
B_tu.l('wac') = 1;

*tu_tup
B_tu_tup.l('st','igf') = 1;
B_tu_tup.l('st','orf') = 1;
B_tu_tup.l('igf','orf') = 1;
B_tu_tup.l('orf','ls') = 1;
B_tu_tup.l('ls','wac') = 1;

*exit
B_exit.l('igf') = 1;
B_exit.l('orf') = 1;
B_exit.l('ls') = 1;
B_exit.l('wac') = 1;


