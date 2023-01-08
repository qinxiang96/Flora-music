package com.flora.music.service;

import com.flora.music.domain.Rank;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午1:42
 */
public interface RankService {
    /**
     * 增加
     * @param rank
     * @return
     */
    public boolean insert(Rank rank);

    /**
     * 查询总分
     * @param songListId
     * @return
     */
    public int selectScoreSum(Integer songListId);

    /**
     * 查询评分人数
     * @param songListId
     * @return
     */
    public int selectRankNum(Integer songListId);

    /**
     * 计算平均分
     * @param songListId
     * @return
     */
    public int rankOfSongListId(Integer songListId);
}
