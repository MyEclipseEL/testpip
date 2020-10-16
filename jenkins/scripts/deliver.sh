#!/bin/bash
APP_NAME=testpip-0.0.1.jar
APP_DIR=/var/jenkins_home/workspace/demo/target/
#APP_DIR=/var/jenkins-piptest/workspace/demo/target/
usage(){
    echo "Usage sh执行脚本.sh [start|stop|restart|status]"
    exit 1
}

# 检查程序是否正在运行
is_exist(){
    pid=`ps -ef | grep $APP_NAME | grep -v grep | awk '{print $2}' `
    # 如果存在返回0 不存在返回1
    if [ -z "${pid}" ]; then
        return 1
    else
        return 0
    fi
}
# 启动方法
start(){
    is_exist
    if [ $? -eq "0" ]; then
    echo "pid=${pid}"
    echo "${APP_NAME} is already runing. pid=${pid}"
    else
        nohup java -jar $APP_DIR$APP_NAME
    fi
}
# 停止方法
stop(){
    is_exist
    if [ $? -eq "0" ]; then
        echo "pid=${pid}"
        kill -9 $pid
    else
        echo "${APP_NAME} is not runing"
    fi
}
# 输出运行状态
status(){
    is_exist
    if [ $? -eq "0" ]; then
        echo "${APP_NAME} is runing. pid is ${pid}"
    else
        echo "${APP_NAME} is not runing"
    fi
}

# 重启
restart(){
    stop
    start
}

# 根据输入命令执行相应方法
case "$1" in
    "start")
    start
    ;;
    "stop")
    stop
    ;;
    "restart")
    restart
    ;;
    "status")
    status
    ;;
    *)
    usage
    ;;
esac
