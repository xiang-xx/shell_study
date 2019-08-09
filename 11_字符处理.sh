#!/bin/bash
# 字符处理

# 管道
# 从一个命令中读取输出，作为另一个命令的输入
# 示例
# ls | grep .sh | cut -f1 -d'.'

# grep
# grep 是基于行的文本搜索工具，该命令常用的参数有：
# grep [-ivnc] '需要匹配的字符' 文件名
# -i 不区分大小写
# -c 统计包含匹配的行数
# -n 输出行号
# -v 反向匹配
# 其中 '需要匹配的字符' 支持正则表达式模式
grep -in 'func' 01_变量.sh

# sort
# sort 可以对无序的数据进行排序
# sort [-ntkr] 文件名
# -n 采取数字排序
# -t 指定分隔符
# -k 指定第几列
# -r 反向排序

# 示例 使用空格分开每行，按第二列进行排序
echo "3 1 3
1 2 4
5 3 2
1 2 4
5 3 4
2 3 4" | sort -t ' ' -k 2

# uniq
# 使用 uniq 可以删除重复内容
echo "123
123
ab
ab" | uniq

# cut 截取文本
# cut -f指定的列 -d'分隔符'
# 指定的列可以用逗号分隔开，或者使用范围
echo "jhon 10 boy class1
lili 12 girl class2" | cut -f2-4 -d ' '

# tr 做文本转换
# tr '原字符' '目标字符' 其中原字符与目标字符一一对应
head -n 5 01_变量.sh | tr '[a-z]' '[A-Z]'

# paste 进行文本合并
# paste 会把文本按行合并。
# paste -d
echo "1
2
3" > tmp1.txt
echo "a
b
c" > tmp2.txt
paste -d: tmp1.txt tmp2.txt > tmp.txt
cat tmp.txt

# split 分割大文件
# split -l lines file dist_file
# 示例
split -l 5 01_变量.sh split_file
ls | grep split_file
rm split_file*

# sed 与 awk
# ...
# 如果现有工具不能满足你对字符串处理的需求，那就去了解一下 sed 和 awk 命令。

rm tmp*