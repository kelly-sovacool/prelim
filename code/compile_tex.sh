#!/bin/bash
input=$1
output=$2
name=$3

xelatex $input
bibtex $name
xelatex $input
xelatex $input
mv ${name}.pdf $output
rm *.aux *.bbl *.blg *.log