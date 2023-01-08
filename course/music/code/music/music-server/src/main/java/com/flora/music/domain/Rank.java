package com.flora.music.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午1:08
 */
@Data
public class Rank implements Serializable {
    //主键
    private Integer id;
    //歌单ID
    private Integer songListId;
    //用户ID
    private Integer consumerId;
    //评分
    private Integer score;
}
