# Flora-music
个人音乐网站



## 仓库地址

后端 music-server：https://github.com/qinxiang96/music-server.git

管理端 music-manage：https://github.com/qinxiang96/music-manage.git

前端 music-client：https://github.com/qinxiang96/music-client.git

# 一、开发环境准备  
系统开发平台：JDK1.8 + Mac OS + Maven3.6.1  
开发语言：JavaEE + vue2.9.6  
后台框架：Springboot2.7.7  
数据库：Mysql8.0.29 (采用的docker容器镜像启动)    
缓存：Redis 7.0.0  
数据库工具：Navicat  
开发工具：IDEA VSCode  
浏览器：Chrome  

# 二、部署方式
## 1、后端 music-server
打包：IDEA右侧-Maven-Pakage  
jar包位置：music-server->target->music-0.0.1-SNAPSHOT.jar  
新建文件music-将jar包和资源文件(avatorImages、img、song)放入该目录->/Users/qinxiang/Documents/music

运行命令：终端  
cd /Users/qinxiang/Documents/music  
java -jar music-0.0.1-SNAPSHOT.jar  

## 2、管理端 music-manage
cd /Users/qinxiang/Documents/music-manage  
npm install  
npm run dev  
访问部署网址即可使用(后端处于运行状态，数据库和缓存保持连接状态)  

## 3、前端 music-client
cd /Users/qinxiang/Documents/music-client  
npm install  
npm run dev  
访问部署网址即可使用(后端处于运行状态，数据库和缓存保持连接状态)  

## 4、数据库 music
运行music.sql

# 三、项目介绍
项目描述：  
用户端实现用户登录，短信验证注册，个人信息修改，首页歌曲歌单信息查看，歌曲的播放/切换/歌词展示/评论/下载/搜索/收藏等，以及我的音乐等功能；管理员端实现登录、图形数据总览、用户管理、歌单管理、歌手管理、歌曲管理、评论管理等功能。  

技术描述：  
项目分为后端、管理端和用户端三大模块，后端使用SpringBoot+SpringMVC+Mybatis，管理端和用户端使用Vue+ElementUI，存储使用Mysql、Redis缓存以及整合Spring Cache，数据验证使用Spring Validation，数据加密使用Spring Security。  

展示：  

用户端：  

<img width="1437" alt="image" src="https://user-images.githubusercontent.com/101503750/215763516-cc5ae364-343c-4d99-859d-9350f30b34c3.png">

管理端：  

<img width="1439" alt="image" src="https://user-images.githubusercontent.com/101503750/215763960-74de138b-691d-4747-bfd1-847de04faf26.png">

<img width="1437" alt="image" src="https://user-images.githubusercontent.com/101503750/215763835-9755c707-370b-4073-a2cc-8929a2249bbf.png">





