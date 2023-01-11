#! /bin/bash

#this will accept argument arun and also accept 2 numbers and display sum

echo please enter your name
#echo $1
arg=("$@")

echo ${arg[0]}

if [ ${arg[0]} == 10 ]
    then 
      echo count is 10
      else
      echo count is not 10
fi

if [[ ${arg[0]} == 'arun' ]]
    then
     echo entered is arun
     else
     echo entered is not arun
fi

