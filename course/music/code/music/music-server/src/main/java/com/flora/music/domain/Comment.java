package com.flora.music.domain;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午6:54
 */
@Data
public class Comment implements Serializable {
    //主键
    private Integer id;
    //用户id
    private Integer userId;
    //歌曲id
    private Integer songId;
    //歌单id
    private Integer songListId;
    //内容
    private String content;
    //评论时间
    private Date createTime;
    //评论类型 0 歌曲 1 歌单
    private Byte type;
    //评论点赞数
    private Integer up;
}
