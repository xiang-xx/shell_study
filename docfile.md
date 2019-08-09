### 变量

```bash
#!/bin/bash
# 变量
echo "01_变量.sh"

# 变量定义与赋值，等号两边不能用空格分开
name=hahahaha
echo $name
echo 也使用 {} 输出为 ${name}

# 一些特殊变量
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

# 只读变量
readonly R0=100
R0=200
echo $?   # 上一条指令是错误的，所以 $? 为非0

# 变量的作用域
# 变量的作用域又叫“命名空间”，相同名的变量可以在不同命名空间定义。
# 在 Linux 系统中，不同进程 ID 的 Shell 默认为不同的命名空间
VAR_01=100
function update() {
  # 在函数内外访问到的是同一个变量
  VAR_01=200
}
update
echo 变量 VAR_01: $VAR_01

function update02() {
  # 可以使用 local 关键字声明函数内部的局部变量
  local VAR_01=300
}
update02
echo "local 声明的本地变量不会影响全局变量，VAR_01: ${VAR_01}"

# 子 Shell 不会继承变量
echo "echo 子 shell 的 VAR_01 为 \$VAR_01" > tmp.sh
bash ./tmp.sh

# 导出变量（环境变量），子 Shell 可继承，相当于子 Shell 启动时复制了导出的变量
export VAR_01
bash ./tmp.sh

# 在子 Shell 中修改 VAR_01 不会影响

rm ./tmp.sh     # 删除 tmp.sh
```
### 转义和引用

```bash
#!/bin/bash
# 转义
# 跟其他编程语言里的转义一样，使用转义符 \
echo \# 使用转义输出注释符号 \#
Dollar=123
echo \$Dollar is $Dollar
echo 8 \* 8 = 64

# 引用
# Shell 中一共有 4 中引用符，分别是 双引号，单引号，反引号，转义符

# "" 双引号：部分引用，可以解释变量
echo "\$Dollar is $Dollar"
# 带不带双引号看起来一样，但是对于输出空格有区别
VAR="A     B      C"
echo 不带引号对于连续空格只输出一个：$VAR
echo "带引号会把所有空格输出：$VAR"

# '' 单引号：全引用，只按照字面意思输出内容，转义符也不能用了
echo '$Dollar 在单引号内还是 $Dollar。'
echo '转义符在单引号内输出 \，单引号只把内容作为字面量输出'
echo '转义符不能用，单引号内不能输出单引号'

# `` 反引号：命令替换，将命令的标准输出作为值赋给某个变量
# 命令替换也可以使用 $(命令) 的形式
LS=`ls`
echo "=== LS ==="
echo $LS
echo "=== LS ==="
LSA=$(ls -a)
echo $LSA
# $() 支持嵌套
$(echo $(ls) > tmp.sh)
TMP=$(cat tmp.sh)
echo === tmp ===
echo $TMP
echo === tmp ===
rm tmp.sh

```
### 运算符

```bash
#!/bin/bash
# 运算符
# Shell 的运算符主要有：
# 比较运算符（整数比较），字符串运算符（字符串测试），文件操作运算符（用于文件测试），逻辑运算符，算术运算符，位运算符，自增自减等

# 算术运算符：加减乘除余幂 以及加等，减等，乘等，初等，余等
A=1
B=2
let "C = $A + $B"  # 需要使用 let 关键字执行运算
echo $C

# 位运算符：左移 右移 按位与 按位或 按位非 按位异或
var1=1
var2=5

let "var = $var1<<2"
echo $var
let "var = $var1&$var2"
echo $var
# 按位非就是 -($var+1)
let "var = ~8"
echo $var

# 自增自减，与其他语言类似，分为前置和后置的区别
var1=1
echo "var1 is $var1"
let "var2=++var1"
echo "var2 前置自增 var1，$var2"
var1=1
let "var2=var1++"
echo "var2 后置自增 var1，$var2"

# 其他算术运算
# 使用 $[] 做运算：$[] 和 $(()) 类似，可用于简单的算术运算
echo '$[1+1]' is $[1+1]
echo '$[5 ** 2]' is $[5 ** 2]

# 使用 expr 做运算：使用 expr 要求操作数和操作符之间用空格分开，否则会被当成字符串
expr 1+1
expr 1 + 1
expr 2 \* 2   # 特殊字符运算符需要转义

# 算术扩展： $((算术表达式))
echo $((2*(1+1)))

# 使用 bc 做运算
# 前面介绍的运算只能基于整数，如果想要计算高精度小数，可以使用 Linux 下的 bc 工具。
# bc 是一款高精度计算语言，支持顺序执行，判断，循环，函数等，下面是一个简单的例子
NUM1=1.2
NUM2=2.3
SUM=$(echo "$NUM1+$NUM2" | bc)
echo $SUM
# 你也可以直接在命令行下输入 bc，然后回车进入 bc 命令行模式
```
### 特殊字符

