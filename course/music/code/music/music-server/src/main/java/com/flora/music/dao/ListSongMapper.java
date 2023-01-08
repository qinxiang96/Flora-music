package com.flora.music.dao;

import com.flora.music.domain.ListSong;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/2-下午12:05
 * 歌单歌曲
 */
@Repository
public interface ListSongMapper {
    /**
     * 增加
     * @param listSong
     *
     * @return
     */
    public int insert(ListSong listSong);

    /**
     * 更新
     * @param listSong
     *
     * @return
     */
    public int update(ListSong listSong);

    /**
     * 删除
     * @param songId,songListId
     * @return
     */
    public int delete(Integer songId, Integer songListId);

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
