package com.flora.music.controller;

import com.alibaba.fastjson.JSONObject;
import com.flora.music.domain.Collect;
import com.flora.music.service.CollectService;
import com.flora.music.utils.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author qinxiang
 * @Date 2023/1/7-上午10:39
 */
@RestController
@RequestMapping("/collect")
public class CollectController {
    @Autowired
    private CollectService collectService;
    /**
     * 增加收藏
     * @param request
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public Object addCollect(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String userId = request.getParameter("userId");
        String type = request.getParameter("type").trim();
        String songId = request.getParameter("songId");
        String songListId = request.getParameter("songListId");
        Collect collect = new Collect();
        collect.setUserId(Integer.parseInt(userId));
        collect.setType(new Byte(type));
        if (Integer.parseInt(type) == 0){
            if (songId == null || songId.equals("")){
                jsonObject.put(Consts.CODE,0);
                jsonObject.put(Consts.MSG, "collect song is empty");
                return jsonObject;
            }else if(collectService.selectByUserAndSongId(Integer.parseInt(userId),Integer.parseInt(songId))){
                jsonObject.put(Consts.CODE,2);
                jsonObject.put(Consts.MSG, "collect song is be collected already");
                return jsonObject;
            }else {
                collect.setSongId(Integer.parseInt(songId));
            }
        }else{
            if (songListId == null || songListId.equals("")){
                jsonObject.put(Consts.CODE,0);
                jsonObject.put(Consts.MSG, "collect songList is empty");
                return jsonObject;
            }else if(collectService.selectByUserAndSongListId(Integer.parseInt(userId),Integer.parseInt(songListId))){
                jsonObject.put(Consts.CODE,2);
                jsonObject.put(Consts.MSG, "collect songList is be collected already");
                return jsonObject;
            }else {
                collect.setSongListId(Integer.parseInt(songListId));
            }
        }
        boolean flag = collectService.insert(collect);
        if (flag) {
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG, "collect successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG, "collect failed");
        return jsonObject;

    }
    /**
     * 根据用户ID和歌曲ID删除收藏
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public Object deleteCollect(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String userId = request.getParameter("userId").trim();
        String songId = request.getParameter("songId").trim();
        boolean flag = collectService.delete(Integer.parseInt(userId),Integer.parseInt(songId));
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
     * 查询所有收藏
     * @param request
     * @return
     */
    @RequestMapping(value = "/allCollect", method = RequestMethod.GET)
    public Object allCollect(HttpServletRequest request){
        return collectService.allCollect();
    }
    /**
     * 查询某个用户的收藏列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/collectByUserId", method = RequestMethod.GET)
    public Object collectByUserId(HttpServletRequest request){
        String userId = request.getParameter("userId").trim();
        return collectService.selectByUserId(Integer.parseInt(userId));

    }
    /**
     * 查询某个用户是否已经收藏了某个歌单
     * @param request
     * @return
     */
    @RequestMapping(value = "/collectByUserIdAndSongListId", method = RequestMethod.GET)
    public Object collectByUserIdAndSongListId(HttpServletRequest request){
        String userId = request.getParameter("userId").trim();
        String songListId = request.getParameter("songListId").trim();
        return collectService.selectByUserAndSongListId(Integer.parseInt(userId),Integer.parseInt(songListId));

    }
}