```bash
#!/bin/bash
# 特殊字符

# 通配符
# 通配符用于模式匹配，常见的通配符有 *、? 和用 [] 括起来的字符序列。
# 例如：a* 可以匹配以 a 开头的任意长度的字符串，但是不能包含 点号和斜线号
# 所以 a* 不能匹配 abc.txt
# ? 可以匹配任意单个字符
# [] 表示可以匹配其中的任意一个，比如 [abc] 可以匹配a或者b或者c
# [] 中可以用 - 表示起止。比如 [a-z] 匹配所有小写字母
# *? 在 [] 表示普通字符，没有通配功效

# 引号
# 02_转义和引用.sh 中介绍过，主要有单引号，双引号，反引号

# 注释符号

# 大括号
# 大括号 {} 在 Shell 中的用法很多
# 1. 变量扩展 ${PWD}
# 2. 通配符扩展
# 3. 语句块
# 通配符扩展的例子:
touch file_{A,B}
ls . | grep file
rm file_A
rm file_B

# 其他
# 位置参数
# $0: 脚本名本身
# $1,$2... 脚本的第一个参数，第二个参数...
# $# 变量总数
# $* $@ 显示所有参数
# $? 前一个命令的退出的返回值
echo $?    # 正常退出，结果为 0
rm qweqweqweqwe
echo $?    # 出现错误时，结果为 非0
# $! 最后一个后台进程的 ID 号
```
### 测试

```bash
#!/bin/bash
# 测试：程序运行过程中经常需要根据实际情况执行特定的命令，
# 比如，判断某个文件是否存在，如果不存在，可能需要先创建该文件
# ls tmp.sh
# echo $?

# 测试结构
# 1. test expression   使用 test 指令
# 2. [expression]      使用 []

# 文件测试
# 1. test file_operator FILE
# 2. [file_operator FILE]
test -e tmp.sh
echo $?         # 不存在，上一个指令结果为 1
[ -e tmp.sh ]
echo $?

# 文件测试符，文件不存在时，均返回假
# -b FILE 当文件存在且是块文件时，返回真，否则为假
# -c FILE 当文件存在且是设备文件时，返回真，否则为假
# -d FILE 测试文件是否为目录
# -e FILE 测试文件或目录是否存在
# -f FILE 测试文件是否为普通文件
# -x FILE 判断文件是否为可执行文件
# -w FILE 判断文件可写
# -r FILE 判断文件可读
# -l FILE 判断是否为链接文件
# -p FILE 判断是否为管道文件
# -s FILE 判断文件存在且大小不为 0
# -S FILE 判断是否为 socket 文件
# -g FILE 判断文件是否设置了 SGID
# -u FILE 判断文件是否设置了 SUID
# -k FILE 判断文件是否设置了 sticky 属性
# -G FILE 判断文件属于有效的用户组
# -O FILE 判断文件属于有效的用户
# FILE1 -nt FILE2 FILE1 比 FILE2 新时返回真
# FILE1 -ot FILE2 FILE1 比 FILE2 旧时返回真

# 字符串测试
# 主要包括 等于、不等于、大于、小于、是否为空
# -z string 为空时返回真
echo "字符串测试"
[ -z "" ]
echo '[ -z "" ]' $?   # 结果 0，表示为真

# -n string 非空时返回真
[ -n "aaa" ]
echo '[ -n "aaa" ]' $?
[ "string1" = "string2" ]
echo '[ "string1" = "string2" ]' $?
[ "string1" != "string2" ]
echo '[ "string1" != "string2" ]' $?
[ "string1" > "string2" ]
echo '[ "string1" > "string2" ]' $?
[ "string1" < "string2" ]
echo '[ "string1" < "string2" ]' $?

# 整数比较
# -eq 意 相等
# -gt 意 >
# -lt 意 <
# -ge 意 >=
# -le 意 <=
# -ne 意 !=
[ 1 -eq 2 ]
echo '[ 1 -eq 2 ]' $?
[ 1 -gt 2 ]
echo '[ 1 -gt 2 ]' $?
[ 1 -lt 2 ]
echo '[ 1 -lt 2 ]' $?
[ 1 -ge 2 ]
echo '[ 1 -ge 2 ]' $?
[ 1 -le 2 ]
echo '[ 1 -le 2 ]' $?
[ 1 -ne 2 ]
echo '[ 1 -ne 2 ]' $?

# 逻辑测试符与逻辑运算符
# ! expression 取反
# expression -a expression 同为真，结果为真        
# expression -o expression 只有有一个为真，结果为真
touch tmp.sh
[ ! -e tmp.sh ]
echo '[ ! -e tmp.sh ]' $?

[ -e tmp.sh -a -e tmp1.sh ]
echo '[ -e tmp.sh -a -e tmp1.sh ]' $?

[ -e tmp.sh -o -e tmp1.sh ]
echo '[ -e tmp.sh -o -e tmp1.sh ]' $?

# -a -o 可以用 && 和 || 替代，不过写法上会有区别
[ -e tmp.sh ] && [ -e tmp1.sh ]
echo '[ -e tmp.sh ] && [ -e tmp1.sh ]' $?

[ -e tmp.sh ] || [ -e tmp1.sh ]
echo '[ -e tmp.sh ] || [ -e tmp1.sh ]' $?

rm tmp.sh
rm string2
```
### 判断

