#!/bin/bash
FILE=$1
# read $FILE using the file descriptors

exec 3<$FILE

while read line
do
	# use $line variable to process line
	echo $line
done <&3

while read line
do
	# use $line variable to process line
	printf '%s' "$line"
done <&0
