#!/bin/bash
set -e

echo "|------------------------------------------------------|"
echo "|                                                      |"
echo "|                       Auto TV                        |"
echo "|         https://github.com/al6nlee/auto-TV           |"
echo "|                                                      |"
echo "|------------------------------------------------------|"
echo ""
echo "|------------------------------------------------------|"
echo "|                     当前配置如下                     |"
echo "|------------------------------------------------------|"
cat ./global.env
echo "|------------------------------------------------------|"
echo ""
echo "确认信息，并继续执行？（是：y，否：n）："
read CONFIRM
YES=y
if [[ "${CONFIRM}" == "${YES}" ]]; then
	echo ""
else
	echo "取消并退出"
	exit
fi

echo "开始创建目录 ......"
source ./global.env
if [[ ! -d ${MEDIA_PATH} ]]; then
	sudo mkdir -p ${MEDIA_PATH}
	echo "✅  创建目录成功：${MEDIA_PATH}"
fi
if [[ ! -d ${MEDIA_PATH}/movies ]]; then
	sudo mkdir ${MEDIA_PATH}/movies
	echo "✅  创建目录成功：${MEDIA_PATH}/movies"
fi
if [[ ! -d ${MEDIA_PATH}/series ]]; then
	sudo mkdir ${MEDIA_PATH}/series
	echo "✅  创建目录成功：${MEDIA_PATH}/series"
fi
if [[ ! -d ${MEDIA_PATH}/books ]]; then
	sudo mkdir ${MEDIA_PATH}/books
	echo "✅  创建目录成功：${MEDIA_PATH}/books"
fi
echo ""

echo "修改目录权限 ......"
sudo chown -R ${USERNAME}:${GROUPNAME} ${MEDIA_PATH}
sudo chmod -R 770 ${MEDIA_PATH}
echo "✅  修改媒体目录权限成功"
echo ""

echo "✅  程序执行完毕 ✅"
