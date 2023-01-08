package com.flora.music.service;

import com.flora.music.domain.Comment;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午7:37
 */
public interface CommentService {
    /**
     * 增加
     * @param comment
     * @return
     */
    public boolean insert(Comment comment);
    /**
     * 修改
     * @param comment
     * @return
     */
    public boolean update(Comment comment);
    /**
     * 删除
     * @param id
     * @return
     */
    public boolean delete(Integer id);
    /**
     * 根据主键id查询评论对象
     * @param id
     * @return
     */
    public Comment selectByPrimaryKey(Integer id);

    /**
     * 查询所有评论
     * @return
     */
    public List<Comment> allComment();
    /**
     * 根据歌曲id查询所有评论
     * @param songId
     * @return
     */
    public List<Comment> selectBySongId(Integer songId);
    /**
     * 根据歌单id查询所有评论
     * @param songListId
     * @return
     */
    public List<Comment> selectBySongListId(Integer songListId);
}
