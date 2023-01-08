package com.flora.music.service;

import com.flora.music.domain.Singer;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2022/12/30-下午2:25
 */
public interface SingerService {
    /**
     * 增加
     * @param singer
     * @return
     */
    public boolean insert(Singer singer);

    /**
     * 更新
     * @param singer
     * @return
     */
    public boolean update(Singer singer);

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
    public Singer selectByPrimaryKey(Integer id);

    /**
     * 查询所有歌手
     * @return
     */
    public List<Singer> allSinger();

    /**
     * 根据歌手名字查询列表
     * @param name
     * @return
     */
    public List<Singer> selectByName(String name);

    /**
     * 根据性别查询列表
     * @param sex
     * @return
     */
    public List<Singer> selectBySex(Integer sex);

    /**
     * 更新歌手图片
     * @param id
     * @return
     */
    public boolean updatePic(Integer id);
}
