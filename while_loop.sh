#!/bin/bash

# 输出斐波那契数列
read MAX
a1=1
a2=1
echo $a1
echo $a2
while [[ "$a2 + $a1" -le "$MAX" ]]
do
  let "a3=$a1 + $a2"
  echo $a3
  let "a1 = $a2"
  let "a2 = $a3"
done