package com.flora.music.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * @Author qinxiang
 * @Date 2023/1/1-下午10:16
 * 歌单
 */
@Data
public class SongList implements Serializable {
    //主键
    private Integer id;
    //标题
    private String title;
    //图片
    private String pic;
    //简介
    private String introduction;
    //风格
    private String style;

}
