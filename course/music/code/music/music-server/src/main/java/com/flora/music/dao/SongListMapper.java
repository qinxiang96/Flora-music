package com.flora.music.dao;

import com.flora.music.domain.SongList;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/1-下午10:20
 */
@Repository
public interface SongListMapper {
    /**
     * 增加
     * @param songList
     *
     * @return
     */
    public int insert(SongList songList);

    /**
     * 更新
     * @param songList
     *
     * @return
     */
    public int update(SongList songList);

    /**
     * 删除
     * @param id
     * @return
     */
    public int delete(Integer id);

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
