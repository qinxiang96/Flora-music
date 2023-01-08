package com.flora.music.dao;

import com.flora.music.domain.Singer;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.stereotype.Repository;

import javax.swing.*;
import java.util.List;

/**
 * @Author qinxiang
 * @Date 2022/12/30-下午1:48
 * 歌手Dao
 */
@Repository
public interface SingerMapper {
    /**
     * 增加
     * @param singer
     * @return
     */
    public int insert(Singer singer);

    /**
     * 更新
     * @param singer
     * @return
     */
    public int update(Singer singer);

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
    public int updatePic(Integer id);
}
