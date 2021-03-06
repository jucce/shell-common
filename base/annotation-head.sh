#!/bin/bash
#********************************************************************
#Description：
#Author：jucce
#使用事例：
#CreateTime：2021-07-14 10:05:14
#********************************************************************
#!/bin/bash
#如果文件名不存在
if [ ! "$1" ]
then
  echo 'Please input an argument as the fileName!'
  exit 1
fi
#如果文件已经创建，直接用vim打开
if [ -f "$1" ]
then
 vim "$1"
 exit 2
fi
#创建文件
touch "$1"
#添加注释信息
echo "#!/bin/bash">>"$1"
echo "#Description:">>"$1"
echo "">>"$1"
echo "#Author:$USER">>"$1"
echo "#Version:1.0">>"$1"
echo "#CreateTime:`date +%F' '%H:%M:%S`">>"$1" 
vim "$1"
