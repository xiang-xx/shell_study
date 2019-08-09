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
# 可以获取子数组，下面示例为获取数组的第 1、2 下标位置的元素
echo ${mArray[@]: 1:2}
# 可以获取数组中某个元素的若干字符，下面示例为获取数组中第二个元素的 从0开始 3个字符
echo ${mArray[1]: 0:3}

# 合并数组
Front=("javascript" "typescript")   # 数组声明也可以忽略 declear -a
Conn=(${mArray[@]} ${Front[@]})
echo ${Conn[@]}
echo ${#Conn[@]}            # 合并得到数组的长度

# 替换元素
mArray=(${mArray[@] /123/"java"})
echo ${mArray[@]}

# 取消数组或元素
unset mArray[1]
echo "取消下标为 1 的元素后，数组为：${mArray[@]}，数组长度为 ${#mArray[@]}"
# 需要注意的是，数组的 1 位置的元素变为了空，而不是后面的元素向前移动
echo "数组 1 位置的元素为 ${mArray[1]}， 2 位置的元素为 ${mArray[2]}"
