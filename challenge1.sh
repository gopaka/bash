#! /bin/bash
 
echo This is my Bash version $BASH_VERSION
echo This is my home dir $HOME
echo This is my present working directory $PWD

echo 'Please enter the numbers(2 numbers)' 
read -a a

echo ${a[0]} and ${a[1]} are in the array
sum=$((a[0] + a[1]))
echo $sum
sub=$((a[0] - a[1]))
echo $sub
div=$((a[0] / a[1]))
echo $div
