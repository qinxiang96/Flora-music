package com.flora.music.controller;

import com.alibaba.druid.sql.visitor.functions.Now;
import com.alibaba.fastjson.JSONObject;
import com.flora.music.domain.Singer;
import com.flora.music.domain.Song;
import com.flora.music.service.SingerService;
import com.flora.music.service.SongService;
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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @Author qinxiang
 * @Date 2022/12/31-下午4:16
 */
@RestController
@RequestMapping("/song")
public class SongController {
    @Autowired
    private SongService songService;
    private SingerService singerService;

    /**
     * 添加歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = ("/add"), method = RequestMethod.POST)
    public Object addSong(HttpServletRequest request, @RequestParam("file") MultipartFile mpFile){
        JSONObject jsonObject = new JSONObject();
        String singerId = request.getParameter("singerId").trim();
        String name = request.getParameter("name").trim();
        String introduction = request.getParameter("introduction").trim();
        String pic = "/img/songPic/hhh.jpg";
        String lyric = request.getParameter("lyric").trim();
        //上传歌曲文件
        if (mpFile.isEmpty()){
            jsonObject.put(Consts.CODE, 0);
            jsonObject.put(Consts.MSG, "upload song failed");
            return jsonObject;
        }
        //文件名=当前时间到毫秒+原来的文件名
        String fileName = System.currentTimeMillis()+mpFile.getOriginalFilename();
        //文件路径
        String filePath = System.getProperty("user.dir") + System.getProperty("file.separator")+"song";
        //如果文件路径不存在，新增该路径
        File file1 = new File(filePath);
        if (!file1.exists()){
            file1.mkdir();
        }
        //实际的文件地址
        File dest = new File(filePath + System.getProperty("file.separator") + fileName);
        //存储到数据库的相对文件地址
        String storeUrlPath = "/song/"+fileName;
        try {
            mpFile.transferTo(dest);
            Song song = new Song();
            song.setSingerId(Integer.parseInt(singerId));
            song.setName(name);
            song.setIntroduction(introduction);
//            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            Date date = new Date();
//            try {
//                date = dateFormat.parse(String.valueOf(date));
//            } catch (ParseException e) {
//                e.printStackTrace();
//            }
//            song.setCreateTime(date);
//            song.setUpdateTime(date);
            song.setPic(pic);
            song.setLyric(lyric);
            song.setUrl(storeUrlPath);
            System.out.println(song);
            boolean flag = songService.insert(song);
            if (flag){
                jsonObject.put(Consts.CODE,1);
                jsonObject.put(Consts.MSG,"add song successfully");
                return jsonObject;
            }
            jsonObject.put(Consts.CODE,0);
            jsonObject.put(Consts.MSG,"add song failed");
            return jsonObject;
        } catch (IOException e) {
            jsonObject.put(Consts.CODE, 0);
            jsonObject.put(Consts.MSG, "add song failed" + e.getMessage());
        }finally {
            return jsonObject;
        }
    }

    /**
     * 根据歌手ID查询歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/singer/detail", method = RequestMethod.GET)
    public Object songOfSingerId(HttpServletRequest request){
        String singerId = request.getParameter("singerId");
        return songService.selectBySingerId(Integer.parseInt(singerId));
    }
    /**
     * 根据歌曲ID查询歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public Object songOfSongId(HttpServletRequest request){
        String id = request.getParameter("id");
        return songService.selectByPrimaryKey(Integer.parseInt(id));
    }
    /**
     * 根据歌手name精确查询歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/songOfSingerName", method = RequestMethod.GET)
    public Object songOfSingerName(HttpServletRequest request){
        String singerName = request.getParameter("singerName");
        return songService.selectByName(singerName);
    }
    /**
     * 根据歌手name模糊查询歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/selectLikeName", method = RequestMethod.GET)
    public Object songLikeSingerName(HttpServletRequest request){
        String singerName = request.getParameter("singerName");
        return songService.selectLikeName(singerName);
    }
    /**
     * 根据歌曲name查询歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/songName/detail", method = RequestMethod.GET)
    public Object songOfSongName(HttpServletRequest request){
        String songName = request.getParameter("songName");
        return songService.selectByName(songName);
    }

    /**
     * 更新歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public Object updateSong(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        String name = request.getParameter("name").trim();
        String introduction = request.getParameter("introduction").trim();
        String lyric = request.getParameter("lyric").trim();
        Song song = new Song();
        song.setId(Integer.parseInt(id));
        song.setName(name);
        song.setIntroduction(introduction);
        song.setLyric(lyric);
        boolean flag = songService.update(song);
        if (flag){
            jsonObject.put(Consts.CODE, 1);
            jsonObject.put(Consts.MSG, "update successfully");
            return jsonObject;
        }
        jsonObject.put(Consts.CODE,0);
        jsonObject.put(Consts.MSG,"update failed");
        return jsonObject;
    }
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public Object deleteSong(HttpServletRequest request){
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id").trim();
        //获取代码目录中的mp3文件地址
        Song song = songService.selectByPrimaryKey(Integer.parseInt(id));
        String url = song.getUrl();
        boolean flag = songService.delete(Integer.parseInt(id));
        if (flag){
            jsonObject.put(Consts.CODE, 1);
            jsonObject.put(Consts.MSG, "delete successfully");
            //删除代码目录中的mp3文件
            String filePath = System.getProperty("user.dir") + url;
            File dest = new File(filePath);
            dest.delete();
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
        return songService.selectByPrimaryKey(Integer.parseInt(id));
    }
    /**
     * 查询所有歌曲
     * @param request
     * @return
     */
    @RequestMapping(value = "/allSong", method = RequestMethod.GET)
    public Object allSong(HttpServletRequest request){
        return songService.allSong();
    }