```bash
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

rm tmp.sh
```
### 循环

```bash
#!/bin/bash.sh
# 循环
# Shell 的循环主要有 for、while、until、select 几种

# for 循环
# 带列表的 for 循环：
# for VAR in (list)
# do
#   command
# done
for NUMBER in 1 2 3 4 5
do
  echo $NUMBER
done

fruits="apple banana orange"
for FRUIT in ${fruits}
do
  echo $FRUIT
done

# 循环数字时可以使用 {a..b} 表示从 a 循环到 b
for N in {2..10}
do
  echo $N
done
# 其中 {2..10} 可以用 seq 命令替换
echo "echo with seq:"
for N in $(seq 2 10)
do
  echo $N
done
# seq 命令可以加 “步长”
for N in $(seq 1 2 20)
do
  echo $N
done

# 可以看出，for in 后面的内容可以是任意命令的标准输出
# 比如，我们可以输出当前目录下的所有带 sh 的文件
for VAR in $(ls | grep sh)
do
  echo $VAR
done

# 如果 for 后面没有 in ，则相当于是 in $@
# 你可以执行 bash 07_循环.sh a b c 试一试
for VAR
do
  echo $VAR
done

# 类 C 的 for 循环
# for ((exp1; exp2; exp3))
# do
#   command
# done
for ((i=0, j=100; i < 10; i ++))
do
  echo $i $j
done


# while 循环
# 语法如下：
# while expression
# do
#   command
# done
# while ((1)) 会无限循环
COUNT=0
while [ $COUNT -lt 5 ]
do
  echo $COUNT
  let "COUNT++"
done

# while 按行读取文件
echo "john  30  boy
sue   20  girl" > tmp.txt
while read LINE
do
  NAME=`echo $LINE | awk '{print $1}'`
  AGE=`echo $LINE | awk '{print $2}'`
  SEX=`echo $LINE | awk '{print $3}'`
  echo $NAME $AGE $SEX
done < tmp.txt    # 输入重定向
rm tmp.txt


# until 循环
# until 与 while 类似，区别在于 until 判断为 否，会继续循环，而 while 判断为 真，才继续循环
# until ((0)) 会无限循环
COUNT=0
until [ $COUNT -gt 5 ]
do
  echo $COUNT
  let "COUNT++"
done


# select 循环
# select 是一种菜单式的循环方式，语法结构与 for 相似，每次循环的值由用户选择
echo "choose your menu:"
select MENU in "apple" "banana" "orange" "exit"
do
  echo "you choose $MENU"
  if [[ $MENU = "exit" ]]
  then
    break
  else
    echo "choose again"
  fi
done

# 循环控制，break continue，与其他编程语言一致
```
### 函数

```bash
#!/bin/bash
# 函数

# 函数的定义
# function FUNCTION_NAME() {
#   command
# }
# 省略 function 关键字
# FUNCTION_NAME() {
#   command
# }            
function func1 {
  echo 1 
}
func2() {
  echo 2 
}

# 函数调用
func1
func2

# 函数返回值
func3 () {
  echo '请输入函数的返回值:'
  read N
  return $N
}
func3
echo "上个函数的返回值是" $?   # 使用 $? 获取上一条指令的返回值

# 函数参数
# 与脚本的参数使用一致
func4 () {
  echo "第一个参数 $1"
  echo "第二个参数 $2"
  echo "所有参数 $@"
  echo "参数数量 $#"
}
func4 a b c

# 使用 set 可以指定位置的脚本（或函数）参数值
func5() {
  set q w e
  echo "参数1 $1"
  echo "所有参数: $@"
}
func5

# 移动位置参数：在 Shell 中可以使用 shift 命令把参数左移一位
func6() {
  while [ $# -gt 0 ]
  do
    echo current \$1 is $1
    shift
  done
}
func6 q w e r t

# 实现一个 pow 函数
pow() {
  let "r=$1**$2"
  return $r

}
pow 2 5
echo $?
```
### 重定向

