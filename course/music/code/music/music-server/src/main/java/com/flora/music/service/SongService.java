package com.flora.music.service;

import com.flora.music.domain.Song;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2022/12/30-下午2:25
 */
public interface SongService {
    /**
     * 增加
     * @param song
     * @return
     */
    public boolean insert(Song song);

    /**
     * 更新
     * @param song
     * @return
     */
    public boolean update(Song song);

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
    public Song selectByPrimaryKey(Integer id);

    /**
     * 查询所有歌曲
     * @return
     */
    public List<Song> allSong();

    /**
     * 根据歌曲名字查询列表
     * @param name
     * @return
     */
    public List<Song> selectByName(String name);
    /**
     * 根据歌曲名字模糊查询列表
     * @param name
     * @return
     */
    public List<Song> selectLikeName(String name);

    /**
     * 根据歌手id查询列表
     * @param singerId
     * @return
     */
    public List<Song> selectBySingerId(Integer singerId);
}
