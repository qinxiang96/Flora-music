package com.flora.music.service.impl;

import com.flora.music.dao.SongMapper;
import com.flora.music.domain.Song;
import com.flora.music.service.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2022/12/31-下午4:11
 */
@Service
public class SongServiceImpl implements SongService {
    @Autowired
    private SongMapper songMapper;

    /**
     * 增加
     *
     * @param song
     * @return
     */
    @Override
    public boolean insert(Song song) {
        return songMapper.insert(song)>0;
    }

    /**
     * 更新
     *
     * @param song
     * @return
     */
    @Override
    public boolean update(Song song) {
        return songMapper.update(song)>0;
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @Override
    public boolean delete(Integer id) {
        return songMapper.delete(id)>0;
    }

    /**
     * 根据主键查询整个对象
     *
     * @param id
     * @return
     */
    @Override
    public Song selectByPrimaryKey(Integer id) {
        return songMapper.selectByPrimaryKey(id);
    }

    /**
     * 查询所有歌曲
     *
     * @return
     */
    @Override
    public List<Song> allSong() {
        return songMapper.allSong();
    }

    /**
     * 根据歌曲名字查询列表
     *
     * @param name
     * @return
     */
    @Override
    public List<Song> selectByName(String name) {
        return songMapper.selectByName(name);
    }

    /**
     * 根据歌曲名字模糊查询列表
     *
     * @param name
     * @return
     */
    @Override
    public List<Song> selectLikeName(String name) {
        return songMapper.selectLikeName("%" +name+ "%");
    }

    /**
     * 根据歌手id查询列表
     *
     * @param singerId
     * @return
     */
    @Override
    public List<Song> selectBySingerId(Integer singerId) {
        return songMapper.selectBySingerId(singerId);
    }
}