```bash
#!/bin/bash
# 重定向
# 重定向是指将原本由标准输入输出的内容，改为输入输出的其他文件或设备

# 系统在启动一个进程时，会为该进程打开三个文件：
# 标准输入（stdin）、标准输出（stdout）、标准错误（stderr）
# 分别用文件标识符 0、1、2 标识
# 如果要为进程打开其他的输入输出，需要从证书 3 开始标识
# 默认情况下，标准输入为键盘，标准输出和标准错误为显示器


# 常见的 IO 重定向符号
# > 标准输出覆盖重定向，将命令的标准输出重定向到其他文件中，会直接覆盖原文件内容
# >> 标准输出追加重定向，将命令的标准输出重定向到其他文件中，不会覆盖文件，会在文件后面追加
# >& 标识输出重定向，讲一个标识的输出重定向到另一个标识的输入
# < 标准输入重定向，命名将从指定文件中读取输入，而不是从键盘中读取输入
# | 管道，从一个命令中读取输出，作为另一个命令的输入


# 输出重定向
# 把原本标准输出到屏幕的内容，重定向到 tmp.txt 文件中
echo "result1" > tmp.txt
cat tmp.txt

echo "result2" > tmp.txt
cat tmp.txt

# 输出追加
echo "输出追加："
echo "result3" >> tmp.txt
echo "result3" >> tmp.txt
echo "result3" >> tmp.txt
cat tmp.txt
rm tmp.txt

# 标识输出重定向
echo "未重定向标准错误，会直接输出到页面"
# 制定一个不存在的命令
adhfafahdfakdf > tmp.txt
echo "tmp.txt:" `cat tmp.txt`
rm tmp.txt
echo "重定向标准错误到标准输出，会输出到文件中"
asiiaodfuoaf > tmp.txt 2>&1
echo "tmp.txt:" `cat tmp.txt`

# 标准输入重定向
echo "标准输入重定向："
while read Line
do
  echo $Line
done < tmp.txt

# 管道
# 获取 .sh 文件的名称
ls | grep .sh | cut -f1 -d'.'

# 使用 exec
# exec 是 Shell 的内建命令，执行这个命令时，系统不会启动新的 Shell，而是用被执行的命令替换当前的 Shell 进程
# 因此，在执行完 exec 的命令后，该 Shell 进程将会主动退出
# 例如：执行 exec ls ，后续的其他命令将不会执行。你也可以直接打开 Shell，执行 exec ls 试试
# 此外，exec 还可以用于 I/O 重定向。
# exec < file 将 file 文件中的内容作为 exec 的标准输入
# exec > file 将 file 文件作为标准输出
# exec 3<file 指定文件标识符
# exec 3<&- 关闭文件标识符
# exec 3>file 将写入文件标识符的内容写入到指定文件（输出重定向）
# exec 4<&3 创建文件标识符4，4是3的拷贝 （类似标识输出重定向 2>&1)
# 注：不同的 shell 环境可能会有所差别，比如我在 mac 的 zsh 下就不能正常使用 exec 重定向

# Here Document
# here doc 又称为 此处文档，用于在命令或脚本中按行输入文本。
# 格式为 command << delimiter
# delimiter 是用于标注结束的分隔符

# 示例：
# 你可以在命令行下输入 sort << END 试试
# 你可以在命令行下输入 cat > tmp.txt << END 试试
cat << EOF > tmp.txt
1
2
3
EOF
cat tmp.txt

rm tmp.txt
```
### 数组

```bash
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

```
### 字符处理

```bash
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
```
### 示例-操作数据库

```bash
#!/bin/bash
USER=root
PASSWORD=root

# 使用 -e 执行
databases=`mysql -u$USER -p$PASSWORD -e"show databases"`

for db in $databases
do
  echo "Tables in $db:"
  # 使用 here doc 执行代码块
  mysql -u$USER -p$PASSWORD << EOF
use $db; 
show tables;
EOF
  # 也可以使用输入重定向
  # mysql -u$USER 0pPASSWORD < select.sql
done
```
