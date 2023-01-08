package com.flora.music.service;

import com.flora.music.domain.ListSong;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/2-下午12:36
 * 歌单里面歌曲的service
 */
public interface ListSongService {
    /**
     * 增加
     * @param listSong
     *
     * @return
     */
    public boolean insert(ListSong listSong);

    /**
     * 更新
     * @param listSong
     *
     * @return
     */
    public boolean update(ListSong listSong);

    /**
     * 删除
     * @param songId,songListId
     * @return
     */
    public boolean delete(Integer songId, Integer songListId);

    /**
     * 根据主键查询整个对象
     * @param id
     * @return
     */
    public ListSong selectByPrimaryKey(Integer id);

    /**
     * 查询所有歌单歌曲
     * @return
     */
    public List<ListSong> allListSong();

    /**
     * 根据歌单ID查询所有的歌单歌曲
     * @param songListId
     * @return
     */
    public List<ListSong> selectBySongListId(Integer songListId);
}
