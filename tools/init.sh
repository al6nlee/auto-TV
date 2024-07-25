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
if [[ ! -d ${MEDIA_PATH}/movie ]]; then
	sudo mkdir ${MEDIA_PATH}/movie
	echo "✅  创建目录成功：${MEDIA_PATH}/movie"
fi
if [[ ! -d ${MEDIA_PATH}/serial ]]; then
	sudo mkdir ${MEDIA_PATH}/serial
	echo "✅  创建目录成功：${MEDIA_PATH}/serial"
fi
if [[ ! -d ${MEDIA_PATH}/anime ]]; then
	sudo mkdir ${MEDIA_PATH}/anime
	echo "✅  创建目录成功：${MEDIA_PATH}/anime"
fi
if [[ ! -d ${MEDIA_PATH}/download ]]; then
	sudo mkdir ${MEDIA_PATH}/download
	echo "✅  创建目录成功：${MEDIA_PATH}/download"
fi
echo ""

echo "修改目录权限 ......"
sudo chown -R ${USERNAME}:${GROUPNAME} ${MEDIA_PATH}
sudo chmod -R 770 ${MEDIA_PATH}
echo "✅  修改媒体目录权限成功"
echo ""

DEVICE=""
if [[ -d "/dev/dri" ]]; then
	DEVICE="/dev/dri:/dev/dri"
fi
if [[ -d "/dev/vchiq" ]]; then
	DEVICE="/dev/vchiq:/dev/vchiq"
fi
if [[ ${DEVICE} ]]; then
	sudo echo "    devices:" >> ./docker-compose.yml
	sudo echo "      - ${DEVICE}" >> ./docker-compose.yml
	echo "✅  添加硬件加速设备成功"
else
	echo "✖️  未检测到 /dev/dri 或 /dev/vchiq，无法为 Emby 添加硬件加速设备"
fi
echo ""

echo "检查网络是否存在"
if ! docker network ls --format '{{.Name}}' | grep -w "$NETWORK_NAME" > /dev/null; then
  echo "网络 $NETWORK_NAME 不存在，正在创建..."
  docker network create --driver overlay $NETWORK_NAME
else
  echo "网络 $NETWORK_NAME 已存在，跳过创建。"
fi
echo ""

echo "✅  程序执行完毕 ✅"
