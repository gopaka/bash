#! /bin/bash

echo Kindly enter the username and passord below

read -p 'username :' username
read -sp 'password :' password


echo Your username is $username and password is $password
echo Your bash version is $BASH_VERSION 
echo Your bash shell is `which bash`
echo Your home dir is $HOME and Your current directory is `pwd`

echo Please give 4 names to store in array
