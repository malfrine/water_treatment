#!/bin/bash

matlab -nodesktop -nosplash -r "run main_script; exit;"

latex model_BFD.tex

open model_BFD.pdf