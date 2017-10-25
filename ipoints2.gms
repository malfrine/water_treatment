$Title ipoints2

$Ontext

The starting points for the local solver of the water_treatment problem
is provided in this file

$Offtext

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



*Binary Variables

*s_tu
B_s_tu.up('pw','st') = 1;
B_s_tu.up('muw','wac') = 1;

*tu
B_tu.up('st') = 1;
B_tu.up('igf') = 1;
B_tu.up('orf') = 1;
B_tu.up('ls') = 1;
B_tu.up('wac') = 1;

*tu_tup
B_tu_tup.up('st','igf') = 1;
B_tu_tup.up('st','orf') = 1;
B_tu_tup.up('igf','orf') = 1;
B_tu_tup.up('orf','ls') = 1;
B_tu_tup.up('ls','wac') = 1;

*exit
B_exit.up('igf','otsg') = 1;
B_exit.up('orf','otsg') = 1;
B_exit.up('ls','otsg') = 1;
B_exit.up('wac','otsg') = 1;
