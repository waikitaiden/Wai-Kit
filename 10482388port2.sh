#!/bin/bash
#use if function to check if the input.txt file exists
#if it is exist, use sed command to delete the first row
#then continue with sed command to substitute the following ',' into 'name' 'height' 'width' 'area' 'colour'
#then save it into a new file called portfoliooutput.txt
#then print 'output file has successfully saved as portfoliooutput.txt' before the program quits
if ! [ -f portfolioinput.txt ]; then
    echo "No file to process..."
    exit 0
else
sed -e '1d ; s/^/Name:/g ; s/,/  Height:/; s/,/  Width:/; s/,/  Area:/; s/,/  Colour:/' portfolioinput.txt > portfoliooutput.txt 

echo "Output file has sucessfully saved as portfoliooutput.txt'"
fi 