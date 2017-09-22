cls
del /f arrows.tex
del /f model_BFD.pdf

gams minlp_main.gms
matlab -nodisplay -nosplash -nodesktop -r "run('main_script.m'); exit;"
TIMEOUT /T 30 >nul
pdflatex model_BFD.tex
TIMEOUT /T 5 >nul
start model_BFD.pdf