    /**
     * 更新歌曲图片
     * @param avatorFile
     * @param id
     * @return
     */
    @RequestMapping(value = "/updateSongPic", method = RequestMethod.POST)
    public Object updateSongPic(@RequestParam("file") MultipartFile avatorFile, @RequestParam("id") int id){
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
                + System.getProperty("file.separator")+"songPic";
        //如果文件路径不存在，新增该路径
        File file1 = new File(filePath);
        if (!file1.exists()){
            file1.mkdir();
        }
        //实际的文件地址
        File dest = new File(filePath + System.getProperty("file.separator") + fileName);
        //存储到数据库的相对文件地址
        String storeAvatorPath = "/img/songPic/"+fileName;
        try {
            avatorFile.transferTo(dest);
            Song song = new Song();
            song.setId(id);
            song.setPic(storeAvatorPath);
            boolean flag = songService.update(song);
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
    /**
     * 更新歌曲地址
     * @param avatorFile
     * @param id
     * @return
     */
    @RequestMapping(value = "/updateSongUrl", method = RequestMethod.POST)
    public Object updateSongUrl(@RequestParam("file") MultipartFile avatorFile, @RequestParam("id") int id){
        JSONObject jsonObject = new JSONObject();
        if (avatorFile.isEmpty()){
            jsonObject.put(Consts.CODE, 0);
            jsonObject.put(Consts.MSG, "upload pic failed");
            return jsonObject;
        }
        //文件名=当前时间到毫秒+原来的文件名
        String fileName = System.currentTimeMillis()+avatorFile.getOriginalFilename();
        //文件路径
        String filePath = System.getProperty("user.dir") + System.getProperty("file.separator")+"song";
        //如果文件路径不存在，新增该路径
        File file1 = new File(filePath);
        if (!file1.exists()){
            file1.mkdir();
        }
        //实际的文件地址
        File dest = new File(filePath + System.getProperty("file.separator") + fileName);
        //存储到数据库的相对文件地址
        String storeAvatorPath = "/song/"+fileName;
        try {
            avatorFile.transferTo(dest);
            Song song = new Song();
            song.setId(id);
            song.setUrl(storeAvatorPath);
            boolean flag = songService.update(song);
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
