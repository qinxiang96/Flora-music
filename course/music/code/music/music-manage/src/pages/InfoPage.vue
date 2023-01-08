<template>
  <div>
    <el-row :gutter="20" class="mgb20">
      <el-col :span="6">
        <el-card shadow="hover" :body-style="{padding: '0px'}">
          <div class="grid-content grid-con-1">
            <div class="grid-cont-right">
              <div class="grid-num">{{userCount}}</div>
              <div>total consumer</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" :body-style="{padding: '0px'}">
          <div class="grid-content grid-con-2">
            <div class="grid-cont-right">
              <div class="grid-num">{{songCount}}</div>
              <div>total song</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" :body-style="{padding: '0px'}">
          <div class="grid-content grid-con-3">
            <div class="grid-cont-right">
              <div class="grid-num">{{singerCount}}</div>
              <div>total singer</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" :body-style="{padding: '0px'}">
          <div class="grid-content grid-con-4">
            <div class="grid-cont-right">
              <div class="grid-num">{{songListCount}}</div>
              <div>total song_list</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="12">
        <h3 style="margin-bottom: 20px">Gender radio of consumer</h3>
        <div  style="background-color: white">
          <ve-pie :data="userSex" :theme="options"></ve-pie>
        </div>
      </el-col>
      <el-col :span="12">
        <h3 style="margin-bottom: 20px">Distrubution of song type</h3>
        <div  style="background-color: white">
          <ve-histogram :data="songStyle" :theme="options3"></ve-histogram>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="12">
        <h3 style="margin: 20px 0">Gender radio of singer</h3>
        <div  style="background-color: white">
          <ve-pie :data="singerSex" :theme="options1"></ve-pie>
        </div>
      </el-col>
      <el-col :span="12">
        <h3 style="margin: 20px 0">Distrubution of singer nation</h3>
        <div  style="background-color: white">
          <ve-histogram :data="country" :theme="options2"></ve-histogram>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mixin } from '../mixins'
import { getAllSinger, getSongList, getAllSong, getAllUser } from '../api/index'

export default {
  mixins: [mixin],
  data () {
    return {
      user: [],
      userSex: {
        columns: ['sex', 'total'],
        rows: [
          { 'sex': 'male', 'total': 0 },
          { 'sex': 'female', 'total': 0 }
        ]
      },
      singerSex: {
        columns: ['sex', 'total'],
        rows: [
          { 'sex': 'male', 'total': 0 },
          { 'sex': 'female', 'total': 0 }
        ]
      },
      country: {
        columns: ['nation', 'total'],
        rows: [
          { 'nation': '中国', 'total': 0 },
          { 'nation': '韩国', 'total': 0 },
          { 'nation': '意大利', 'total': 0 },
          { 'nation': '新加坡', 'total': 0 },
          { 'nation': '美国', 'total': 0 },
          { 'nation': '马来西亚', 'total': 0 },
          { 'nation': '西班牙', 'total': 0 },
          { 'nation': '日本', 'total': 0 }
        ]
      },
      options: {
        color: ['#87CEFA', '#FFC0CB']
      },
      options1: {
        color: ['#1E90FF', '#7B68EE']
      },
      options2: {
        color: ['#FEED78'],
        tooltip: {
          trigger: 'axis',
          axisPointer: { // 坐标轴指示器，坐标轴触发有效
            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        }
      },
      options3: {
        color: ['#FD8A61'],
        tooltip: {
          trigger: 'axis',
          axisPointer: { // 坐标轴指示器，坐标轴触发有效
            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        }
      },
      songStyle: {
        columns: ['style', 'total'],
        rows: [
          { 'style': '华语', 'total': 0 },
          { 'style': '粤语', 'total': 0 },
          { 'style': '欧美', 'total': 0 },
          { 'style': '日韩', 'total': 0 },
          { 'style': 'BGM', 'total': 0 },
          { 'style': '轻音乐', 'total': 0 },
          { 'style': '乐器', 'total': 0 }
        ]
      },
      userCount: 0,
      songCount: 0,
      singerCount: 0,
      songListCount: 0
    }
  },
  mounted () {
    this.getUser()
    this.getSinger()
    this.getSong()
    this.getSongList()
  },
  methods: {
    getUser () {
      getAllUser().then(res => {
        this.userCount = res.length
        this.userSex.rows[0]['total'] = this.setSex(1, res)
        this.userSex.rows[1]['total'] = this.setSex(0, res)
      })
    },
    setSex (sex, arr) {
      let count = 0
      for (let item of arr) {
        if (sex === item.sex) {
          count++
        }
      }
      return count
    },
    getCountry (val) {
      for (let item of this.country.rows) {
        if (val.includes(item['nation'])) {
          item['total']++
          break
        }
      }
    },
    getStyle (val) {
      for (let item of this.songStyle.rows) {
        if (val.includes(item['style'])) {
          item['total']++
        }
      }
    },
    getSinger () {
      getAllSinger().then(res => {
        this.singerCount = res.length
        this.singerSex.rows[0]['total'] = this.setSex(1, res)
        this.singerSex.rows[1]['total'] = this.setSex(0, res)
        for (let item of res) {
          this.getCountry(item.location)
        }
      }).catch(err => {
        console.log(err)
      })
    },
    getSong () {
      getAllSong().then(res => {
        this.songCount = res.length
      }).catch(err => {
        console.log(err)
      })
    },
    getSongList () {
      getSongList().then(res => {
        this.songListCount = res.length
        for (let item of res) {
          this.getStyle(item.style)
        }
      }).catch(err => {
        console.log(err)
      })
    }
  }
}
</script>

<style>
  .grid-content {
    display: flex;
    align-items: center;
    height: 100px;
  }

  .grid-cont-right {
    flex: 1;
    text-align: center;
    font-size: 14px;
    color: #999;
  }

  .grid-num {
    font-size: 30px;
    font-weight: bold;
  }
</style>
