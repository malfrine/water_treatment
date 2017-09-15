ECHO OFF

cls
del /f arrows.tex
del /f model_BFD.pdf

rem gams minlp_main.gms
matlab -nodisplay -nosplash -nodesktop -r "run('main_script.m'); exit;"
TIMEOUT /T 20 >nul
pdflatex model_BFD.tex
TIMEOUT /T 5 >nul
start model_BFD.pdf
