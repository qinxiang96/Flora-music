/*
 Navicat Premium Data Transfer

 Source Server         : db2019
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : music

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 08/01/2023 16:10:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` (`id`, `name`, `password`) VALUES (1, 'admin', '123');
COMMIT;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL COMMENT '收藏类型（0歌曲1歌单）',
  `song_id` int DEFAULT NULL,
  `song_list_id` int DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收藏';

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
INSERT INTO `collect` (`id`, `user_id`, `type`, `song_id`, `song_list_id`, `create_time`) VALUES (3, 6, 0, 13, NULL, '2023-01-08 08:04:21');
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `song_id` int DEFAULT NULL,
  `song_list_id` int DEFAULT NULL,
  `content` text,
  `create_time` datetime DEFAULT NULL,
  `up` int DEFAULT '0' COMMENT '评论点赞数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论';

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for consumer
-- ----------------------------
DROP TABLE IF EXISTS `consumer`;
CREATE TABLE `consumer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `phone_num` char(15) DEFAULT NULL COMMENT '电话',
  `email` char(30) DEFAULT NULL,
  `birth` datetime DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `avator` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='前端用户表';

-- ----------------------------
-- Records of consumer
-- ----------------------------
BEGIN;
INSERT INTO `consumer` (`id`, `username`, `password`, `sex`, `phone_num`, `email`, `birth`, `introduction`, `location`, `avator`, `create_time`, `update_time`) VALUES (6, '子歌', 'zige', 0, '15545334996', 'qinxiang96@163.com', '1996-01-24 00:00:00', '没有感情的唱歌机器', '广东', '/avatorImages/16731480093801672411708556hhh.jpg', '2023-01-05 12:47:13', '2023-01-08 03:20:09');
COMMIT;

-- ----------------------------
-- Table structure for list_song
-- ----------------------------
DROP TABLE IF EXISTS `list_song`;
CREATE TABLE `list_song` (
  `id` int NOT NULL AUTO_INCREMENT,
  `song_id` int DEFAULT NULL,
  `song_list_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='歌单包含歌曲列表';

-- ----------------------------
-- Records of list_song
-- ----------------------------
BEGIN;
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (5, 8, 4);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (6, 13, 4);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (7, 10, 4);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (8, 17, 4);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (9, 20, 4);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (10, 14, 5);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (11, 12, 5);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (12, 11, 6);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (13, 16, 6);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (14, 21, 6);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (15, 22, 7);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (16, 23, 7);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (17, 15, 7);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (18, 18, 5);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (19, 19, 5);
INSERT INTO `list_song` (`id`, `song_id`, `song_list_id`) VALUES (20, 9, 5);
COMMIT;

-- ----------------------------
-- Table structure for rank
-- ----------------------------
DROP TABLE IF EXISTS `rank`;
CREATE TABLE `rank` (
  `id` int NOT NULL AUTO_INCREMENT,
  `song_list_id` int DEFAULT NULL,
  `consumer_id` int DEFAULT NULL,
  `score` int DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `consumer_id` (`song_list_id`,`consumer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评价';

-- ----------------------------
-- Records of rank
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS `singer`;
CREATE TABLE `singer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `birth` datetime DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL COMMENT '简介',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='歌手';

-- ----------------------------
-- Records of singer
-- ----------------------------
BEGIN;
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (11, '李玖哲', 1, '/img/singerPic/1673095390733李玖哲.jpeg', '1980-11-26 00:00:00', '美国', '韩裔美国人，歌手。2003年，李玖哲以MACHI团员的身份进入了华语乐坛。2004年，作为MACHI成员发行了麻吉第二张专辑。2005年，李玖哲终于以其优美及中低音独特音色，发行了个人第一张国语专辑《影子》。2007年以《Baby是我》专辑，夺得第18届台湾金曲奖最佳国语男歌手。2007年发表第三张国语专辑《想太多》，以同名主打《想太多》迅速在内地走红。代表作品：《我会好好过》，《想太多》，《你好吗》。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (12, '棱镜乐队', 2, '/img/singerPic/1673098018676棱镜乐队.jpeg', '1991-01-01 00:00:00', '中国', '两只，一只叫罐罐，一只叫咔咔。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (13, '隔壁老樊', 1, '/img/singerPic/1673104526317隔壁老樊.jpeg', '1998-11-02 00:00:00', '中国', '隔壁老樊嗓音沧桑撩拨，他爱唱歌、爱喝酒、爱弹吉他。由他翻唱的歌都会被打上他自己的标签。那是一种不羁而自由、哀而不伤、忧愁落寞，放肆洒脱的感觉');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (14, 'Tones and I', 0, '/img/singerPic/1673105300090Tones and I.jpeg', '1993-05-13 00:00:00', '澳大利亚', '2017年9月，她在街头卖艺演出，被经纪人 Jackson Walkden-Brown挖掘。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (15, 'LBI利比', 1, '/img/singerPic/1673106263507LBI利比 .jpeg', '1994-11-19 00:00:00', '中国', 'LBI利比，内地男歌手，唱作人，音乐制作人。代表作《小城夏天》、《洛杉矶》、《或许》。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (16, 'Daniel Powter', 1, '/img/singerPic/1673106909054D P.jpeg', '1971-02-25 00:00:00', '加拿大', '2005年以出道首发单曲《Bad Day》红遍欧洲随后又席卷北美而为全世界乐迷熟知。丹尼尔细腻独特的感受力及出色的琴艺，让他总是能够在平淡无奇的生活中，找到音乐创作的题材，因此有着“城市琴人丹尼尔”的称号。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (17, '乘风破浪', 2, '/img/singerPic/1673107794742乘风.jpeg', '2022-05-18 00:00:00', '中国', '歌曲《乘风》是芒果TV综艺节目《乘风破浪第三季》的启航曲，由全体参加节目的三十位女艺人共同演绎，于2022年5月18日发布。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (18, '许嵩', 1, '/img/singerPic/1673108919602许嵩.jpeg', '1986-05-14 00:00:00', '中国', '内地作词人、作曲人、唱片制作人、歌手。2009年独立出版首张专辑《自定义》，2010年出版第二张专辑《寻雾启示》，两度掀起热潮，一跃成为内地互联网讨论度较高的音乐人。2011年加盟海蝶音乐，推出第三张专辑《苏格拉没有底》，发行首月即在大陆地区摘下唱片销量榜冠军，共斩获2011年度九项音乐奖项。2012年7月发表第四张专辑《梦游计》。2013年出版个人摄影随笔集《海上灵光》。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (19, '周杰伦', 1, '/img/singerPic/1673109892191周杰伦.jpeg', '1979-01-18 00:00:00', '中国', '似乎在不经意间，周杰伦的歌成为陪伴许多人青春、成长的BGM，也成了华人流行乐文化中不断启发后辈的标杆“语言”。早在世纪之交时，或许很多人并没注意到，这位咬字“另类”、难掩个性的唱作歌手，正在开创性地将R&B、嘻哈与摇滚、古典巧妙融合，创造并推动着华语乐坛标志性的中国风。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (20, '曾轶可', 0, '/img/singerPic/1673148489426曾轶可.jpeg', '1990-01-03 00:00:00', '中国', '毕业于吉林外国语大学。2009年“快乐女声”全国第9名，在比赛中以其原创歌曲和独特的“绵羊音”而广为观众熟知，更引发年度热议，因此成名出道。赛后签约天娱传媒，并于2009年12月18日发行个人首张原创专辑《Forever Road》。其歌迷自称为“可爱多”。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (21, '五月天', 2, '/img/singerPic/1673149025072五月天.jpeg', '1975-12-06 00:00:00', '中国', '五月天（Mayday），中国台湾摇滚乐团，成立于1997年3月29日，由温尚翊（怪兽）、陈信宏（阿信）、石锦航（石头）、蔡升晏（玛莎）、刘谚明（冠佑）五名成员组成。1998年加入滚石唱片，正式开始音乐历程。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (22, '高姗', 0, '/img/singerPic/1673149436770高珊.jpeg', '1991-11-30 00:00:00', '中国', '高姗，旅美唱作女歌手，制作人，毕业于北京大学，现居纽约。高姗的音乐风格集民谣、爵士、电子、流行为一体');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (23, '王贰浪', 0, '/img/singerPic/1673150063144王贰浪.jpeg', '1998-07-27 00:00:00', '中国', '代表作品有《像鱼》《寂寞的恋人啊》《愿你余生漫长》《人间城》《把回忆拼好给你》。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (24, '陈粒', 0, '/img/singerPic/1673150430767陈粒.jpeg', '1990-07-26 00:00:00', '中国', '陈粒，1990年7月26日出生于贵州省贵阳市，中国内地唱作音乐人、音乐制作人，毕业于上海对外经贸大学。2012年，其所在乐队“空想家乐队”获得“Zippo炙热摇滚大赛”上海赛区冠军。2014年，随空想家乐队推出乐队首张EP专辑《万象》；同年，其演唱的歌曲《奇妙能力歌》入围“第四届阿比鹿音乐奖”年度民谣单曲。');
INSERT INTO `singer` (`id`, `name`, `sex`, `pic`, `birth`, `location`, `introduction`) VALUES (25, '王力宏', 1, '/img/singerPic/1673150805166王力宏.jpeg', '1976-05-17 00:00:00', '中国', '王力宏（Wang Leehom），1976年5月17日出生于美国纽约州罗切斯特市，祖籍浙江省义乌市，华语流行乐男歌手、音乐人、影视演员、导演，毕业于威廉姆斯学院，拥有威廉姆斯学院和伯克利音乐学院双荣誉博士的学历。');
COMMIT;

-- ----------------------------
-- Table structure for song
-- ----------------------------
DROP TABLE IF EXISTS `song`;
CREATE TABLE `song` (
  `id` int NOT NULL AUTO_INCREMENT,
  `singer_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL COMMENT '歌手简介',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL COMMENT '图片',
  `lyric` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '歌词',
  `url` varchar(255) DEFAULT NULL COMMENT '歌曲地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='歌曲';

-- ----------------------------
-- Records of song
-- ----------------------------
BEGIN;
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (8, 11, '李玖哲-夏天', '当周杰伦传简讯确认会写一首歌给李玖哲，让李玖哲开心了整个星期，因为周杰伦认为一般大家都只听到李玖哲抒情慢歌，所以这次特别为他写了一首中板轻快的情歌，要大家听到不一样的李玖哲。', '2023-01-07 12:57:22', '2023-01-07 13:11:37', '/img/songPic/1673097097636夏天.jpeg', '[00:07.93]作词：古小力\n[00:10.14]作曲：周杰伦\n[00:25.60]春雨后\n[00:26.10]太阳缓缓的\n[00:27.15]露出笑容\n[00:28.15]你的微笑\n[00:29.11]就像弯弯的彩虹\n[00:30.72]在这片天空\n[00:31.72]云朵就是我\n[00:33.08]随时随地\n[00:33.98]环绕在你四周\n[00:35.69]河堤上的风筝\n[00:37.05]拉长自由\n[00:38.45]微风慢慢吹着\n[00:39.71]幸福感动\n[00:40.92]我也想紧紧握\n[00:42.17]紧紧牵你的手\n[00:43.47]浪漫的抱着你\n[00:44.83]看着日落\n[00:45.90]怕黑时候\n[00:47.35]数着指头\n[00:48.66]时间就会很快过\n[00:51.17]我会小心\n[00:52.49]呵护守候\n[00:53.71]下雨有我肩膀靠\n[00:56.31]睡不着\n[00:57.22]记得想着我\n[00:58.88]三秒后会\n[01:00.18]梦见我\n[01:01.43]载着气球\n[01:02.68]陪你兜风\n[01:03.94]看遍所有\n[01:05.05]会笑的星空\n[01:07.81]整个夏天\n[01:09.32]想和你环游世界\n[01:12.85]山路蜿蜒\n[01:14.45]就像是爱的冒险\n[01:18.03]你的笑脸\n[01:19.58]是我唯一的零嘴\n[01:23.16]我用双眼\n[01:24.73]捕捉这特写\n[01:28.39]整个夏天\n[01:29.74]融化了整个季节\n[01:33.50]一天一天\n[01:34.86]把你定格\n[01:36.06]在结尾\n[01:38.63]让我了解\n[01:39.99]爱原来可以\n[01:41.57]那么简单点缀\n[01:47.14]看窗外的蓝天\n[01:48.67]在这个屋檐\n[01:49.98]我回忆\n[01:50.74]画面有你情节\n[02:12.81]河堤上的风筝\n[02:14.11]拉长自由\n[02:15.57]微风慢慢吹着\n[02:16.78]幸福感动\n[02:17.94]我也想紧紧握\n[02:19.14]紧紧牵你的手\n[02:20.56]浪漫的抱着你\n[02:21.91]看着日落\n[02:23.06]怕黑时候\n[02:24.27]数着指头\n[02:25.62]时间就会很快过\n[02:28.20]我会小心\n[02:29.45]呵护守候\n[02:30.81]下雨有我肩膀靠\n[02:33.33]睡不着记得想着我\n[02:35.84]三秒后会梦见我\n[02:38.45]载着气球\n[02:39.67]陪你兜风\n[02:40.93]看遍所有会笑的星空\n[02:44.84]整个夏天\n[02:46.36]想和你环游世界\n[02:49.96]山路蜿蜒\n[02:51.47]就像是爱的冒险\n[02:55.13]你的笑脸\n[02:56.60]是我唯一的零嘴\n[03:00.07]我用双眼\n[03:01.73]捕捉这特写\n[03:05.40]整个夏天\n[03:06.76]融化了整个季节\n[03:10.32]一天一天\n[03:11.83]把你定格在结尾\n[03:15.60]让我了解\n[03:17.00]爱原来可以\n[03:18.51]那么简单点缀\n[03:24.18]看窗外的蓝天\n[03:25.70]在这个屋檐\n[03:26.95]我回忆画面\n[03:28.20]有你情节', '/song/1673096242695song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (9, 12, '棱镜乐队-总有一天你会出现在我身边', '你不听棱镜，更不知道到我想你', '2023-01-07 13:33:38', '2023-01-07 13:37:45', '/img/songPic/1673098665481总有一天你会出现在我身边.jpeg', '[00:00.10]棱镜 - 总有一天你会出现在我身边\r\n[00:02.43]作词：陈恒冠、高原\r\n[00:03.74]作曲：陈恒冠\r\n[00:04.66]编曲：陈恒冠\r\n[00:05.52]混音：陈恒家\r\n[00:06.43]封面：水吉\r\n[00:07.19]监制：1991与她\r\n[00:14.47]从前我的另一边\r\n[00:18.06]通往凌晨的街\r\n[00:21.55]空无一人的世界\r\n[00:27.61]行影匆匆这些年\r\n[00:31.22]期望从未破灭\r\n[00:34.51]默不作响的时间\r\n[00:40.83]最好的人注定会到身边\r\n[00:47.47]孤注一掷的执念\r\n[00:53.95]我终将看到你身影逆光出现\r\n[01:07.13]等这一切 都被你了解\r\n[01:14.02]十指错落相牵\r\n[01:20.19]跨越时间 再没有分别\r\n[01:27.12]携手走过明天\r\n[01:46.60]雨后路人化鱼鲔\r\n[01:50.29]欢愉游跃摇曳\r\n[01:53.40]灿烂一抱的世界\r\n[01:59.71]光芒捧起你的脸\r\n[02:03.32]我飞在云层间\r\n[02:06.57]狂奔向你不停歇\r\n[02:12.86]你说最好的人会到身边\r\n[02:19.33]此刻我也这样想\r\n[02:26.06]你终将看到我最美模样出现\r\n[02:39.26]等这一切 都被你了解\r\n[02:45.99]十指错落相牵\r\n[02:52.31]跨越时间 再没有分别\r\n[02:59.18]携手走过明天\r\n[03:05.45]总会有些 幸运会出现\r\n[03:12.39]我等待这一天\r\n[03:18.60]总有艰险 哪怕是谎言\r\n[03:25.48]我等待你出现\r\n[03:31.86]等这一切 都被你了解\r\n[03:38.59]十指错落相牵\r\n[03:44.81]跨越时间 再没有分别\r\n[03:51.71]携手走过明天\r\n[03:58.08]等这一切 都被你了解\r\n[04:04.86]十指错落相牵\r\n[04:11.18]跨越时间 总会有一天\r\n[04:18.12]你出现我身边', '/song/1673098418192song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (10, 12, '棱镜乐队-这一生中最勇敢的瞬间', '有没有某个瞬间，我们奋不顾身勇往直前，只因为这一天你出现在我身边。最勇敢的是，与我你是有预谋的相遇，与你我是有预谋的告白。身边也好，天边也罢，从此琐碎的日子我都要讲给你听。', '2023-01-07 15:06:58', '2023-01-07 15:08:27', '/img/songPic/1673104107742这是我一生中最勇敢的瞬间.jpeg', '[00:00.000] 作曲 : 陈恒家\r\n[00:01.000] 作词 : 高原\r\n[00:03.13]编曲：陈恒家\r\n[00:05.13]人声：陈恒冠\r\n[00:07.28]和声：陈恒冠 陈恒家\r\n[00:09.49]鼓手：Jordan Bertrand\r\n[00:11.39]录音：陈恒家\r\n[00:13.36]混音：陈恒家\r\n[00:15.66]母带：陈恒家\r\n[00:15.66]女声采样：咕噜咕噜\r\n[00:18.26]监制：1991与她\r\n[00:21.66]我本打算去流浪\r\n[00:25.91]把所有的回望都交给夕阳\r\n[00:32.26]风是空港 雨是牧场\r\n[00:36.61]我陷入万里无云的海洋\r\n[00:42.26]\r\n[00:43.01]我并不渴望远方\r\n[00:47.26]只想找到一个可爱的地方\r\n[00:53.51]跨过飞杭 穿过弄堂\r\n[00:57.96]你站在我始料未及的小巷\r\n[01:06.26]\r\n[01:06.96]这是我一生中最勇敢的瞬间\r\n[01:11.21]远在世界尽头的你站在我面前\r\n[01:17.26]这是我一生中最勇敢的瞬间\r\n[01:21.96]我的眼中藏着星点嘴角有弧线\r\n[01:28.01]这是我一生中最勇敢的瞬间\r\n[01:32.61]你是黎明地平线是我永恒的终点\r\n[01:38.61]我想把时间揉成碎片捧在我手心\r\n[01:44.71]\r\n[01:45.91]明天周六可以把我们一起出去玩 改成我们去约会吗\r\n[01:51.36]\r\n[02:13.66]我并不渴望远方\r\n[02:17.91]只想找到一个可爱的地方\r\n[02:24.31]跨过飞杭 穿过弄堂\r\n[02:28.56]你站在我始料未及的小巷\r\n[02:34.91]\r\n[02:37.21]这是我一生中最勇敢的瞬间\r\n[02:41.91]远在世界尽头的你站在我面前\r\n[02:47.86]这是我一生中最勇敢的瞬间\r\n[02:52.56]我的眼中藏着星点嘴角有弧线\r\n[02:58.56]这是我一生中最勇敢的瞬间\r\n[03:03.26]你是黎明地平线是我永恒的终点\r\n[03:09.21]我想把时间揉成碎片捧在我手心\r\n[03:19.01]约会见\r\n[03:24.61]再见面就是永远', '/song/1673104018590song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (11, 13, '隔壁老樊-姬和不如', '讲述了一位歌姬内心的寂寞与愁绪，人间苦难，难逃折磨，相爱的两个人终究因为身份与地位的社会框架而缘尽。', '2023-01-07 15:19:20', '2023-01-07 15:20:23', '/img/songPic/1673104823474姬和不如.jpeg', '[00:00.41]隔壁老樊 - 姬和不如\r\n[00:01.17]作词：隔壁老樊\r\n[00:02.69]作曲：隔壁老樊\r\n[00:03.39]编曲：张楚弦\r\n[00:03.59]制作人：胡皓\r\n[00:03.81]吉他：张楚弦@北京光合声动录音室Production 2\r\n[00:05.88]Bass：张楚弦@北京光合声动录音室Production 2\r\n[00:07.50]Vocal录音：李水泽宁@北京光合声动录音室Studio A\r\n[00:09.64]Mixing、Mastering：张楚弦@北京光合声动录音室Studio A\r\n[00:16.92]踏过青山昨日的落寞\r\n[00:24.74]你扶楼阁弹一曲青涩\r\n[00:32.35]念及昨夜\r\n[00:36.12]那场翻云覆雨的痛彻\r\n[00:40.11]你说人间苦难命也难逃折磨\r\n[00:48.25]苦难生活日日的落寞\r\n[00:55.50]我说万般皆是命是生活所迫\r\n[01:03.02]不如菩提树下割肉喂鹰\r\n[01:06.92]不如剃度出家斩断七情\r\n[01:10.73]不如别相逢不如别相遇\r\n[01:18.49]不如万劫不复了断性命\r\n[01:22.15]不如日照大地无天下四季\r\n[01:26.25]都不如都不如陪着你\r\n[02:04.44]踏过青山昨日的落寞\r\n[02:11.69]你扶楼阁弹一曲青涩\r\n[02:19.84]念及昨夜\r\n[02:23.51]那场翻云覆雨的痛彻\r\n[02:27.51]你说人间苦难命也难逃折磨\r\n[02:35.66]苦难生活日日的落寞\r\n[02:42.73]我说万般皆是命是生活所迫\r\n[02:50.65]不如菩提树下割肉喂鹰\r\n[02:54.37]不如剃度出家斩断七情\r\n[02:58.26]不如别相逢不如别相遇\r\n[03:05.78]不如万劫不复了断性命\r\n[03:09.69]不如日照大地无天下四季\r\n[03:13.52]都不如都不如陪着你\r\n[03:21.30]不如菩提树下割肉喂鹰\r\n[03:25.01]不如剃度出家斩断七情\r\n[03:28.70]不如别相逢不如别相遇\r\n[03:36.71]不如万劫不复了断性命\r\n[03:40.40]不如日照大地无天下四季\r\n[03:44.51]都不如都不如陪着你\r\n[03:51.98]都不如都不如陪着你', '/song/1673104760319song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (12, 14, 'Tones and I-Dance Monkey', '有时候我们一直忙着做自己热爱的工作，但久了会发现各种遭遇会把自己的热情磨光。一直工作就像个在跳舞的猴子一般，只是一个机器，没有灵魂的工作着。', '2023-01-07 15:32:07', '2023-01-07 15:33:11', '/img/songPic/1673105591353Dance Monkey.jpeg', '[00:08.981] They say oh my god I see the way you shine\r\n[00:12.502]\r\n[00:13.752] Take your hand, my dear, and place them both in mine\r\n[00:17.550]\r\n[00:18.128] You know you stopped me dead when I was passing by\r\n[00:22.482]\r\n[00:23.349] And now I beg to see you dance just one more time\r\n[00:27.602] Oh I see you, see you, see you every time\r\n[00:33.105] And I, I, I, I like your style\r\n[00:37.596] You, you make me, make me, make me wanna cry\r\n[00:42.361]\r\n[00:43.156] And now I beg to see you dance just one more time\r\n[00:47.155] So I say\r\n[00:48.671] Dance for me\r\n[00:49.291] Dance for me\r\n[00:49.919] Dance for me, oh oh oh\r\n[00:52.005]\r\n[00:52.769] I\'ve never seen anybody do the things you do before\r\n[00:57.116] They say\r\n[00:58.514] Move for me\r\n[00:59.065] Move for me\r\n[00:59.724] Move for me, ay ay ay\r\n[01:01.572]\r\n[01:02.517] And when you\'re done I\'ll make you do it all again\r\n[01:06.960]\r\n[01:07.680] I said oh my god I see you walking by\r\n[01:11.320]\r\n[01:12.434] Take my hands, my dear, and look me in my eyes\r\n[01:16.489]\r\n[01:17.212] Just like a monkey I\'ve been dancing my whole life\r\n[01:21.279]\r\n[01:22.038] And you just beg to see me dance just one more time\r\n[01:26.426] Oh I see you, see you, see you every time\r\n[01:31.816] And I, I, I, I like your style\r\n[01:36.283] You, you make me, make me, make me wanna cry\r\n[01:41.038]\r\n[01:41.801] And now I beg to see you dance just one more time\r\n[01:46.066] So I say\r\n[01:47.626] Dance for me\r\n[01:48.141] Dance for me\r\n[01:48.760] Dance for me, oh oh oh\r\n[01:50.603]\r\n[01:51.433] I\'ve never seen anybody do the things you do before\r\n[01:56.145] They say\r\n[01:57.399] Move for me\r\n[01:57.844] Move for me\r\n[01:58.386] Move for me, ay ay ay\r\n[02:00.315]\r\n[02:01.288] And when you\'re done I\'ll make you do it all again\r\n[02:05.764] They say\r\n[02:07.246] Dance for me\r\n[02:07.749] Dance for me\r\n[02:08.206] Dance for me, oh oh oh, oh-oh, oh-oh\r\n[02:11.028] I\'ve never seen anybody do the things you do before\r\n[02:15.407] They say\r\n[02:16.866] Move for me\r\n[02:17.524] Move for me\r\n[02:17.965] Move for me, ay ay ay\r\n[02:20.683] And when you\'re done I\'ll make you do it all again\r\n[02:26.020] Oh\r\n[02:28.520] (Do it all again, do it all again, do it all again)\r\n[02:33.499] Oh, oh-oh\r\n[02:38.114] (Do it all again, do it all again, do it all again)\r\n[02:43.137]\r\n[02:44.755] They say\r\n[02:46.354] Dance for me\r\n[02:46.741] Dance for me\r\n[02:47.451] Dance for me, oh oh oh\r\n[02:49.399]\r\n[02:50.513] I\'ve never seen anybody do the things you do before\r\n[02:54.600] They say\r\n[02:56.017] Move for me\r\n[02:56.485] Move for me\r\n[02:57.177] Move for me, ay ay ay\r\n[02:59.089]\r\n[03:00.126] And when you\'re done I\'ll make you do it all again\r\n[03:04.723] They say\r\n[03:05.877] Dance for me\r\n[03:06.373] Dance for me\r\n[03:06.922] Dance for me, oh oh oh, oh-oh, oh-oh\r\n[03:09.863] I\'ve never seen anybody do the things you do before\r\n[03:14.274] They say\r\n[03:15.800] Move for me\r\n[03:16.375] Move for me\r\n[03:16.774] Move for me, ay ay ay\r\n[03:18.935]\r\n[03:19.864] And when you\'re done I\'ll make you do it all again\r\n[03:24.072] All again', '/song/1673105526986song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (13, 15, 'LBI利比-小城夏天', '“夏天当然是和汽水最配啦” 　　LBI利比全新单曲《小城夏天》愉悦上线，微醺的傍晚，在小城夏天陪你遇见浪漫。 　　心动，像风来的不知不觉，冒泡的汽水和你都是夏天的感觉。', '2023-01-07 15:47:02', '2023-01-08 04:29:00', '/img/songPic/1673152140293小城夏天.jpeg', '[00:00.000] 作词 : 陶旧\r\n[00:01.000] 作曲 : 盛骁\r\n[00:02.000] 编曲 : WayMen歪门/KENNY妮妮\r\n[00:03.000] 制作人 : 蒋雪儿 Snow.J\r\n[00:11.93]橘黄色的日落 吞没在海平线\r\n[00:16.34]夜色慢慢摊开 露出星光点点\r\n[00:19.38]我听着耳机中j a y的音乐\r\n[00:22.62]从等你下课 到手写的从前\r\n[00:26.12]冒泡汽水和你都是夏天感觉\r\n[00:29.18]着迷你眉间柔情似海的双眼\r\n[00:32.56]心动像风来的不知不觉\r\n[00:36.02]此刻 世界聚焦你的出现\r\n[00:39.11]wo~~~ say wo~~~\r\n[00:45.87]wo~~~ say wo~~~\r\n[00:52.28]我在小城夏天陪你遇见浪漫\r\n[00:55.97]晚风吹过耳畔你显得很好看\r\n[00:59.12]微醺的傍晚 时间过很慢\r\n[01:05.22]我在小城夏天遇见了另一半\r\n[01:08.98]这座城市有我的思念和喜欢\r\n[01:12.35]闷热的季节 因你而梦幻\r\n[01:32.13]橘黄色的日落 吞没在海平线\r\n[01:35.36]夜色慢慢摊开 露出星光点点\r\n[01:38.21]我听着耳机中j a y的音乐\r\n[01:41.60]从等你下课 到手写的从前\r\n[01:44.96]冒泡汽水和你都是夏天感觉\r\n[01:48.36]着迷你眉间柔情似海的双眼\r\n[01:51.36]心动像风来的不知不觉\r\n[01:54.98]此刻 世界聚焦你的出现\r\n[01:57.83]wo~~~ say wo~~~\r\n[02:05.03]wo~~~ say wo~~~\r\n[02:10.95]我在小城夏天陪你遇见浪漫\r\n[02:14.72]晚风吹过耳畔你显得很好看\r\n[02:17.96]微醺的傍晚 时间过很慢\r\n[02:24.11]我在小城夏天遇见了另一半\r\n[02:27.99]这座城市有我的思念和喜欢\r\n[02:31.09]闷热的季节 因你而梦幻\r\n[02:33.805] 吉他 : 张赫伦\r\n[02:36.601] 混音师 : LBI利比\r\n[02:39.397] 和声 : LBI利比\r\n[02:42.193] 监制 : 蒋雪儿 Snow.J\r\n[02:44.989] 统筹 : 柯自俊\r\n[02:47.785] OP : 青风音乐Cheerful Music\r\n[02:50.581] SP : 乐无限Eternal Music', '/song/1673106422622song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (14, 16, 'Daniel Powter-Free Loop', 'Daniel Powter表示：在这首歌的创作过程中，他希望能展现出自我特殊的一面，但同时也希望音乐能引起人们的共鸣。这首歌的灵感来源不是关于美酒豪车的，而是关于处在各种人际关系之中的人，以及他曾经经历过的情境。', '2023-01-07 16:02:34', '2023-01-07 16:03:36', '/img/songPic/1673107416005Free Loop.jpeg', '[00:00.19]I\'m a little used to calling\r\n[00:02.42]Outside your name\r\n[00:06.42]I won\'t see you tonight\r\n[00:07.93]So I can keep from going insane\r\n[00:13.06]But I don\'t know enough\r\n[00:15.89]I get some kind of lazy day\r\n[00:18.73]Hey yeah\r\n[00:25.56]I\'ve been fabulous through to\r\n[00:27.13]Fight my town a name\r\n[00:31.78]I\'ll be stooped tomorrow\r\n[00:33.40]But I don\'t leave\r\n[00:34.56]As them both the same\r\n[00:38.56]But I don\'t know enough\r\n[00:41.29]I get some kind of lazy day\r\n[00:44.47]Hey yeah\r\n[00:50.99]Cause it\'s hard for me to lose\r\n[00:52.56]In my life I\'ve found\r\n[00:54.13]Only time will tell\r\n[00:55.99]And I will figure out\r\n[00:57.56]That we can baby\r\n[00:59.13]We can do a one night stand yeah\r\n[01:03.77]And it\'s hard for me to lose\r\n[01:05.34]In my life\r\n[01:06.25]I\'ve found outside your skin\r\n[01:08.77]Right near the fire\r\n[01:10.29]That we can baby\r\n[01:11.96]We can change and feel alright\r\n[01:20.13]I\'m a little used to wandering\r\n[01:22.10]Outside the rain\r\n[01:25.96]You can leave me tomorrow\r\n[01:27.38]If it suits you just the same\r\n[01:32.87]But I don\'t know enough\r\n[01:35.55]I need someone who leaves the day\r\n[01:38.68]Hey yeah\r\n[01:45.18]Cause it\'s hard for me to lose\r\n[01:46.69]In my life I\'ve found\r\n[01:48.08]Only time will tell\r\n[01:49.25]And I will figure out that\r\n[01:52.19]We can baby\r\n[01:53.56]We can do a one night stand yeah\r\n[01:57.88]And it\'s hard for me to lose\r\n[01:59.50]In my life\r\n[02:00.36]I\'ve found outside your skin\r\n[02:02.82]Right near the fire\r\n[02:04.47]That we can baby\r\n[02:06.04]We can change and feel alright\r\n[02:39.41]Cause it\'s hard for me to lose\r\n[02:41.03]In my life I\'ve found\r\n[02:42.34]Only time will tell\r\n[02:44.01]I will figure out that\r\n[02:46.09]We can baby\r\n[02:47.46]We can do a one night stand yeah\r\n[02:52.08]And it\'s hard for me to lose\r\n[02:53.70]In my life\r\n[02:54.56]I\'ve found outside your skin\r\n[02:56.95]Right near the fire\r\n[02:58.67]That we can baby\r\n[03:00.14]We can change and feel alright\r\n[03:04.89]Cause it\'s hard for me to lose\r\n[03:06.36]In my life I\'ve found only\r\n[03:08.18]Time will tell\r\n[03:09.50]And I will figure out that\r\n[03:11.72]We can baby\r\n[03:12.94]We can do a one night stand yeah\r\n[03:17.52]And it\'s hard for me to lose\r\n[03:19.10]In my life\r\n[03:20.01]I\'ve found outside your skin\r\n[03:22.36]Right near the fire\r\n[03:24.23]That we can baby\r\n[03:25.64]We can change and feel alright\r\n[03:29.08]Daniel Powter - Free Loop', '/song/1673107354759song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (15, 17, '乘风破浪-乘风', '歌曲《乘风》是芒果TV综艺节目《乘风破浪第三季》的启航曲，由全体参加节目的三十位女艺人共同演绎，于2022年5月18日发布。', '2023-01-07 16:20:06', '2023-01-07 16:21:32', '/img/songPic/1673108492652乘风2.jpeg', '[00:00:00]暂无歌词', '/song/1673108406680song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (16, 18, '许嵩-最佳歌手', '平凡嵩与明星嵩的美好初见与告别是那么的短暂，以至于回忆只剩下星星点点。曾以为刻骨铭心，如今竟已慢慢淡忘，无处可寻。平凡嵩坐在车里听着明星嵩唱的歌曲，默默的复习，心中已开始排练待会儿上台该如何演好明星嵩。明星嵩又登场了，掌声雷动。全世界都是你（明星嵩）的镜头，我（平凡嵩）理性退后，彻底隐藏。', '2023-01-07 16:32:07', '2023-01-07 16:34:02', '/img/songPic/1673109241963最佳歌手.jpeg', '[00:00.14]许嵩 - 最佳歌手\r\n[00:01.24]作词：许嵩\r\n[00:02.09]作曲：许嵩\r\n[00:03.09]我们最好的遇见\r\n[00:06.47]是现在这样的四月\r\n[00:10.67]柳絮抚着那条街\r\n[00:14.43]像大雪一样的热烈\r\n[00:18.58]你轻轻唱起我的歌\r\n[00:22.38]我受宠若惊的喜悦\r\n[00:26.78]绝佳的歌艺里面\r\n[00:30.33]多少故事做铺垫\r\n[00:38.75]我们最好的告别\r\n[00:42.45]是现在这样没红眼\r\n[00:46.70]因你而起的一泓喜悲\r\n[00:49.95]权当年轻留个纪念\r\n[00:54.66]清晨回笼做了梦\r\n[00:58.51]你成明星开演唱会\r\n[01:02.57]场馆里歌迷很多\r\n[01:05.87]我被人潮推到尽头\r\n[01:10.43]你在台上唱着我的创作\r\n[01:14.49]布局谋篇像本悲情小说\r\n[01:18.59]你太擅长表演\r\n[01:21.54]表情淡漠反倒有催泪效果\r\n[01:26.50]我在台下已经开始感动\r\n[01:30.55]大屏幕里忽然给我镜头\r\n[01:35.05]微笑挥挥手\r\n[01:37.30]多懂事的观众\r\n[01:59.10]初见和告别之间\r\n[02:02.46]回想只剩星星点点\r\n[02:06.51]曾以为刻骨细节\r\n[02:10.21]在骨灰里面怎么捡\r\n[02:14.62]沿着环路兜一圈\r\n[02:18.37]循环放你唱过的歌\r\n[02:22.53]心里的舞台已启幕\r\n[02:26.08]主角登场引来掌声雷动\r\n[02:30.43]你在台上唱着我的创作\r\n[02:34.48]布局谋篇像本悲情小说\r\n[02:38.63]你太擅长表演\r\n[02:41.39]表情淡漠反倒有催泪效果\r\n[02:46.29]我在台下已经开始感动\r\n[02:50.44]大屏幕里忽然给我镜头\r\n[02:55.00]微笑挥挥手\r\n[02:57.30]多懂事的观众\r\n[03:02.31]你在台上唱着我的创作\r\n[03:06.56]布局谋篇像本悲情小说\r\n[03:10.51]你太擅长表演\r\n[03:13.51]表情淡漠反倒有催泪效果\r\n[03:18.37]我在台下已经开始感动\r\n[03:22.37]整个世界全是你的镜头\r\n[03:26.87]听完这一首\r\n[03:29.17]就理性的退后\r\n[03:38.82]直到某一天碰面\r\n[03:42.32]在某家餐厅或商店\r\n[03:46.82]你挽着他和我擦肩\r\n[03:50.17]还好 我手也有人牵\r\n[03:54.83]广播里响起的歌\r\n[03:58.23]是“恍若隔世”的注解\r\n[04:02.53]最佳歌手的头衔\r\n[04:06.09]大致上有了人选\r\n[04:10.64]最佳歌手的感言\r\n[04:14.34]记得要慢慢念', '/song/1673109127545song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (17, 19, '周杰伦-七里香', '《七里香》是周杰伦于2004年8月3日发行的专辑。该专辑的制作人由周杰伦担任，共收录了10首歌曲。 2005年，该专辑获得第16届台湾金曲奖年度最佳专辑提名、HITO流行音乐奖年度DJ最爱专辑等奖项。', '2023-01-07 16:46:55', '2023-01-07 16:50:38', '/img/songPic/1673110238364七里香.jpeg', '[00:01.01]七里香 - 周杰伦\r\n[00:03.01]词：方文山\r\n[00:04.01]曲：周杰伦\r\n[00:27.80]窗外的麻雀在电线杆上多嘴\r\n[00:34.36]你说这一句很有夏天的感觉\r\n[00:41.01]手中的铅笔在纸上来来回回\r\n[00:47.37]我用几行字形容你是我的谁\r\n[00:54.11]秋刀鱼的滋味猫跟你都想了解\r\n[01:01.36]初恋的香味就这样被我们寻回\r\n[01:07.55]那温暖的阳光像刚摘的鲜艳草莓\r\n[01:14.00]你说你舍不得吃掉这一种感觉\r\n[01:20.64]雨下整夜我的爱溢出就像雨水\r\n[01:27.45]院子落叶跟我的思念厚厚一叠\r\n[01:34.14]几句是非也无法将我的热情冷却\r\n[01:41.75]你出现在我诗的每一页\r\n[01:47.80]雨下整夜我的爱溢出就像雨水\r\n[01:54.44]窗台蝴蝶像诗里纷飞的美丽章节\r\n[02:01.20]我接着写把永远爱你写进诗的结尾\r\n[02:08.78]你是我唯一想要的了解\r\n[02:41.96]雨下整夜我的爱溢出就像雨水\r\n[02:48.44]院子落叶跟我的思念厚厚一叠\r\n[02:55.12]几句是非也无法将我的热情冷却\r\n[03:02.80]你出现在我诗的每一页\r\n[03:08.86]那饱满的稻穗幸福了这个季节\r\n[03:16.41]而你的脸颊像田里熟透的蕃茄\r\n[03:22.61]你突然对我说七里香的名字很美\r\n[03:29.32]我此刻却只想亲吻你倔强的嘴\r\n[03:35.77]雨下整夜我的爱溢出就像雨水\r\n[03:42.35]院子落叶跟我的思念厚厚一叠\r\n[03:49.13]几句是非也无法将我的热情冷却\r\n[03:56.78]你出现在我诗的每一页\r\n[04:03.53]整夜 我的爱溢出就像雨水\r\n[04:09.46]窗台蝴蝶像诗里纷飞的美丽章节\r\n[04:16.55]我接着写把永远爱你写进诗的结尾\r\n[04:23.85]你是我唯一想要的了解', '/song/1673110015589song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (18, 20, '曾轶可-夜车', '《夜车》是曾轶可创作并演唱的一首歌，是曾轶可主演电影《恋爱通告》的片尾曲。 该歌收录在曾轶可专辑《一只猫的旅行 Forever 21》、《羽绒服》中。', '2023-01-08 03:29:24', '2023-01-08 03:30:38', '/img/songPic/1673148638631夜车.jpeg', '[00:00.000] 作曲 : 曾轶可\r\n[00:01.000] 作词 : 曾轶可\r\n[00:15.850]不记得喝了几个 反正你不能开车\r\n[00:19.160]钥匙在这插在车上 我就看着办吧\r\n[00:22.730]我家不远就在前面 不远可是很偏\r\n[00:26.160]往左 往右 向前 向后\r\n[00:29.730]不用看了没人管我 一个人的生活\r\n[00:33.600]一个人去生活 一个人也可以快活\r\n[00:36.980]给你讲讲我的故事 你可能没听过\r\n[00:40.490]失信 失望 失恋 失落\r\n[00:44.500]车停了好几次 烟抽了好几根\r\n[00:51.370]天都快亮了 我们还没到呢\r\n[00:58.490]你睡得安稳吗 我必须清醒着\r\n[01:05.750]这道路有点黑 你睡吧我负责\r\n[01:12.870]不用看了没人管我 一个人的生活\r\n[01:16.370]一个人去生活 一个人也可以快活\r\n[01:20.600]给你讲讲我的故事 你可能没听过\r\n[01:23.380]失信 失望 失恋 失落\r\n[01:55.960]车停了好几次 烟抽了好几根\r\n[02:02.960]天都快亮了 我们还没到呢\r\n[02:10.150]你睡得安稳吗 我必须清醒着\r\n[02:17.270]这道路有点黑 你睡吧我负责\r\n[02:24.640]我坐在你身后 烟熏着我的头\r\n[02:31.590]我快要睡着了 你会不会冷呢\r\n[02:38.829]这样的小城市 我不会来几次\r\n[02:45.960]小城市的故事 黑夜里最相思\r\n[02:53.280]这样的小城市 我不会来几次\r\n[03:00.340]小城市的故事 黑夜里最相思', '/song/1673148564898song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (19, 21, '五月天-听不到', '《听不到》是一首五月天演唱的歌曲，该首歌曲发行于2004年，出自于其专辑《神的孩子都在跳舞》，2005年又收录在精选集《知足·最真杰作选》中。', '2023-01-08 03:38:13', '2023-01-08 03:40:11', '/img/songPic/1673149210945听不到.jpeg', '[00:00.42]五月天 - 听不到\r\n[00:02.72]词：阿信(五月天)\r\n[00:03.72]曲：阿信(五月天)\r\n[00:16.89]夜 黑夜 寂寞的夜里\r\n[00:20.92]气 生气 对自己生气\r\n[00:25.12]软弱的电话 又打 给你\r\n[00:33.33]想 听你 那边的空气\r\n[00:37.40]有 什么 精彩的话题\r\n[00:41.50]你还是温柔 给我 婉转 的距离\r\n[00:49.27]我的声音在笑 泪在飙\r\n[00:53.76]电话那头的你可知道\r\n[00:57.72]世界若是那么大\r\n[01:01.53]为何我要忘你 无处逃\r\n[01:05.80]我的声音在笑 泪在飙\r\n[01:10.20]电话那头的你可知道\r\n[01:14.19]世界若是那么小\r\n[01:17.88]为何我的真心 你听不到\r\n[01:38.88]会 很会 伪装我自己\r\n[01:43.00]你 不该 背我的秘密\r\n[01:47.04]沉重都给我 微笑 给你\r\n[01:55.14]奔 狂奔 空旷的感情\r\n[01:59.45]走 暴走 暴走的伤心\r\n[02:03.68]透明的叹息 最后 还是 我的秘密\r\n[02:11.43]我的声音在笑 泪在飙\r\n[02:15.93]电话那头的你可知道\r\n[02:20.06]世界若是那么大\r\n[02:23.46]为何我要忘你 无处逃\r\n[02:27.87]我的声音在笑 泪在飙\r\n[02:32.25]电话那头的你可知道\r\n[02:36.34]世界若是那么小\r\n[02:39.74]为何我的真心 你听不到\r\n[02:47.36]你听不到 你听不到\r\n[02:57.11]噢哦哦噢哦噢哦～\r\n[03:09.71]听不到听不到 我的执着\r\n[03:13.69]噗通 噗通一直在跳\r\n[03:18.03]直到你有一天能够明了\r\n[03:21.18]我做得到 我做得到\r\n[03:29.27]我的声音在笑 泪在飙\r\n[03:33.95]电话那头的你可知道\r\n[03:37.82]世界若是那么大\r\n[03:41.32]为何我要忘你 无处逃\r\n[03:45.71]我的声音在笑 泪在飙\r\n[03:50.19]电话那头的你可知道\r\n[03:54.39]世界若是那么小\r\n[03:57.88]为何我的真心 你听不到\r\n[04:05.42]你听不到 你听不到\r\n[04:18.73]啦啦啦啦 啦啦啦啦~~~\r\n[04:26.96]啦啦啦啦 啦啦啦啦~~~\r\n[04:33.97]你听不到\r\n[04:38.33]你听不到\r\n[04:42.38]你听不到', '/song/1673149092982song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (20, 22, '高姗-遇见你的时候所有星星都落到我头上', '钟汉良、唐嫣主演的电视剧《何以笙萧默》插曲，由新晋唱作歌手高姗创作并演唱。这是继《杉杉来了》中的插曲《Roll The Dice》后高姗第二次与顾漫的作品进行合作，在剧中同时发表的歌曲还有《The Road Not Taken》。高姗正在纽约大学音乐学院继续进行音乐创作。', '2023-01-08 03:45:15', '2023-01-08 03:46:01', '/img/songPic/1673149561766遇见你的时候所有星星都落到我头上.jpeg', '[00:00.000] 作曲 : 高姗\r\n[00:01.000] 作词 : 高姗\r\n[00:12.450]你给我了一个微笑\r\n[00:14.570]我可不可以用一个拥抱 还你\r\n[00:20.770]你让我又心跳\r\n[00:22.390]哎哟 我有什么办法也叫你神魂颠倒\r\n[00:29.070]你的眼睛在笑 我望着就中了毒药\r\n[00:32.840]就快要 受不了\r\n[00:37.440]你的声音在绕 还带自动循环特效\r\n[00:41.440]有没有暂停键可以stop\r\n[00:49.930]我们还要 走很长的时间\r\n[00:58.370]千万不要 把我甩在 你身后边\r\n[01:08.640]我和你要去闻闻新鲜的春天\r\n[01:12.860]感受阳光洒满肩上的夏天\r\n[01:17.160]整个世界涂着金色的秋天\r\n[01:21.310]飘雪的冬天\r\n[01:25.520]也许想着未来的事情太遥远\r\n[01:29.570]一起去环游世界也很难实现\r\n[01:33.800]但你出现 在我身边\r\n[01:37.950]就是我可以遇见的最大的惊艳\r\n[01:54.810]我本来是很冷漠的\r\n[01:56.850]为什么会一下就被你的眼神打倒\r\n[02:03.010]我原来是很聪明的\r\n[02:05.070]为什么会一见到你就丢掉大脑\r\n[02:11.380]你知道我很淡定的\r\n[02:13.440]为什么现在睡着觉都还在偷笑\r\n[02:19.710]你明白我很独立的\r\n[02:21.860]为什么现在变得 oh no 无法思考\r\n[02:32.320]我们还要 去更大的世界\r\n[02:40.650]千万不要 把我甩在 你身后边\r\n[02:50.990]我和你要去闻闻新鲜的春天\r\n[02:55.130]感受阳光洒满肩上的夏天\r\n[02:59.350]整个世界涂着金色的秋天\r\n[03:03.480]飘雪的冬天\r\n[03:07.650]也许想着未来的事情太遥远\r\n[03:11.820]一起去环游世界也很难实现\r\n[03:15.930]但你出现 在我身边\r\n[03:20.170]就胜过什么五彩缤纷轰轰烈烈风风火火花天酒地的世界', '/song/1673149515543song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (21, 23, '王贰浪-人间城', '歌曲探讨的是一个人应当怎样去生活的问题。是依靠他人，还是自力更生，是人云亦云，还是有自己的主张。', '2023-01-08 03:56:01', '2023-01-08 03:56:32', '/img/songPic/1673150192678人间城.jpeg', '[00:00.07]王贰浪 - 人间城\r\n[00:00.47]作词：王贰浪\r\n[00:00.62]作曲：王贰浪\r\n[00:00.82]编曲：张燕峰\r\n[00:01.02]吉他：张燕峰\r\n[00:01.23]键盘：李卫\r\n[00:01.38]贝斯：刘磊\r\n[00:01.58]鼓手：陆达\r\n[00:01.74]合声：王贰浪\r\n[00:01.94]录音师：杨惠琳\r\n[00:02.14]缩混师：唐瑜\r\n[00:02.35]母带师：唐瑜\r\n[00:02.55]统筹：高璐\r\n[00:02.70]宣发：郝月明\r\n[00:02.91]发行公司：北京伯音时代文化传媒公司\r\n[00:22.35]一个无名不融入的\r\n[00:27.03]一群拼命想融身的\r\n[00:31.74]这城每个角落都填满了\r\n[00:36.82]若有所思的生活\r\n[00:43.44]你想要在这城遇见\r\n[00:46.29]优秀的人更华丽的衣着\r\n[00:49.39]那就要吞下苦\r\n[00:51.33]混着泥沙泡沫奔波\r\n[00:54.23]有谁会给机会\r\n[00:56.66]与你成天逍遥快活\r\n[00:59.11]倒不如寥寥一瞬\r\n[01:01.86]个人努力生活\r\n[01:06.80]独自生活不一定有结果\r\n[01:16.57]人间喜乐还需自己琢磨\r\n[01:26.28]独自生活不一定有结果\r\n[01:36.15]无谓如何如此一生值得\r\n[01:50.49]缠绕喧嚣中藏匿的\r\n[01:55.26]入夜来临时恐惧着\r\n[01:59.82]这城漂浮着千百个你和我\r\n[02:05.62]无声无色\r\n[02:11.62]你想要在这城遇见\r\n[02:14.32]优秀的人更华丽的衣着\r\n[02:17.62]那就要吞下苦\r\n[02:19.55]混着泥沙泡沫奔波\r\n[02:22.40]有谁会给机会\r\n[02:24.74]与你成天逍遥快活\r\n[02:27.23]倒不如寥寥一瞬\r\n[02:29.87]个人努力生活\r\n[02:35.02]独自生活不一定有结果\r\n[02:44.74]人间喜乐还需自己琢磨\r\n[02:54.41]独自生活不一定有结果\r\n[03:04.33]无谓如何如此一生值得\r\n[03:38.83]独自生活不一定有结果\r\n[03:48.35]人间喜乐还需自己琢磨\r\n[03:58.11]独自生活不一定有结果\r\n[04:07.93]无谓如何如此一生值得\r\n[04:22.74]无谓如何如此一生值得', '/song/1673150161101song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (22, 24, '陈粒-易燃易爆炸', '《易燃易爆炸》由低声打头，然后开始燃烧，蔓延蔓延...以独特的乌鸦嗓风格给人以几欲燃烧撕裂却又延绵不断的感觉。', '2023-01-08 04:02:59', '2023-01-08 05:14:53', '/img/songPic/1673150665833易燃易爆炸.jpeg', '[00:00.57]陈粒 - 易燃易爆炸\n[00:03.20]作词：尚梦迪、骈然\n[00:06.33]作曲：陈粒\n[00:16.45]盼我疯魔\n[00:18.21]还盼我孑孓不独活\n[00:20.24]想我冷艳\n[00:22.20]还想我轻佻又下贱\n[00:24.37]要我阳光\n[00:26.34]还要我风情不摇晃\n[00:28.51]戏我哭笑无主\n[00:30.81]还戏我心如枯木\n[00:32.83]赐我梦境\n[00:34.72]还赐我很快就清醒\n[00:36.89]与我沉睡\n[00:39.02]还与我蹉跎无慈悲\n[00:41.18]爱我纯粹\n[00:43.15]还爱我赤裸不糜颓\n[00:45.36]看我自弹自唱\n[00:47.38]还看我痛心断肠\n[00:49.85]愿我如烟\n[00:51.46]还愿我曼丽又懒倦\n[00:53.78]看我痴狂\n[00:55.60]还看我风趣又端庄\n[00:57.67]要我美艳\n[00:59.70]还要我杀人不眨眼\n[01:01.83]祝我从此幸福\n[01:04.00]还祝我枯萎不渡\n[01:06.28]为我撩人\n[01:08.24]还为我双眸失神\n[01:10.37]图我情真\n[01:12.44]还图我眼波销魂\n[01:14.81]与我私奔\n[01:16.53]还与我做不二臣\n[01:18.75]夸我含苞待放\n[01:20.61]还夸我欲盖弥彰\n[01:39.61]赐我梦境\n[01:41.78]还赐我很快就清醒\n[01:43.80]与我沉睡\n[01:45.98]还与我蹉跎无慈悲\n[01:47.99]爱我纯粹\n[01:49.86]还爱我赤裸不糜颓\n[01:51.98]看我自弹自唱\n[01:54.16]还看我痛心断肠\n[01:56.23]为我撩人\n[01:58.25]还为我双眸失神\n[02:00.43]图我情真\n[02:02.44]还图我眼波销魂\n[02:04.82]与我私奔\n[02:06.63]还与我做不二臣\n[02:08.85]夸我含苞待放\n[02:10.81]还夸我欲盖弥彰\n[02:29.96]请我迷人\n[02:31.81]还请我艳情透渗\n[02:33.93]似我盛放\n[02:35.75]还似我缺氧乖张\n[02:38.07]由我美丽\n[02:39.99]还由我贪恋着迷\n[02:42.36]怨我百岁无忧\n[02:44.38]还怨我徒有泪流', '/song/1673150579309song.mp3');
INSERT INTO `song` (`id`, `singer_id`, `name`, `introduction`, `create_time`, `update_time`, `pic`, `lyric`, `url`) VALUES (23, 25, '王力宏-Can You Feel My World', '对于爱情：表面上看像是在埋怨她，细细倾听，其实在完完全全的在责备自己。有些沉重的旋律，诉说的只有自己的不是。', '2023-01-08 04:09:23', '2023-01-08 04:10:59', '/img/songPic/1673151059804Can You Feel My World.jpeg', '[00:00.39]王力宏 - Can You Feel My World\r\n[00:01.95]词：李焯雄\r\n[00:02.86]曲：王力宏\r\n[00:15.63]你只喜欢我微笑\r\n[00:19.54]你决定我的需要\r\n[00:23.17]我要怎么说才好\r\n[00:26.89]我不是为你制造\r\n[00:30.81]关心像是泥沼\r\n[00:32.63]拉住我往下掉\r\n[00:34.49]爱是漂亮口号\r\n[00:36.50]透过你的视角\r\n[00:38.36]你把我的喜好\r\n[00:40.27]随便删掉\r\n[00:42.28]变成你要的调调\r\n[00:46.10]你为我好我知道\r\n[00:49.90]我都知道\r\n[00:54.08]我的烦恼我的骄傲\r\n[00:57.60]你却不明了\r\n[01:01.63]怎样爱你才好\r\n[01:05.33]毕竟黑豹需要自由奔跑\r\n[01:12.58]不能满足于拥抱\r\n[01:16.75]Can You Feel My World\r\n[01:20.54]真实的我没办法伪造\r\n[01:24.42]Can You Take My Hands\r\n[01:28.29]真诚你会感觉到\r\n[01:32.02]Can You Feel My World\r\n[01:35.89]真实的我没办法伪造\r\n[01:39.77]并不想讨好\r\n[01:43.64]你才觉得我重要\r\n[01:47.47]你只要我有礼貌\r\n[01:51.24]其他假装看不到\r\n[01:55.17]我要怎么说才好\r\n[01:58.94]当我的情绪低潮\r\n[02:02.77]关心像是泥沼\r\n[02:04.58]拉住我往下掉\r\n[02:06.49]爱是漂亮口号\r\n[02:08.35]透过你的视角\r\n[02:10.37]你把我的喜好\r\n[02:12.23]随便删掉\r\n[02:14.19]变成你要的调调\r\n[02:18.11]你为我好我知道\r\n[02:21.43]我都知道\r\n[02:25.76]我的烦恼我的骄傲\r\n[02:29.53]你却不明了\r\n[02:33.41]怎样爱你才好\r\n[02:37.29]毕竟黑豹需要自由奔跑\r\n[02:44.66]I keep on comin\' back for more\r\n[02:46.73]Rap：I keep on comin\' back for more yo\r\n[02:49.25]日日夜夜我闭着双眼祈祷\r\n[02:51.97]为什么只有我的音乐能够让我依靠\r\n[02:55.84]我知道我的世界已经变的越来越小\r\n[02:59.56]跑不掉 逃不了\r\n[03:01.42]怎么面带着微笑\r\n[03:03.49]怎么面对着你才好\r\n[03:05.40]怎么眼泪都在掉\r\n[03:07.26]怎么嘴嘟着好严肃\r\n[03:09.62]这不是哭着就好\r\n[03:11.13]怎么旋律在我脑袋\r\n[03:13.15]一直转一直绕\r\n[03:15.07]意志力 一直撑着我再一次祷告\r\n[03:18.91]帮助我\r\n[03:19.61]Can You Feel My World\r\n[03:23.29]真实的我没办法伪造\r\n[03:27.06]Can You Take My Hands\r\n[03:30.88]真诚你会感觉到\r\n[03:34.81]Can You Feel My World\r\n[03:38.48]真实的我没办法伪造\r\n[03:42.41]并不想讨好 你才觉得我重要\r\n[03:50.35]Can You Feel My World\r\n[03:53.97]真实的我没办法伪造\r\n[03:57.82]Can You Take My Hands\r\n[04:01.55]真诚你会感觉到\r\n[04:05.47]Can You Feel My World\r\n[04:09.14]真实的我没办法伪造\r\n[04:12.96]并不想讨好 你才觉得我重要', '/song/1673150963455song.mp3');
COMMIT;

-- ----------------------------
-- Table structure for song_list
-- ----------------------------
DROP TABLE IF EXISTS `song_list`;
CREATE TABLE `song_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `style` varchar(255) DEFAULT NULL COMMENT '风格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='歌单';

-- ----------------------------
-- Records of song_list
-- ----------------------------
BEGIN;
INSERT INTO `song_list` (`id`, `title`, `pic`, `introduction`, `style`) VALUES (4, 'Tomorrow', '/img/songListPic/1673153440841明天.jpeg', 'Tomorrow is another day', '华语');
INSERT INTO `song_list` (`id`, `title`, `pic`, `introduction`, `style`) VALUES (5, 'Romantic', '/img/songListPic/1673153509981浪漫.jpeg', 'Poetry and distance', '欧美');
INSERT INTO `song_list` (`id`, `title`, `pic`, `introduction`, `style`) VALUES (6, 'Thinking', '/img/songListPic/1673153727585思考.jpg', 'Thought is everything', '华语');
INSERT INTO `song_list` (`id`, `title`, `pic`, `introduction`, `style`) VALUES (7, 'Shout', '/img/songListPic/1673153925297呐喊.jpeg', 'Shout out loud', '华语');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
