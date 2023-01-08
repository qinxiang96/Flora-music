/* eslint-disable*/
import axios from 'axios'
import { get, post } from './http'

// =======================> 用户 API
// 登录
export const loginIn = (params) => post(`consumer/verifyPassword`, params)
// 注册
export const SignUp = (params) => post(`consumer/add`, params)
// 更新用户信息
export const updateUserMsg = (params) => post(`consumer/update`, params)
// 返回指定ID的用户
export const getUserOfId = (id) => get(`consumer/selectByPrimaryKey?id=${id}`)

// =======================> 歌单 API
// 添加歌单
export const setSongList = (params) => post(`songList/add`, params)
// 获取全部歌单
export const getSongList = () => get(`songList/allSongList`)
// 更新歌单信息
export const updateSongListMsg = (params) => post(`songList/update`, params)
// 删除歌单
export const deleteSongList = (id) => get(`songList/delete?id=${id}`)
// 获取歌单类型
export const getSongListOfStyle = (style) => get(`songList/selectLikeStyle?style=${style}`)
// 返回标题包含文字的歌单
export const getSongListOfLikeTitle = (keywords) => get(`songList/selectLikeTitle?title=${keywords}`)

// =======================> 歌手 API
// 通过性别对歌手分类
export const getSingerOfSex = (sex) => get(`singer/selectBySex?sex=${sex}`)
// 返回所有歌手
export const getAllSinger = () => get(`singer/allSinger`)
// 添加歌手
export const setSinger = (params) => post(`singer/add`, params)
// 更新歌手信息
export const updateSingerMsg = (params) => post(`singer/update`, params)
// 删除歌手
export const deleteSinger = (id) => get(`singer/delete?id=${id}`)

// =======================> 收藏 API
// 返回的指定用户ID的收藏列表
export const getCollectionOfUser = (userId) => get(`collect/collectByUserId?userId=${userId}`)
// 添加收藏的歌曲 type: 0 代表歌曲， 1 代表歌单
export const setCollection = (params) => post(`collect/add`, params)


// =======================> 评分 API
// 提交评分
export const setRank = (params) => post(`rank/add`, params)
// 获取指定歌单的评分
export const getRankOfSongListId = (songListId) => get(`rank/rankOfSongListId?songListId=${songListId}`)


// =======================> 评论 API
// 添加评论
export const setComment = (params) => post(`comment/add`, params)
// 点赞
export const setLike = (params) => post(`comment/like`, params)
// 返回所有评论
export const getAllComment = (type, id) => {
  let url = ''
  if (type === 1) {
    url = `comment/selectBySongListId?songListId=${id}`
  } else if (type === 0) {
    url = `comment/selectBySongId/detail?songId=${id}`
  }
  return get(url)
}


// =======================> 歌曲 API
// 返回所有歌曲
export const getAllSong = () => get(`song/allSong`)
// 返回指定歌手ID的歌曲
export const getSongOfSingerId = (id) => get(`song/singer/detail?singerId=${id}`)
// 返回的指定歌曲ID查询歌曲
export const getSongOfId = (id) => get(`song/detail?id=${id}`)
// 返回指定精确歌手名的歌曲
export const getSongOfSingerName = (id) => get(`song/songOfSingerName?singerName=${id}`)
// 返回指定模糊歌手名的歌曲
export const getSongLikeSingerName = (id) => get(`song/selectLikeName?singerName=${id}`)
// 返回指定歌曲名的歌曲
export const getSongOfSongName = (id) => get(`song/songName/detail?songName=${id}`)
// 更新歌曲信息
export const updateSongMsg = (params) => post(`song/update`, params)
// 删除歌曲
export const deleteSong = (id) => get(`song/delete?id=${id}`)
// 下载音乐
export const download = (url) => axios({
  method: 'get',
  url: url,
  responseType: 'blob'
})
// =======================> 歌单歌曲 API
// 给歌单添加歌曲
export const setListSong = (params) => post(`listSong/add`, params)
// 返回歌单里指定歌单ID的歌曲
export const getListSongOfSongId = (songListId) => get(`listSong/selectBySongListId?songListId=${songListId}`)
// 删除歌单里的歌曲
// export const deleteListSong = (songId) => get(`listSong/delete?songId=${songId}`)
// 删除歌单里的歌曲
export const deleteListSong = (songId,songListId) => get(`listSong/delete?songId=${songId}&songListId=${songListId}`)
// 获取全部歌单歌曲
export const getListSong = () => get(`listSong/allListSong`)
