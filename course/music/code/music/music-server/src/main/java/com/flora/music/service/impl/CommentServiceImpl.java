package com.flora.music.service.impl;

import com.flora.music.dao.CommentMapper;
import com.flora.music.domain.Comment;
import com.flora.music.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午7:39
 */
@Service
public class CommentServiceImpl implements CommentService{
    @Autowired
    private CommentMapper commentMapper;

    /**
     * 增加
     *
     * @param comment
     * @return
     */
    @Override
    public boolean insert(Comment comment) {
        return commentMapper.insert(comment)>0;
    }

    /**
     * 修改
     *
     * @param comment
     * @return
     */
    @Override
    public boolean update(Comment comment) {
        return commentMapper.update(comment)>0;
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @Override
    public boolean delete(Integer id) {
        return commentMapper.delete(id)>0;
    }

    /**
     * 根据主键id查询评论对象
     *
     * @param id
     * @return
     */
    @Override
    public Comment selectByPrimaryKey(Integer id) {
        return commentMapper.selectByPrimaryKey(id);
    }

    /**
     * 查询所有评论
     *
     * @return
     */
    @Override
    public List<Comment> allComment() {
        return commentMapper.allComment();
    }

    /**
     * 根据歌曲id查询所有评论
     *
     * @param songId
     * @return
     */
    @Override
    public List<Comment> selectBySongId(Integer songId) {
        return commentMapper.selectBySongId(songId);
    }

    /**
     * 根据歌单id查询所有评论
     *
     * @param songListId
     * @return
     */
    @Override
    public List<Comment> selectBySongListId(Integer songListId) {
        return commentMapper.selectBySongListId(songListId);
    }
}
