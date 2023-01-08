package com.flora.music.service.impl;

import com.flora.music.dao.CollectMapper;
import com.flora.music.domain.Collect;
import com.flora.music.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/7-上午12:28
 */
@Service
public class CollectServiceImpl implements CollectService {
    @Autowired
    private CollectMapper collectMapper;
    /**
     * 增加
     *
     * @param collect
     * @return
     */
    @Override
    public boolean insert(Collect collect) {
        return collectMapper.insert(collect)>0;
    }

    /**
     * 删除
     *
     * @param userId,songId
     * @return
     */
    @Override
    public boolean delete(Integer userId,Integer songId) {
        return collectMapper.delete(userId,songId)>0;
    }

    /**
     * 查询所有收藏
     *
     * @return
     */
    @Override
    public List<Collect> allCollect() {
        return collectMapper.allCollect();
    }

    /**
     * 查询某个用户的收藏列表
     *
     * @param userId
     * @return
     */
    @Override
    public List<Collect> selectByUserId(Integer userId) {
        return collectMapper.selectByUserId(userId);
    }

    /**
     * 查询某个用户是否已经收藏了某个歌单
     *
     * @param userId
     * @param songListId
     * @return
     */
    @Override
    public boolean selectByUserAndSongListId(Integer userId, Integer songListId) {
        return collectMapper.selectByUserAndSongListId(userId, songListId)>0;
    }
    /**
     * 查询某个用户是否已经收藏了某个歌曲
     *
     * @param userId
     * @param songId
     * @return
     */
    @Override
    public boolean selectByUserAndSongId(Integer userId, Integer songId) {
        return collectMapper.selectByUserAndSongId(userId, songId)>0;
    }
}
