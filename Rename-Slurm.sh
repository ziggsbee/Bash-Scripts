#!/bin/bash

<<COMMENT
MIT License

Copyright (c) 2020 nwporsch

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

COMMENT

# Renames all slurm files in the directory with the problem size and the thread number

FILES="./*"
for file in find $FILES -type f -name "slurm-*"
do
  # Reads in the file to see the last result produced then does string manipulation to find the value
	PROBLEM=$(grep ": 0" $file | grep -v "Reading" | tail -1) 
	PROBLEM=${PROBLEM%:*0}
	PROBLEM=${PROBLEM#*-}

  # Finds the thread count
	THREADS=$(grep "thread" $file)
	THREADS=${THREADS%threads*}
	THREADS=${THREADS#*with}

	FILE_NAME="$(printf "%s_%s.out" $PROBLEM $THREADS)"
	echo $FILE_NAME
  #copies over the current slurm file to the corrected file name
	cp $file $FILE_NAME
done

# Creates the slurm directory
mkdir slurm
# Move all slurm files to that directory just in case there was any errors.
mv slurm-* slurm
