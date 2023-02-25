#!/bin/bash

# Define the string you want to grep
search_string='kUser'

# Grep the string in the file
grep_output=$(grep "$search_string" $PWD/source_details.json -A3)

# Print each line of the grep output on a new line
while read -r line; do
  printf "%s\n" "$line" 
done <<< "$grep_output" > output.json


