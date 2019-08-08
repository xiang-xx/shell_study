#!/bin/bash
# 变量

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