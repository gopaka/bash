#! /bin/bash

#check whether file is present

# in if statement, -e -to check file is present
# -s to check if file is empty
# -f to check if it is a file
# -d to check if it is a directory

echo -e "Enter the file name : \c"
#read file_name      //this will read the file

arg=("$@")     #this will accept the arg passed



if [ -e $arg ]
then
    echo "$arg is found"
else
    echo "$arg is not found"
fi
