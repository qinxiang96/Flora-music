# music

# 部署方式
1、后端
打包：右侧-Maven-Pakage
jar包位置：music-server->target->music-0.0.1-SNAPSHOT.jar
新建文件-将jar包和资源文件放入该目录->/Users/qinxiang/Documents/course/music/music

运行命令：终端
cd /Users/qinxiang/Documents/course/music/music
java -jar music-0.0.1-SNAPSHOT.jar

2、管理端和前端
cd /Users/qinxiang/Documents/course/music/code/music/music-manage
npm install
npm run dev
访问部署网址即可使用(后端处于运行状态，数据库保持连接状态)

cd /Users/qinxiang/Documents/course/music/code/music/music-client
npm install
npm run dev
访问部署网址即可使用(后端处于运行状态，数据库保持连接状态)



