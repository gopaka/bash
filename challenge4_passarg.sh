#! /bin/bash

#this will accept argument arun and also accept 2 numbers and display sum

echo please enter the argument
#echo $1
arg=("$@")

echo ${arg[@]}

if [ ${arg[1]} == 10 ]
then 
      echo count is 10
elif [[ ${arg[0]} == 'arun' ]]
then
     echo entered is arun
else
     echo entered is not arun
    echo count is not 10
fi

