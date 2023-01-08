package com.flora.music.service;

import com.flora.music.domain.SongList;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/1-下午10:45
 * 歌单service接口
 */
public interface SongListService {
    /**
     * 增加
     * @param songList
     *
     * @return
     */
    public boolean insert(SongList songList);

    /**
     * 更新
     * @param songList
     *
     * @return
     */
    public boolean update(SongList songList);

    /**
     * 删除
     * @param id
     * @return
     */
    public boolean delete(Integer id);

    /**
     * 根据主键查询整个对象
     * @param id
     * @return
     */
    public SongList selectByPrimaryKey(Integer id);

    /**
     * 查询所有歌单
     * @return
     */
    public List<SongList> allSongList();

    /**
     * 根据标题精确查询歌单列表
     * @param title
     * @return
     */
    public List<SongList> selectByTitle(String title);
    /**
     * 根据标题模糊查询歌单列表
     * @param title
     * @return
     */
    public List<SongList> selectLikeTitle(String title);
    /**
     * 根据风格模糊查询歌单列表
     * @param style
     * @return
     */
    public List<SongList> selectLikeStyle(String style);
}
