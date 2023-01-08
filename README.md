# Flora-music
个人音乐网站

# 一、开发环境准备  
系统开发平台：JDK1.8 + Mac OS + Maven3.6.1  
开发语言：JavaEE + vue2.9.6  
后台框架：Springboot2.7.7  
数据库：Mysql8.0.29 (采用的docker容器镜像启动)  
数据库工具：Navicat  
开发工具：IDEA VSCode  
浏览器：Chrome  

# 二、部署方式
## 1、后端 music-server
打包：IDEA右侧-Maven-Pakage  
jar包位置：music-server->target->music-0.0.1-SNAPSHOT.jar  
在course/music/code同级下新建文件music-将jar包和资源文件(avatorImages、img、song)放入该目录->/Users/qinxiang/Documents/course/music/music

运行命令：终端  
cd /Users/qinxiang/Documents/course/music/music  
java -jar music-0.0.1-SNAPSHOT.jar  

## 2、管理端 music-manage
cd /Users/qinxiang/Documents/course/music/code/music/music-manage  
npm install  
npm run dev  
访问部署网址即可使用(后端处于运行状态，数据库保持连接状态)  

## 3、前端 music-client
cd /Users/qinxiang/Documents/course/music/code/music/music-client  
npm install  
npm run dev  
访问部署网址即可使用(后端处于运行状态，数据库保持连接状态)




