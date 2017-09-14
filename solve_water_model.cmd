cls
gams minlp_main.gms
matlab -nodisplay -nosplash -nodesktop -r "run('main_script.m'); exit;"
latex model_BFD.tex
start model_BFD.pdf

