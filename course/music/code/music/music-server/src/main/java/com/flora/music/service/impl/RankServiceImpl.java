package com.flora.music.service.impl;

import com.flora.music.dao.RankMapper;
import com.flora.music.domain.Rank;
import com.flora.music.service.RankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午1:44
 */
@Service
public class RankServiceImpl implements RankService {
    @Autowired
    private RankMapper rankMapper;
    /**
     * 增加
     *
     * @param rank
     * @return
     */
    @Override
    public boolean insert(Rank rank) {
        return rankMapper.insert(rank)>0;
    }

    /**
     * 查询总分
     *
     * @param songListId
     * @return
     */
    @Override
    public int selectScoreSum(Integer songListId) {
        return rankMapper.selectScoreSum(songListId);
    }

    /**
     * 查询评分人数
     *
     * @param songListId
     * @return
     */
    @Override
    public int selectRankNum(Integer songListId) {
        return rankMapper.selectRankNum(songListId);
    }
    /**
     * 计算平均分
     *
     * @param songListId
     * @return
     */
    @Override
    public int rankOfSongListId(Integer songListId) {
        int rankNum = rankMapper.selectRankNum(songListId);
        if (rankNum == 0){
            return 5;
        }
        return rankMapper.selectScoreSum(songListId)/rankNum;
    }
}
