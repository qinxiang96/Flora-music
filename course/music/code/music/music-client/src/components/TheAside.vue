<template>
  <transition name="slide-fade">
    <div class="the-aside" v-if="showAside">
      <h2 class="title">Play List</h2>
      <ul class="menus">
        <li v-for="(item, index) in listOfSongs" :class="{'is-play': id === item.id}" :key="index" @click="toplay(item.id, item.url, item.pic, index, item.name, item.lyric)">
          {{replaceFName(item.name)}}
        </li>
      </ul>
    </div>
  </transition>
</template>

<script>
import { mixin } from '../mixins'
import { mapGetters } from 'vuex'

export default {
  name: 'the-aside',
  mixins: [mixin],
  computed: {
    ...mapGetters([
      'id', // 音乐id
      'listOfSongs', // 当前歌单列表
      'showAside' // 是否显示侧边栏
    ])
  },
  //监控 当点击任意位置时 隐藏play list侧边栏
  mounted () {
    //因为这个this不在document里面，所以需要重新赋值后取值
    let _this = this
    document.addEventListener('click', function () {
      _this.$store.commit('setShowAside', false)
    }, true)
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/the-aside.scss';
</style>
