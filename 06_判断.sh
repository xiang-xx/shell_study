#!/bin/bash
# bash 的判断与循环与其他语言类似，有 if else elif case

# if 判断结构
# if expression; then
#    command
# elif expression; then
#    command
# else
#    command
# fi
if [ ! -e tmp.sh ];
then
  echo "tmp.sh 不存在，创建它"
  touch tmp.sh

  if [ -e tmp.sh ]; then
    echo "tmp.sh 创建好了"
  else
    echo "tmp.sh 创建失败"
  fi
else
  echo "tmp.sh 存在，删了它"
  rm tmp.sh
fi

# case 判断结构
# case VAR in
# var1) command ;;
# var2) command ;;
# ...
# *) command ;;
# esac
read -p "请输入数字：" NUM
case $NUM in
1) echo "输入为 1" ;;
2) echo "输入为 2" ;;
*) echo "输入为 其他" ;;
esac