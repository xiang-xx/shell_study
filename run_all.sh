#!/bin/bash

for File in `ls | grep '^\d'`
do
  echo "==== $File ===="
  bash $File
  echo "==== $File ===="
  sleep 1
done