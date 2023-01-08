import { getSongLikeSingerName, getCollectionOfUser } from '../api/index'
import { mapGetters } from 'vuex'

export const mixin = {
  computed: {
    ...mapGetters([
      'userId',
      'loginIn'
    ])
  },
  methods: {
    // 提示信息
    notify (title, type) {
      this.$notify({
        title: title,
        type: type
      })
    },
    // 获取图片信息
    attachImageUrl (srcUrl) {
      return srcUrl ? this.$store.state.configure.HOST + srcUrl || '../assets/img/user.jpg' : ''
    },
    attachBirth (val) {
      let birth = String(val).match(/[0-9-]+(?=\s)/)
      return Array.isArray(birth) ? birth[0] : birth
    },
    // 得到名字后部分
    replaceFName (str) {
      let arr = str.split('-')
      return arr[1]
    },
    // 得到名字前部分
    replaceLName (str) {
      let arr = str.split('-')
      return arr[0]
    },
    // 播放
    toplay: function (id, url, pic, index, name, lyric) {
      this.$store.commit('setId', id)
      this.$store.commit('setListIndex', index)
      this.$store.commit('setUrl', this.$store.state.configure.HOST + url)
      this.$store.commit('setpicUrl', this.$store.state.configure.HOST + pic)
      this.$store.commit('setTitle', this.replaceFName(name))
      this.$store.commit('setArtist', this.replaceLName(name))
      this.$store.commit('setLyric', this.parseLyric(lyric))
      //设置前段显示的收藏状态
      if (this.loginIn) {
        this.$store.commit('setIsActive', false)
        getCollectionOfUser(this.userId)
          .then(res => {
            for (let item of res) {
              if (item.songId === id) {
                this.$store.commit('setIsActive', true)
                break
              }
            }
          })
          .catch(err => {
            console.log(err)
          })
      }
    },
    // 解析歌词
    parseLyric (text) {
      let lines = text.split('\n')
      // /\ 正则表达式开始的标志 d表示数字 {2}表示2个 \d{3}|\d{2} 2个或3个数字的格式
      let pattern = /\[\d{2}:\d{2}.(\d{3}|\d{2})\]/g
      let result = []

      // 对于歌词格式不对的特殊处理 / /两个斜杠中间的是正则表达式
      if (!(/\[.+\]/.test(text))) {
        return [[0, text]]
      }
      //去掉前面格式不正确的行，从下一行读取
      while (!pattern.test(lines[0])) {
        lines = lines.slice(1)
      }

      lines[lines.length - 1].length === 0 && lines.pop()
      for (let item of lines) {
        let time = item.match(pattern) // 存前面的时间段
        let value = item.replace(pattern, '') // 存歌词
        // console.log(time) // 时间
        // console.log(value) // 歌词数据
        for (let item1 of time) {
          // slice(从第几个开始取,取到第几个) -1是倒数第一个
          let t = item1.slice(1, -1).split(':')
          if (value !== '') {
            //将时间和歌词value放进结果中
            result.push([parseInt(t[0], 10) * 60 + parseFloat(t[1]), value])
          }
        }
      }
      //按照第一个元素时间进行排序 谁小谁在前面
      result.sort(function (a, b) {
        return a[0] - b[0]
      })
      return result
    },
    // 搜索音乐
    getSong () {
      if (!this.$route.query.keywords) {
        this.$store.commit('setListOfSongs', [])
        this.notify('The content is empty', 'warning')
      } else {
        getSongLikeSingerName(this.$route.query.keywords)
          .then(res => {
            if (!res.length) {
              this.$store.commit('setListOfSongs', [])
              this.notify('The system does not have the song', 'warning')
            } else {
              this.$store.commit('setListOfSongs', res)
            }
          })
          .catch(err => {
            console.log(err)
          })
      }
    }
  }
}
