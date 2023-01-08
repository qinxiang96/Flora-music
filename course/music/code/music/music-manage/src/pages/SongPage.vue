<template>
  <div class="table">
    <div class="crumbs">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>
          <i class="el-icon-tickets"></i> Song Info
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    <div class="container">
      <div class="handle-box">
        <el-button type="primary" size="mini" class="handle-del mr10" @click="delAll">Batch Delete</el-button>
        <el-input v-model="select_word" size="mini" placeholder="select song" class="handle-input mr10"></el-input>
        <el-button type="primary" size="mini" @click="centerDialogVisible = true">Add Song</el-button>
      </div>
      <el-table :data="data" size="mini" border style="width: 100%" ref="multipleTable" height="550px" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="40"></el-table-column>
        <el-table-column label="pic" width="110" align="center">
          <template slot-scope="scope">
            <div style="width: 80px; height: 80px; overflow: hidden">
              <img :src="getUrl(scope.row.pic)" alt="" style="width: 100%;"/>
            </div>
            <div class="play" @click="setSongUrl(scope.row.url, scope.row.name)">
              <div v-if="toggle !== scope.row.name">
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-bofanganniu"></use>
                </svg>
              </div>
              <div v-if="toggle === scope.row.name">
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-zanting"></use>
                </svg>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="name" prop="name" width="150" align="center"></el-table-column>
        <el-table-column label="introduction" prop="introduction" width="150" align="center"></el-table-column>
        <el-table-column label="lyric" align="center">
          <template slot-scope="scope">
            <ul style="height: 100px; overflow: scroll">
              <!-- <li> -->
              <li v-for="(item, index) in parseLyric(scope.row.lyric)" :key="index">
                {{ item}}
              </li>
            </ul>
          </template>
        </el-table-column>
        <el-table-column label="update" width="100" align="center">
          <template slot-scope="scope">
            <el-upload
              class="upload-demo"
              :action="uploadUrl(scope.row.id)"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload"
              >
                <el-button size="mini">pic</el-button>
            </el-upload>
            <br>
            <el-upload
              class="upload-demo change"
              :action="uploadSongUrl(scope.row.id)"
              :show-file-list="false"
              :on-success="handleSongSuccess"
              :before-upload="beforeSongUpload">
              <el-button size="mini">song</el-button>
            </el-upload>
          </template>
        </el-table-column>
        <el-table-column label="comment" width="120" align="center">
            <template  slot-scope="scope">
                <el-button size="mini" @click="getComment(data[scope.$index].id)">comment</el-button>
            </template>
        </el-table-column>
        <el-table-column label="option" width="150" align="center">
            <template slot-scope="scope">
                <el-button size="mini" @click="handleEdit(scope.row)">edit</el-button>
                <el-button size="mini" type="danger" @click="handleDelete(scope.row.id)">del</el-button>
            </template>
        </el-table-column>
      </el-table>
      <div class="pagination">
        <el-pagination
          @current-change="handleCurrentChange"
          background
          layout="total, prev, pager, next"
          :current-page="currentPage"
          :page-size="pageSize"
          :total="tableData.length">
        </el-pagination>
      </div>
    </div>

    <!--添加歌曲-->
    <el-dialog title="Add Song" :visible.sync="centerDialogVisible" width="400px" center>
      <el-form action="" :model="registerForm" id="tf">
        <div>
          <label>name</label>
          <el-input type="text" name="name"></el-input>
        </div>
        <div>
          <label>introduction</label>
          <el-input type="text" value="" name="introduction"></el-input>
        </div>
        <div>
          <label>lyric</label>
          <el-input type="textarea" value="" name="lyric"></el-input>
        </div>
        <div>
          <label>upload song</label>
          <br>
          <input type="file" name="file" id="upadte-file-input">
        </div>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="centerDialogVisible = false">cancel</el-button>
        <el-button type="primary" @click="addSong">submit</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹出框 -->
    <el-dialog title="Edit" :visible.sync="editVisible" width="400px">
      <el-form ref="form" :model="form" label-width="100px">
        <el-form-item label="singer-song" size="mini">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="introduction" size="mini">
          <el-input v-model="form.introduction"></el-input>
        </el-form-item>
        <el-form-item label="lyric" size="mini">
          <el-input  type="textarea" v-model="form.lyric"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="editVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="saveEdit">submit</el-button>
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
import SongAudio from '../components/SongAudio'
import { mixin } from '../mixins'
import { mapGetters } from 'vuex'
import '@/assets/js/iconfont.js'
import { getSongOfSingerId, updateSongMsg, deleteSong } from '../api/index'

