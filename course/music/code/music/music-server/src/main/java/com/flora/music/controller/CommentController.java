package com.flora.music.controller;

import com.alibaba.fastjson.JSONObject;
import com.flora.music.domain.Comment;
import com.flora.music.service.CommentService;
import com.flora.music.utils.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Type;

/**
 * @Author qinxiang
 * @Date 2023/1/6-下午7:43
 */
@RestController
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    /**
     * 增加评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public Object addComment(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String userId = request.getParameter("userId").trim();
        String songId = request.getParameter("songId");
        String songListId = request.getParameter("songListId");
        String content = request.getParameter("content").trim();
        String type = request.getParameter("type");
        Comment comment = new Comment();
        if (new Byte(type) == 0){
            comment.setSongId(Integer.parseInt(songId));
        }else {
            comment.setSongListId(Integer.parseInt(songListId));
        }
        comment.setUserId(Integer.parseInt(userId));
        comment.setContent(content);
        comment.setType(new Byte(type));
        boolean flag = commentService.insert(comment);
        if (flag) {
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG, "comment successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG, "comment failed");
        return jsonObject;
    }
    /**
     * 修改评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public Object updateComment(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String userId = request.getParameter("userId").trim();
        String id = request.getParameter("id").trim();
        String songId = request.getParameter("songId");
        String songListId = request.getParameter("songListId");
        String content = request.getParameter("content");
        String type = request.getParameter("type").trim();
        Comment comment = new Comment();
        comment.setUserId(Integer.parseInt(userId));
        comment.setId(Integer.parseInt(id));
        comment.setContent(content);
        comment.setType(new Byte(type));
        //如何传过来的是空值，需要特殊处理
        if(new Byte(type) == 0){
            comment.setSongId(Integer.parseInt(songId));
        }else{
            comment.setSongListId(Integer.parseInt(songListId));
        }
//        if(songId != null && songId.equals("")){
//            songId = null;
//        }else{
//            comment.setSongId(Integer.parseInt(songId));
//        }
//        if(songListId != null && songListId.equals("")){
//            songListId = null;
//        }else{
//            comment.setSongListId(Integer.parseInt(songListId));
//        }
        boolean flag = commentService.update(comment);
        if (flag) {
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG, "update successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG, "update failed");
        return jsonObject;
    }
    /**
     * 删除
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public Object deleteComment(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        boolean flag = commentService.delete(Integer.parseInt(id));
        if (flag) {
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG, "delete successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG, "delete failed");
        return jsonObject;
    }
    /**
     * 根据主键id查询评论对象
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectByPrimaryKey", method = RequestMethod.GET)
    public Object selectByPrimaryKey(HttpServletRequest request){
        String id = request.getParameter("id").trim();
        return commentService.selectByPrimaryKey(Integer.parseInt(id));
    }
    /**
     * 查询所有评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/allComment", method = RequestMethod.GET)
    public Object allComment(HttpServletRequest request){ return commentService.allComment();
    }
    /**
     * 根据歌曲id查询所有评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectBySongId", method = RequestMethod.GET)
    public Object selectBySongId(HttpServletRequest request){
        String songId = request.getParameter("songId").trim();
        return commentService.selectBySongId(Integer.parseInt(songId));
    }
    /**
     * 根据歌单id查询所有评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectBySongListId", method = RequestMethod.GET)
    public Object selectBySongListId(HttpServletRequest request){
        String songListId = request.getParameter("songListId").trim();
        return commentService.selectBySongListId(Integer.parseInt(songListId));
    }
    /**
     * 给评论点赞
     * @param request
     * @return
     */
    @RequestMapping(value = "/like", method = RequestMethod.POST)
    public Object like(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        String up = request.getParameter("up").trim();
        Comment comment = new Comment();
        comment.setId(Integer.parseInt(id));
        comment.setUp(Integer.parseInt(up));
        boolean flag = commentService.update(comment);
        if (flag) {
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG, "like successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG, "like failed");
        return jsonObject;
    }
}
