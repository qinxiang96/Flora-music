<template>
  <div class="singer-album">
    <div class="album-slide">
      <div class="singer-img">
        <img :src="attachImageUrl(singer.pic)" alt="">
      </div>
      <ul class="info">
        <li v-if="singer.sex !== 2">Gender: {{attachSex(singer.sex)}}</li>
        <li>Birth: {{attachBirth(singer.birth)}}</li>
        <li>Location: {{singer.location}}</li>
      </ul>
    </div>
    <div class="album-content">
      <div class="intro">
        <h2>{{singer.name}}</h2>
        <span>{{singer.introduction}}</span>
      </div>
      <div class="content">
        <album-content :songList="listOfSongs">
          <template slot="title">Song List</template>
        </album-content>
      </div>
    </div>
  </div>
</template>

<script>
import { mixin } from '../mixins'
import { mapGetters } from 'vuex'
import AlbumContent from '../components/AlbumContent'
import { getSongOfSingerId } from '../api/index'

export default {
  name: 'singer-album',
  components: {
    AlbumContent
  },
  mixins: [mixin],
  data () {
    return {
      singerId: '',
      singer: {}
    }
  },
  computed: {
    ...mapGetters([
      'tempList',
      'listOfSongs'
    ])
  },
  mounted () {
    this.singerId = this.$route.params.id // 给歌单ID赋值
    this.singer = this.tempList
    this.getSongList()
  },
  methods: {
    getSongList () {
      getSongOfSingerId(this.singerId)
        .then(res => {
          this.$store.commit('setListOfSongs', res)
        })
        .catch(err => {
          console.log(err)
        })
    },
    attachSex (value) {
      if (value === 0) {
        return 'female'
      } else if (value === 1) {
        return 'male'
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/singer-album.scss';
</style>
