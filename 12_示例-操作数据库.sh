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