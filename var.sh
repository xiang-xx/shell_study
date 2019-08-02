#!/bin/bash
# 变量
name=hahahaha
echo $name
echo 使用 {} 输出为 ${name}

test_func() {
  echo "function name is $FUNCNAME"
}
test_func

echo $HOSTNAME
echo $HOSTTYPE
echo $MATCHTYPE
echo $LANG
echo $PWD
# echo $PATH
unset name
echo $name
