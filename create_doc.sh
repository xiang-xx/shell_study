#!/bin/bash

docfile=docfile.md
rm $docfile

for file in `ls | grep '^\d'`
do
  name=`echo $file | cut -f 1 -d '.' | cut -f 2 -d'_'`
  echo "### $name" >> $docfile
  echo '' >> $docfile
  echo '```bash' >> $docfile
  cat $file >> $docfile
  echo '' >> $docfile
  echo '```' >> $docfile
done