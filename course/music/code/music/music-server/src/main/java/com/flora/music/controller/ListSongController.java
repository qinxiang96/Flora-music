package com.flora.music.controller;

import com.alibaba.fastjson.JSONObject;
import com.flora.music.domain.ListSong;
import com.flora.music.service.ListSongService;
import com.flora.music.utils.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
/**
 * @Author qinxiang
 * @Date 2023/1/2-下午12:44
 */
@RestController
@RequestMapping("/listSong")
public class ListSongController {
    @Autowired
    private ListSongService listSongService;
    /**
     * 添加歌单歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = ("/add"), method = RequestMethod.POST)
    public Object addSong(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String songId = request.getParameter("songId").trim();
        String songListId = request.getParameter("songListId").trim();
        ListSong listSong = new ListSong();
        listSong.setSongId(Integer.parseInt(songId));
        listSong.setSongListId(Integer.parseInt(songListId));
        boolean flag = listSongService.insert(listSong);
        if (flag){
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG,"add song successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG,"add song failed");
        return jsonObject;
    }

    /**
     * 更新歌单歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public Object updateSong(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        String songId = request.getParameter("songId").trim();
        String songListId = request.getParameter("songListId").trim();
        ListSong listSong = new ListSong();
        listSong.setId(Integer.parseInt(id));
        listSong.setSongId(Integer.parseInt(songId));
        listSong.setSongListId(Integer.parseInt(songListId));
        boolean flag = listSongService.update(listSong);
        if (flag){
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG,"update successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG,"update failed");
        return jsonObject;
    }

    /**
     * 删除歌单歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public Object deleteSong(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String songId = request.getParameter("songId").trim();
        String songListId = request.getParameter("songListId").trim();
        boolean flag = listSongService.delete(Integer.parseInt(songId),Integer.parseInt(songListId));
        if (flag){
            jsonObject.put(Consts.CODE, 1);
            jsonObject.put(Consts.MSG, "delete successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE, 0);
        jsonObject.put(Consts.MSG,"delete failed");
        return jsonObject;
    }

    /**
     * 根据主键查询整个对象
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectByPrimaryKey", method = RequestMethod.GET)
    public Object selectByPrimaryKey(HttpServletRequest request){
        String id = request.getParameter("id").trim();
        return listSongService.selectByPrimaryKey(Integer.parseInt(id));
    }
    /**
     * 查询所有歌单歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/allListSong", method = RequestMethod.GET)
    public Object allListSong(HttpServletRequest request){
        return listSongService.allListSong();
    }

    /**
     * 根据歌单ID查询所有的歌单歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectBySongListId", method = RequestMethod.GET)
    public Object selectBySongListId(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String songListId = request.getParameter("songListId").trim();
        return listSongService.selectBySongListId(Integer.parseInt(songListId));
    }
}
