$Title SAGD Optimization - MILNP Algorithm
$Ontext
        This is the main file for the SAGD Water Treatment Optimization using the
        MILNP Optimization.
$Offtext


*INITIALIZE SETS, DATA, and VARIABLE

$include sets.gms
$include params.gms
$include vars.gms

*EQUATIONS

$include eqns.gms

*SOLVE MINLP

model water /all/;

option nlp = CONOPT;
option minlp = DICOPT;
option optcr = 0.01;
option reslim = 86400;

*ITERATION 1 - Fix the binary connections
$include ipoints1.gms
solve  water using minlp minimization obj;

*ITERATION 2 - Use previous solution as starting point - Relax the binary
*              connections
$include ipoints2.gms
solve  water using minlp minimization obj;

*Export the solution as .gdx file
$GDXOUT main_loc.gdx
$UNLOAD
$GDXOUT

execute_unload 'main_loc.gdx'
