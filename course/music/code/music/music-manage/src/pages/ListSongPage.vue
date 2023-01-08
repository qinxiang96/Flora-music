<template>
  <div class="table">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-tickets"></i> ListSong Info
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    <div class="container">
      <div class="handle-box">
        <el-button type="primary" size="mini" class="handle-del mr10" @click="delAll">Batch Delete</el-button>
        <el-input v-model="select_word" size="mini" placeholder="select song" class="handle-input mr10"></el-input>
        <el-button type="primary" size="mini" @click="centerDialogVisible = true">Add Song</el-button>
      </div>
      <el-table
        :data="tableData"
        border
        size="mini"
        style="width: 100%"
        ref="multipleTable"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="50"></el-table-column>
        <el-table-column prop="name" label="singer-song"></el-table-column>
        <el-table-column label="option" width="80">
          <template slot-scope="scope">
            <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">del</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!--添加歌曲-->
    <el-dialog title="Add Song" :visible.sync="centerDialogVisible" width="400px" center>
      <el-form
        :model="registerForm"
        status-icon
        ref="registerForm"
        label-width="100px"
        class="demo-ruleForm"
      >
        <el-form-item prop="singerName" label="singer name" size="mini">
          <el-input v-model="registerForm.singerName" placeholder="singer name"></el-input>
        </el-form-item>
        <el-form-item prop="songName" label="song name" size="mini">
          <el-input v-model="registerForm.songName" placeholder="song name"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="centerDialogVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="getSongId">submit</el-button>
      </span>
    </el-dialog>

    <!-- 删除提示框 -->
    <el-dialog title="Tips" :visible.sync="delVisible" width="300px" center>
      <div class="del-dialog-cnt" align="center">no recover, are you sure to delete？</div>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="delVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="deleteRow">submit</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mixin } from '../mixins'
import { setListSong, getListSongOfSongId, deleteListSong, getSongOfId, getSongOfSongName } from '../api/index'

export default {
  mixins: [mixin],
  data () {
    return {
      registerForm: {
        singerName: '',
        songName: ''
      },
      tableData: [],
      tempDate: [],
      multipleSelection: [],
      songListId: '', // 歌单Id
      centerDialogVisible: false,
      delVisible: false,
      select_word: '',
      idx: -1
    }
  },
  watch: {
    select_word: function () {
      if (this.select_word === '') {
        this.tableData = this.tempDate
      } else {
        this.tableData = []
        for (let item of this.tempDate) {
          if (item.name.includes(this.select_word)) {
            this.tableData.push(item)
          }
        }
      }
    }
  },
  created () {
    this.songListId = this.$route.query.id
    this.getData()
  },
  methods: {
    // 获取歌单
    getData () {
      this.tableData = []
      this.tempDate = []
      getListSongOfSongId(this.songListId)
        .then(res => {
          console.log(res)
          for (let item of res) {
            this.getSong(item.songId)
          }
        })
        .catch(err => {
          console.log(err)
        })
    },
    // 获取歌单里对应的音乐
    getSong (id) {
      getSongOfId(id)
        .then(res => {
          this.tableData.push(res)
          this.tempDate.push(res)
        })
        .catch(err => {
          console.log(err)
        })
    },
    // 获取要添加歌曲的ID
    getSongId () {
      let _this = this
      var id = _this.registerForm.singerName + '-' + _this.registerForm.songName
      getSongOfSongName(id)
        .then(res => {
          this.addSong(res[0].id)
        })
    },
    // 添加歌曲
    addSong (id) {
      let params = new URLSearchParams()
      params.append('songId', id)
      params.append('songListId', this.songListId)
      setListSong(params)
        .then(res => {
          if (res.code === 1) {
            this.getData()
            this.notify('add successfully', 'success')
          } else {
            this.notify('add failed', 'error')
          }
        })
        .catch(err => {
          console.log(err)
        })
      this.centerDialogVisible = false
    },
    // 确定删除
    deleteRow () {
      deleteListSong(this.idx, this.songListId)
        .then(res => {
          if (res) {
            this.getData()
            this.notify('delete successfully', 'success')
          } else {
            this.notify('delete failed', 'error')
          }
        })
        .catch(err => {
          console.log(err)
        })
      this.delVisible = false
    }
  }
}
</script>

<style scoped>
.handle-box {
  margin-bottom: 20px;
}

.handle-input {
  width: 300px;
  display: inline-block;
}
</style>
