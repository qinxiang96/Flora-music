package com.flora.music.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * @Author qinxiang
 * @Date 2023/1/2-下午12:03
 */
@Data
public class ListSong implements Serializable {
    //主键
    private Integer id;
    //歌曲ID
    private Integer songId;
    //歌单ID
    private Integer songListId;
}