export default {
  name: 'song-page',
  components: {
    SongAudio
  },
  mixins: [mixin],
  data () {
    return {
      toggle: false, // 控制播放图标状态
      singerId: '',
      singerName: '',
      registerForm: {
        name: '',
        singerName: '',
        introduction: '',
        lyric: ''
      },
      tableData: [],
      tempDate: [],
      is_search: false,
      multipleSelection: [], // 记录要删除的歌曲
      centerDialogVisible: false,
      editVisible: false,
      delVisible: false,
      select_word: '',
      form: {
        id: '',
        singerId: '',
        name: '',
        introduction: '',
        createTime: '',
        updateTime: '',
        pic: '',
        lyric: '',
        url: ''
      },
      pageSize: 5, // 页数
      currentPage: 1, // 当前页
      idx: -1
    }
  },
  computed: {
    ...mapGetters([
      'isPlay' // 播放状态
    ]),
    // 计算当前表格中的数据
    data () {
      return this.tableData.slice((this.currentPage - 1) * this.pageSize, this.currentPage * this.pageSize)
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
    this.singerId = this.$route.query.id
    this.singerName = this.$route.query.name
    this.getData()
  },
  destroyed () {
    this.$store.commit('setIsPlay', false)
  },
  methods: {
    // 获取歌曲
    getData () {
      this.tableData = []
      this.tempDate = []
      getSongOfSingerId(this.singerId).then((res) => {
        console.log('歌手作品===========>', res)
        this.tableData = res
        this.tempDate = res
        this.currentPage = 1
      }).catch(err => {
        console.log(err)
      })
    },
    setSongUrl (url, name) {
      this.$store.commit('setUrl', this.$store.state.HOST + url)
      this.toggle = name
      if (this.isPlay) {
        this.$store.commit('setIsPlay', false)
      } else {
        this.$store.commit('setIsPlay', true)
      }
    },
    // 更新歌曲图片
    uploadUrl (id) {
      return `${this.$store.state.HOST}/song/updateSongPic?id=${id}`
    },
    // 更新歌曲url
    uploadSongUrl (id) {
      return `${this.$store.state.HOST}/song/updateSongUrl?id=${id}`
    },
    beforeSongUpload (file) {
      var testmsg = file.name.substring(file.name.lastIndexOf('.') + 1)
      const extension = testmsg === 'mp3'
      if (!extension) {
        this.$message({
          message: 'the type of upload file must be mp3！',
          type: 'error'
        })
      }
      return extension
    },
    // 获取当前页
    handleCurrentChange (val) {
      this.currentPage = val
    },
    handleSongSuccess (res, file) {
      if (res.code === 1) {
        this.getData()
        this.notify('upload successfully', 'success')
      } else {
        this.notify('upload failed', 'error')
      }
    },
    // 添加音乐
    addSong () {
      let _this = this
      var form = new FormData(document.getElementById('tf'))
      form.append('singerId', this.singerId)
      form.set('name', this.singerName + '-' + form.get('name'))
      if (!form.get('lyric')) {
        form.set('lyric', '[00:00:00]暂无歌词')
      }
      var req = new XMLHttpRequest()
      req.onreadystatechange = function () {
        // 获取到完整的数据且和后台正常交互完成
        if (req.readyState === 4 && req.status === 200) {
          let res = JSON.parse(req.response)
          if (res.code) {
            _this.getData()
            _this.registerForm = {}
            _this.notify(res.msg, 'success')
          } else if (!res.code) {
            _this.notify('upload failed', 'error')
          }
        }
      }
      req.open('post', `${_this.$store.state.HOST}/song/add`, false)
      req.send(form)
      _this.centerDialogVisible = false
    },
    // 编辑
    handleEdit (row) {
      this.idx = row.id
      this.form = {
        id: row.id,
        singerId: row.singerId,
        name: row.name,
        introduction: row.introduction,
        createTime: row.createTime,
        updateTime: row.updateTime,
        pic: row.pic,
        lyric: row.lyric,
        url: row.url
      }
      this.editVisible = true
    },
    getComment (id) {
      this.$router.push({path: '/Comment', query: {id: id, type: 0}})
    },
    // 保存编辑
    saveEdit () {
      let params = new URLSearchParams()
      params.append('id', this.form.id)
      params.append('singerId', this.form.singerId)
      params.append('name', this.form.name)
      params.append('introduction', this.form.introduction)
      params.append('lyric', this.form.lyric)
      updateSongMsg(params)
        .then(res => {
          if (res) {
            this.getData()
            this.notify('edit successfully', 'success')
          } else {
            this.notify('edit failed', 'error')
          }
        })
        .catch(err => {
          console.log(err)
        })
      this.editVisible = false
    },
    // 确定删除
    deleteRow () {
      deleteSong(this.idx)
        .then(response => {
          if (response) {
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
    },
    // 解析歌词
    parseLyric (text) {
      let lines = text.split('\n')
      let pattern = /\[\d{2}:\d{2}.(\d{3}|\d{2})\]/g
      let result = []

      // 对于歌词格式不对的特殊处理
      if (!(/\[.+\]/.test(text))) {
        return [text]
      }
      for (let item of lines) {
        if (pattern.test(item)) {
          let value = item.replace(pattern, '') // 存歌词
          result.push(value)
        }
      }
      return result
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
.el-input__inner{
  background-color: aqua
}
.play {
    position: absolute;
    z-index: 100;
    width: 80px;
    height: 80px;
    top: 18px;
    left: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}
.icon {
  width: 2em;
  height: 2em;
  color: white;
  fill: currentColor;
  overflow: hidden;
}
.pagination {
    display: flex;
    justify-content: center;
}
</style>
