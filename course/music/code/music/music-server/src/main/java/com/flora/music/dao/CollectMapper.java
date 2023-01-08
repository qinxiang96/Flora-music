package com.flora.music.dao;

import com.flora.music.domain.Collect;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/7-上午12:08
 */
@Repository
public interface CollectMapper {
    /**
     * 增加
     * @param collect
     * @return
     */
    public int insert(Collect collect);
    /**
     * 删除
     * @param userId,songId
     * @return
     */
    public int delete(Integer userId,Integer songId);
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
     * @param userId
     * @param songListId
     * @return
     */
    public int selectByUserAndSongListId(Integer userId, Integer songListId);
    /**
     * 查询某个用户是否已经收藏了某个歌曲
     *
     * @param userId
     * @param songId
     * @return
     */
    public int selectByUserAndSongId(Integer userId, Integer songId);
}
