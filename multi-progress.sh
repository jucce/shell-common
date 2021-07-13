#!/bin/bash
#********************************************************************
#Description：多shell进程运行脚本
#Author：jucce
#使用事例： /bin/bash MultiWmbEffectLog.sh  WmbEffectLogConsumer.php 4 /tmp/logs
#CreateTime：2021-07-13 11:42:21
#********************************************************************

##获取shell 当前路径
path=$(cd `dirname $0`; pwd)
ps='/bin'
projectPath=${path%$ps*}
#脚本文件名字
JOB=$1
#脚本绝对路径
JOB_PATH="${projectPath}/${JOB}"
#后台指定运行几个shell
NUM_WORKERS=$2
#日志文件名
LOG_PATH_I=$3
PHP_PATH=`which php`


LOG_PATH="${LOG_PATH_I}.$(date +%Y%m%d)"
#脚本运行命令
CMD_WORKER="${PHP_PATH} ${JOB_PATH}"

#检测当前运行几个shell
NUM_RUNNING=`ps -ef | grep "${CMD_WORKER}" | grep -v grep |awk '{print $2}'|wc -l`


#NUM_RUNNING=$(pgrep -f "${CMD_WORKER}" | wc -l)

echo num_running ${NUM_RUNNING}

function PROCESS_CREATOR() {
    for i in $(seq 1 ${3})
    do
        nohup ${1} 1>>${2} 2>&1 &
        echo "nohup ${1} 1>>${2} 2>&1 &"
    done
}
#检测是否少于指定预期的shell数量
if [ ${NUM_RUNNING} -lt ${NUM_WORKERS} ]
then
    NUM_NEED=$(echo $((${NUM_WORKERS}-${NUM_RUNNING})))
    #bc or expr
    echo num_need ${NUM_NEED}
    PROCESS_CREATOR "${CMD_WORKER}" "${LOG_PATH}" "${NUM_NEED}"
fi
