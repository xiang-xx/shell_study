#!/bin/bash
# 数组

# bash 只支持一维数组

# 定义数组
declare -a mArray
mArray[0]="nihao"
mArray[1]=2

# 定义时赋值，数组的元素用空格分开，其他字符会被当成值，比如 "php", 会被当成 php,
declare -a mArray=("php" "python" 123)

# 数组取值，需要用 ${数组名[索引]} 语法
echo ${mArray[0]}
echo ${mArray[1]}
echo ${mArray[2]}
# 使用 @ * 可以索引全部元素
# @ 得到以空格分开的元素值
# * 得到整个字符串
echo ${mArray[@]}
echo ${mArray[*]}

# 数组长度
echo "数组长度是 ${#mArray[@]}"
echo "数组长度是 ${#mArray[*]}"

# 数组截取
echo ${}