package com.flora.music.dao;

import com.flora.music.domain.Comment;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午7:03
 */
@Repository
public interface CommentMapper {
    /**
     * 增加
     * @param comment
     * @return
     */
    public int insert(Comment comment);
    /**
     * 修改
     * @param comment
     * @return
     */
    public int update(Comment comment);
    /**
     * 删除
     * @param id
     * @return
     */
    public int delete(Integer id);
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
