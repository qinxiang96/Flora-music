package com.flora.music.service.impl;

import com.flora.music.dao.ListSongMapper;
import com.flora.music.domain.ListSong;
import com.flora.music.service.ListSongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/2-下午12:39
 */
@Service
public class ListSongServiceImpl implements ListSongService {
    @Autowired
    private ListSongMapper listSongMapper;
    /**
     * 增加
     *
     * @param listSong
     * @return
     */
    @Override
    public boolean insert(ListSong listSong) {
        return listSongMapper.insert(listSong)>0;
    }

    /**
     * 更新
     *
     * @param listSong
     * @return
     */
    @Override
    public boolean update(ListSong listSong) {
        return listSongMapper.update(listSong)>0;
    }

    /**
     * 删除
     *
     * @param songId
     * @param songListId
     * @return
     */
    @Override
    public boolean delete(Integer songId, Integer songListId) {
        return listSongMapper.delete(songId,songListId)>0;
    }

    /**
     * 根据主键查询整个对象
     *
     * @param id
     * @return
     */
    @Override
    public ListSong selectByPrimaryKey(Integer id) {
        return listSongMapper.selectByPrimaryKey(id);
    }

    /**
     * 查询所有歌单歌曲
     *
     * @return
     */
    @Override
    public List<ListSong> allListSong() {
        return listSongMapper.allListSong();
    }

    /**
     * 根据歌单ID查询所有的歌单歌曲
     *
     * @param songListId
     * @return
     */
    @Override
    public List<ListSong> selectBySongListId(Integer songListId) {
        return listSongMapper.selectBySongListId(songListId);
    }
}
