package com.flora.music.controller;

import com.alibaba.fastjson.JSONObject;
import com.flora.music.domain.Song;
import com.flora.music.domain.SongList;
import com.flora.music.service.SongListService;
import com.flora.music.utils.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * @Author qinxiang
 * @Date 2023/1/1-下午10:50
 */
@RestController
@RequestMapping("/songList")
public class SongListController {
    @Autowired
    private SongListService songListService;
    /**
     * 添加歌单
     * @param request
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public Object addSongList(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String title = request.getParameter("title").trim();
        String pic = "/img/songListPic/hhh.jpg";
        String introduction = request.getParameter("introduction").trim();
        String style = request.getParameter("style").trim();
        SongList songList = new SongList();
        songList.setTitle(title);
        songList.setPic(pic);
        songList.setIntroduction(introduction);
        songList.setStyle(style);
        boolean flag = songListService.insert(songList);
        if (flag){
            jsonObject.put(Consts.CODE,1);
            jsonObject.put(Consts.MSG,"add successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG,"add failed");
        return jsonObject;

    }
    /**
     * 更新歌单
     * @param request
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public Object updateSongList(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        String title = request.getParameter("title").trim();
        String introduction = request.getParameter("introduction").trim();
        String style = request.getParameter("style").trim();
        SongList songList = new SongList();
        songList.setId(Integer.parseInt(id));
        songList.setTitle(title);
        songList.setIntroduction(introduction);
        songList.setStyle(style);
        boolean flag = songListService.update(songList);
        if (flag){
            jsonObject.put(Consts.CODE, 1);
            jsonObject.put(Consts.MSG, "update successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG,"update failed");
        return jsonObject;
    }

    /**
     * 删除歌单
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public Object deleteSongList(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        boolean flag = songListService.delete(Integer.parseInt(id));
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
        return songListService.selectByPrimaryKey(Integer.parseInt(id));
    }
    /**
     * 查询所有歌单
     * @param request
     * @return
     */
    @RequestMapping(value = "/allSongList", method = RequestMethod.GET)
    public Object allSongList(HttpServletRequest request){
        return songListService.allSongList();
    }
    /**
     * 根据标题精确查询歌单列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectByTitle", method = RequestMethod.GET)
    public Object selectByTitle(HttpServletRequest request){
        String title = request.getParameter("title").trim();
        return songListService.selectByTitle(title);
    }
    /**
     * 根据标题模糊查询歌单列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectLikeTitle", method = RequestMethod.GET)
    public Object selectLikeTitle(HttpServletRequest request){
        String title = request.getParameter("title").trim();
        return songListService.selectLikeTitle("%" +title+ "%");
    }
    /**
     * 根据风格模糊查询歌单列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectLikeStyle", method = RequestMethod.GET)
    public Object selectLikeStyle(HttpServletRequest request){
        String style = request.getParameter("style").trim();
        return songListService.selectLikeStyle("%" +style+ "%");
    }
    /**
     * 更新歌单图片
     * @param avatorFile
     * @param id
     * @return
     */
    @RequestMapping(value = "/updateSongListPic", method = RequestMethod.POST)
    public Object updateSongListPic(@RequestParam("file") MultipartFile avatorFile, @RequestParam("id") int id){
        JSONObject jsonObject = new JSONObject();
        if (avatorFile.isEmpty()){
            jsonObject.put(Consts.CODE, 0);
            jsonObject.put(Consts.MSG, "upload pic failed");
            return jsonObject;
        }
        //文件名=当前时间到毫秒+原来的文件名
        String fileName = System.currentTimeMillis()+avatorFile.getOriginalFilename();
        //文件路径
        String filePath = System.getProperty("user.dir") + System.getProperty("file.separator")+"img"
                + System.getProperty("file.separator")+"songListPic";
        //如果文件路径不存在，新增该路径
        File file1 = new File(filePath);
        if (!file1.exists()){
            file1.mkdir();
        }
        //实际的文件地址
        File dest = new File(filePath + System.getProperty("file.separator") + fileName);
        //存储到数据库的相对文件地址
        String storeAvatorPath = "/img/songListPic/"+fileName;
        try {
            avatorFile.transferTo(dest);
            SongList songList = new SongList();
            songList.setId(id);
            songList.setPic(storeAvatorPath);
            boolean flag = songListService.update(songList);
            if (flag){
                jsonObject.put(Consts.CODE, 1);
                jsonObject.put(Consts.MSG, "upload successfully");
                return jsonObject;
            }
            jsonObject.put(Consts.CODE, 0);
            jsonObject.put(Consts.MSG, "upload failed");
            return jsonObject;
        } catch (IOException e) {
            jsonObject.put(Consts.CODE, 0);
            jsonObject.put(Consts.MSG, "upload failed" + e.getMessage());
        }finally {
            return jsonObject;
        }
    }
}
