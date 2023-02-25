#!/bin/bash

# Declare the interface
INTERFACE=$1

# Print a nice header
echo "Download (KiB/s)  Upload (KiB/s)"

# Start an infinite loop
while true; do 
  # Read the line of the interface
  LINE=`grep $INTERFACE /proc/net/dev` 
  # Wait 1 second
  sleep 1 
  # Read the line again
  LINE2=`grep $INTERFACE /proc/net/dev` 
  # Using AWK to get the download and upload speed
  RX=`echo $LINE | awk '{print $2}'` 
  TX=`echo $LINE | awk '{print $10}'` 
  RX2=`echo $LINE2 | awk '{print $2}'` 
  TX2=`echo $LINE2 | awk '{print $10}'` 
  # Calculate the difference between the 2nd read and the first one
  RXDIF=`echo "$RX2 - $RX" | bc`
  TXDIF=`echo "$TX2 - $TX" | bc`
  # Divide by 1024 because KiB/s is a better human readable format
  RXDIF=`echo "scale=2; $RXDIF / 1024" | bc`
  TXDIF=`echo "scale=2; $TXDIF / 1024" | bc`
  # Print the result
  echo "$RXDIF    $TXDIF"
  done