#!/bin/bash

while read keys; do
  echo $keys | awk -F: '{print $1}' | sed 's/ /_/g' | sed 's/$/: |/g' | awk '{print " ",$0}'
  echo $keys | grep -o ":.*" | cut -f2- -d: | sed 's/ //g' | gpg --always-trust --armor --encrypt -r saltmaster-dev | awk '{print "   ",$0}' 
done <keylist.txt
