## 简介
> 利用docker技术，去实现家用电视的一键部署
1. 微信公众号(调后端接口)去发布下载任务
2. 消息进入队列，等待下载
3. 下载完成后，回调通知用户进行观影
4. 定期做磁盘清理动作，将长时间不用的视频清除，当然支持配置(允许视频永不过期)
5. 客户端选用jellyfin(支持刮削信息、支持多平台)
6. 技术栈：后端(Python或者go)、中间件(kafka或者rabbitmq)、缓存(redis)、数据库(MySQL)

## 涉及服务
| 系统 | 功能 | 汉化 | 说明 |
| :---: | :---: | :---: | :---: |
| [jellyfin](https://jellyfin.org/) | 媒体服务器 | ⭕ | 刮削信息，提供观看服务 |


## 启动服务

```shell
git clone https://github.com/al6nlee/auto-TV
cd auto-TV
sh tools/init.sh           # 初始化脚本时执行
sh tools/start.sh          # 使用 docker swarm 一键部署
```

## 访问服务
```
http://127.0.0.1:8096
```