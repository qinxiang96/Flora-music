<template>
  <div class="table">
    <div class="container">
      <div class="handle-box">
        <el-button type="primary" size="mini" class="handle-del mr10" @click="delAll">Batch Delete</el-button>
        <el-input v-model="select_word" size="mini" placeholder="select songList" class="handle-input mr10"></el-input>
        <el-button type="primary" size="mini" @click="centerDialogVisible = true">Add SongList</el-button>
      </div>
      <el-table :data="data" border size="mini" style="width: 100%" height="550px" ref="multipleTable" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="40"></el-table-column>
        <el-table-column label="pic" width="100" align="center">
          <template slot-scope="scope">
            <img :src="getUrl(scope.row.pic)" alt="" style="width: 80px;"/>
              <el-upload
                class="upload-demo"
                :action="uploadUrl(scope.row.id)"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload"
                >
                <el-button size="mini">update pic</el-button>
              </el-upload>
          </template>
        </el-table-column>
        <el-table-column prop="title" label="title" width="200" align="center"></el-table-column>
        <el-table-column label="introduction">
          <template slot-scope="scope">
            <p style="height: 100px; overflow: scroll">{{ scope.row.introduction }}</p>
          </template>
        </el-table-column>
        <el-table-column label="style" width="100" align="center">
          <template slot-scope="scope">
            <div>{{ scope.row.style }}</div>
          </template>
        </el-table-column>
        <el-table-column label="content" width="100" align="center">
          <template  slot-scope="scope">
            <el-button size="mini" @click="getContent(data[scope.$index].id)">content</el-button>
          </template>
        </el-table-column>
        <el-table-column label="comment" width="110" align="center">
          <template  slot-scope="scope">
            <el-button size="mini" @click="getComment(data[scope.$index].id)">comment</el-button>
          </template>
        </el-table-column>
        <el-table-column label="option" width="150" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="handleEdit(scope.row)">edit
            </el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.row.id)">del
            </el-button>
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

    <!--添加歌单-->
    <el-dialog title="Add SongList" :visible.sync="centerDialogVisible" width="400px" center>
      <el-form :model="registerForm" status-icon ref="registerForm" label-width="80px" class="demo-ruleForm">
          <el-form-item label="title" prop="title" size="mini">
            <el-input v-model="registerForm.title" placeholder="title"></el-input>
          </el-form-item>
          <el-form-item label="introduction" prop="introduction" size="mini">
            <el-input v-model="registerForm.introduction" placeholder="introduction"></el-input>
          </el-form-item>
          <el-form-item label="style" prop="style" size="mini">
            <el-input v-model="registerForm.style" placeholder="style"></el-input>
          </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="centerDialogVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="addsongList">submit</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹出框 -->
    <el-dialog title="Edit" :visible.sync="editVisible" width="400px">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="title" size="mini">
          <el-input v-model="form.title"></el-input>
        </el-form-item>
        <el-form-item label="introduction" size="mini">
          <el-input  type="textarea" v-model="form.introduction"></el-input>
        </el-form-item>
        <el-form-item label="style" size="mini">
          <el-input v-model="form.style"></el-input>
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
import { mixin } from '../mixins'
import { setSongList, getSongList, updateSongListMsg, deleteSongList } from '../api/index'

export default {
  name: 'song-list-page',
  mixins: [mixin],
  data () {
    return {
      registerForm: {
        title: '',
        introduction: '',
        style: ''
      },
      tableData: [],
      tempDate: [],
      multipleSelection: [], // 记录要删除的歌单
      centerDialogVisible: false,
      editVisible: false,
      delVisible: false,
      select_word: '',
      form: {
        id: '',
        title: '',
        pic: '',
        introduction: '',
        style: ''
      },
      pageSize: 5, // 页数
      currentPage: 1, // 当前页
      idx: -1
    }
  },
  computed: {
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
          if (item.title.includes(this.select_word)) {
            this.tableData.push(item)
          }
        }
      }
    }
  },
  created () {
    this.getData()
  },
  methods: {
    uploadUrl (id) {
      return `${this.$store.state.HOST}/songList/updateSongListPic?id=${id}`
    },
    // 获取歌单信息
    getData () {
      this.tableData = []
      this.tempDate = []
      getSongList().then((res) => {
        this.tableData = res
        this.tempDate = res
        this.currentPage = 1
      })
    },
    // 获取当前页
    handleCurrentChange (val) {
      this.currentPage = val
    },
    getContent (id) {
      this.$router.push({path: '/listSong', query: {id: id}})
    },
    getComment (id) {
      this.$router.push({path: '/Comment', query: {id: id, type: 1}})
    },
    // 编辑啊
    handleEdit (row) {
      this.idx = row.id
      this.form = {
        id: row.id,
        title: row.title,
        pic: row.pic,
        introduction: row.introduction,
        style: row.style
      }
      this.editVisible = true
    },
    // 保存编辑
    saveEdit () {
      let params = new URLSearchParams()
      params.append('id', this.form.id)
      params.append('title', this.form.title)
      params.append('pic', this.form.pic)
      params.append('introduction', this.form.introduction)
      params.append('style', this.form.style)
      updateSongListMsg(params)
        .then(res => {
          if (res.code === 1) {
            this.notify('edit successfully', 'success')
            this.getData()
          } else {
            this.notify('edit failed', 'error')
          }
        })
        .catch(err => {
          console.log(err)
        })
      this.editVisible = false
    },
    // 添加歌单
    addsongList () {
      let params = new URLSearchParams()
      params.append('title', this.registerForm.title)
      params.append('pic', '/img/songListPic/123.jpg')
      params.append('introduction', this.registerForm.introduction)
      params.append('style', this.registerForm.style)
      setSongList(params).then(res => {
        if (res.code === 1) {
          this.getData()
          this.registerForm = {}
          this.notify('add successfully', 'success')
        } else {
          this.notify('add failed', 'error')
        }
      }).catch(err => {
        console.log(err)
      })
      this.centerDialogVisible = false
    },
    // 确定删除
    deleteRow () {
      deleteSongList(this.idx)
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
.pagination {
    display: flex;
    justify-content: center;
}
</style>
