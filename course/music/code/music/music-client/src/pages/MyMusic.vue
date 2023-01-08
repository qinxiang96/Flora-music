<template>
  <div class="my-music">
    <div class="album-slide">
      <div class="album-img">
        <img :src=attachImageUrl(avator) alt="">
      </div>
      <ul class="album-info">
        <li>Name: {{username}}</li>
        <li>Gender: {{userSex}}</li>
        <li>Birth: {{birth}}</li>
        <li>Location: {{location}}</li>
      </ul>
    </div>
    <div class="album-content">
      <div class="album-title">Introduction: {{introduction}}</div>
      <div class="songs-body">
        <album-content :songList="collectList">
          <template slot="title">My Collection</template>
        </album-content>
      </div>
    </div>
  </div>
</template>

<script>
import {mixin} from '../mixins'
import { mapGetters } from 'vuex'
import AlbumContent from '../components/AlbumContent'
import { getCollectionOfUser, getUserOfId, getSongOfId } from '../api/index'

export default {
  name: 'my-music',
  //存放页面组件
  components: {
    AlbumContent
  },
  mixins: [mixin],
  //显示到页面的数据
  data () {
    return {
      avator: '',
      username: '',
      userSex: '',
      birth: '',
      location: '',
      introduction: '',
      collection: [], // 存放收藏的歌曲ID
      collectList: [] // 收藏的歌曲
    }
  },
  //监控缓存里的数据
  computed: {
    ...mapGetters([
      'userId',
      'id',
      'listOfSongs' // 存放的音乐
    ])
  },
  //页面加载完成后执行方法
  mounted () {
    this.getMsg(this.userId)
    this.getCollection(this.userId)
  },
  methods: {
    getMsg (id) {
      getUserOfId(id)
        .then(res => {
          this.username = res.username
          this.getuserSex(res.sex)
          this.birth = this.attachBirth(res.birth)
          this.introduction = res.introduction
          this.location = res.location
          this.avator = res.avator
        })
        .catch(err => {
          console.log(err)
        })
    },
    getuserSex (sex) {
      if (sex === 0) {
        this.userSex = 'female'
      } else if (sex === 1) {
        this.userSex = 'male'
      }
    },
    // 收藏的歌曲ID
    getCollection (userId) {
      getCollectionOfUser(userId)
        .then(res => {
          this.collection = res
          // 通过歌曲ID获取歌曲信息
          for (let item of this.collection) {
            this.getCollectSongs(item.songId)
          }
          this.$store.commit('setListOfSongs', this.collectList)
        })
        .catch(err => {
          console.log(err)
        })
    },
    // 获取收藏的歌曲
    getCollectSongs (id) {
      getSongOfId(id)
        .then(res => {
          this.collectList.push(res)
        })
        .catch(err => {
          console.log(err)
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/my-music.scss';
</style>
