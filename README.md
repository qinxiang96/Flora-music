# Flora-music
个人音乐网站

# 部署方式
1、后端 music-server
打包：IDEA右侧-Maven-Pakage
jar包位置：music-server->target->music-0.0.1-SNAPSHOT.jar
在course/music/code同级下新建文件music-将jar包和资源文件(avatorImages、img、song)放入该目录->/Users/qinxiang/Documents/course/music/music

运行命令：终端
cd /Users/qinxiang/Documents/course/music/music
java -jar music-0.0.1-SNAPSHOT.jar

2、管理端 music-manage
cd /Users/qinxiang/Documents/course/music/code/music/music-manage
npm install
npm run dev
访问部署网址即可使用(后端处于运行状态，数据库保持连接状态)

3、前端 music-client
cd /Users/qinxiang/Documents/course/music/code/music/music-client
npm install
npm run dev
访问部署网址即可使用(后端处于运行状态，数据库保持连接状态)




