package com.flora.music.service;

import com.flora.music.domain.Collect;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/7-上午12:26
 */
public interface CollectService {
    /**
     * 增加
     * @param collect
     * @return
     */
    public boolean insert(Collect collect);
    /**
     * 根据用户ID和歌曲ID删除
     * @param userId,songId
     * @return
     */
    public boolean delete(Integer userId,Integer songId);
    /**
     * 查询所有收藏
     * @return
     */
    public List<Collect> allCollect();
    /**
     * 查询某个用户的收藏列表
     * @param userId
     * @return
     */
    public List<Collect> selectByUserId(Integer userId);
    /**
     * 查询某个用户是否已经收藏了某个歌单
     * @param songListId
     * @return
     */
    public boolean selectByUserAndSongListId(Integer userId, Integer songListId);
    /**
     * 查询某个用户是否已经收藏了某个歌曲
     *
     * @param userId
     * @param songId
     * @return
     */
    public boolean selectByUserAndSongId(Integer userId, Integer songId);
}
