#!/bin/bash

# 打印系统版本信息
echo "系统版本："
cat /etc/os-release
echo

# 查找可能包含明文密码的文件
echo "可能包含明文密码的文件："
grep -r -E 'password|passwd' /var/www/html
grep -r -E 'password|passwd' /opt
grep -r -E 'password|passwd' /home
echo

# 查找ccache文件
echo "ccache文件："
find / -name "ccache" 2>/dev/null
echo

# 查找Keytab文件
echo "Keytab文件："
find /home -name "*.keytab" 2>/dev/null
find /etc -name "*.keytab" 2>/dev/null
echo

# 查看重要文件（如passwd）
echo "重要文件（如passwd）："
tail /etc/passwd
ls -al /etc/passwd
echo

# 查看命令历史
echo "命令历史："
cat ~/.bash_history
echo

# 查看网络信息
echo "网络信息："
ifconfig
echo
