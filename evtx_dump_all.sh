#!/bin/bash
# Using evtx_dump.py this converts all evtx files to XML in a given directory.
# Then sends the to an output directory.
# evtx_dump.py can be found here: https://github.com/williballenthin/python-evtx


if [ -d "$1output" ]
then
	echo "Sending files to $1output"
else
	mkdir "$1output"
	echo "Created output directory in $1output"
fi


for FILE in "$1"*.evtx
do 
	f=$(basename "$FILE") # Gets the filename and not the extension
	name="${f%.*}"
	
	python3 evtx_dump.py $FILE > "$1output/extracted_$name.xml"
done
