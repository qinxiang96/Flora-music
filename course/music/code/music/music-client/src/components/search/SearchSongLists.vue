<template>
  <div class="search-song-Lists">
    <content-list :contentList="albumDatas"></content-list>
  </div>
</template>

<script>
import ContentList from '../ContentList'
import { getSongListOfLikeTitle } from '../../api/index'

export default {
  name: 'search-song-Lists',
  components: {
    ContentList
  },
  data () {
    return {
      albumDatas: []
    }
  },
  mounted () {
    this.getSearchList()
  },
  methods: {
    getSearchList () {
      if (!this.$route.query.keywords) {
        this.notify('The input content is empty', 'warning')
      } else if (this.$route.query.keywords) {
        getSongListOfLikeTitle(this.$route.query.keywords)
          .then(res => {
            this.albumDatas = res
          })
      } else {
        this.notify('There is no song content', 'error')
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../../assets/css/search-song-Lists.scss';
</style>
