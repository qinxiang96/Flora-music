package com.flora.music.domain;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author qinxiang
 * @Date 2023/1/7-上午12:05
 */
@Data
public class Collect implements Serializable {
    //主键
    private Integer id;
    //用户ID
    private Integer userId;
    //收藏类型 0歌曲1歌单
    private Byte type;
    //歌曲ID
    private Integer songId;
    //歌单ID
    private Integer songListId;
    //收藏时间
    private Date createTime;
}
