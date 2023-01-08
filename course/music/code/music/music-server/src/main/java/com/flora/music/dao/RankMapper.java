package com.flora.music.dao;

import com.flora.music.domain.Rank;
import org.springframework.stereotype.Repository;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午1:13
 */
@Repository
public interface RankMapper {
    /**
     * 增加
     * @param rank
     * @return
     */
    public int insert(Rank rank);

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
}
