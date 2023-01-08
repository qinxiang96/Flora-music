<template>
  <div class="table">
    <div class="container">
      <div class="handle-box">
        <el-button type="primary" size="mini" class="handle-del mr10" @click="delAllVisible = true">Batch Delete</el-button>
        <el-input v-model="select_word" size="mini" placeholder="select keyword" class="handle-input mr10"></el-input>
        <el-button type="primary" size="mini" @click="centerDialogVisible = true">Add Singer</el-button>
      </div>
      <el-table ref="multipleTable" size="mini" border style="width: 100%" height="550px" :data="data" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="40"></el-table-column>
        <el-table-column label="pic" width="110" align="center">
          <template slot-scope="scope">
            <div class="singer-img">
              <img :src="getUrl(scope.row.pic)" alt="" style="width: 100%;"/>
            </div>
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
        <el-table-column prop="name" label="name" width="120" align="center"></el-table-column>
        <el-table-column label="sex" width="50" align="center">
          <template slot-scope="scope">
            <div>{{changeSex(scope.row.sex) }}</div>
          </template>
        </el-table-column>
        <el-table-column label="birth" width="120" align="center">
          <template slot-scope="scope">
              <div>{{attachBirth(scope.row.birth) }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="location" label="location" width="100" align="center"></el-table-column>
        <el-table-column label="introduction">
          <template slot-scope="scope">
            <p style="height: 100px; overflow: scroll">{{ scope.row.introduction }}</p>
          </template>
        </el-table-column>
        <el-table-column label="management" width="110" align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="songEdit(scope.row.id, scope.row.name)">song</el-button>
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

    <el-dialog title="Add Singer" :visible.sync="centerDialogVisible" width="500px" center>
      <el-form
        :model="registerForm"
        status-icon
        ref="registerForm"
        label-width="80px"
        class="demo-ruleForm"
        >
        <el-form-item prop="name" label="name" size="mini">
          <el-input v-model="registerForm.name" placeholder="singer name"></el-input>
        </el-form-item>
        <el-form-item label="sex" size="mini">
          <el-radio-group v-model="registerForm.sex">
            <el-radio :label="0">female</el-radio>
            <el-radio :label="1">male</el-radio>
            <el-radio :label="2">combine</el-radio>
            <el-radio :label="3">unclear</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item prop="location" label="location" size="mini">
          <el-input v-model="registerForm.location" placeholder="location"></el-input>
        </el-form-item>
        <el-form-item prop="birth" label="birth" size="mini">
          <el-date-picker
            type="date"
            placeholder="select date"
            v-model="registerForm.birth"
            style="width: 100%;"
          ></el-date-picker>
        </el-form-item>
        <el-form-item prop="introduction" label="introduction" size="mini">
          <el-input v-model="registerForm.introduction" type="textarea" placeholder="singer introduction"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="centerDialogVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="addsinger">submit</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹出框 -->
    <el-dialog title="Edit" :visible.sync="editVisible" width="500px">
      <el-form ref="form" :model="form" label-width="60px">
        <el-form-item label="name" size="mini">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="sex" size="mini">
          <el-radio-group v-model="form.sex">
            <el-radio :label="0">famale</el-radio>
            <el-radio :label="1">male</el-radio>
            <el-radio :label="2">combine</el-radio>
            <el-radio :label="3">unclear</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="birth" size="mini">
          <el-date-picker type="date" placeholder="select date" v-model="form.birth" style="width: 100%;"></el-date-picker>
        </el-form-item>
        <el-form-item label="location" size="mini">
          <el-input v-model="form.location"></el-input>
        </el-form-item>
        <el-form-item label="introduction" size="mini">
          <el-input type="textarea" v-model="form.introduction"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini"  @click="editVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="saveEdit">submit</el-button>
      </span>
    </el-dialog>

    <!-- 删除提示框 -->
    <el-dialog title="Tips" :visible.sync="delVisible" width="300px" center>
      <div class="del-dialog-cnt" align="center">no recover,are you sure to delete?</div>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="delVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="deleteRow">submit</el-button>
      </span>
    </el-dialog>

    <!-- 批量删除提示框 -->
    <el-dialog title="Tips" :visible.sync="delAllVisible" width="300px" center>
      <div class="del-dialog-cnt" align="center">no recover,are you sure to delete?</div>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="delAllVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="delAll">submit</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
import { mixin } from '../mixins'
import { setSinger, getAllSinger, updateSingerMsg, deleteSinger } from '../api/index'

export default {
  name: 'singer-page',
  mixins: [mixin],
  data () {
    return {
      registerForm: {
        // 添加框信息
        name: '',
        sex: '',
        birth: '',
        location: '',
        introduction: ''
      },
      tableData: [],
      tempDate: [],
      multipleSelection: [],
      centerDialogVisible: false,
      editVisible: false,
      delVisible: false,
      delAllVisible: false,
      select_word: '',
      form: {
        // 编辑框信息
        id: '',
        name: '',
        sex: '',
        pic: '',
        birth: '',
        location: '',
        introduction: ''
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
          if (item.name.includes(this.select_word)) {
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
    // 获取当前页
    handleCurrentChange (val) {
      this.currentPage = val
    },
    uploadUrl (id) {
      return `${this.$store.state.HOST}/singer/updatePic?id=${id}`
    },
    // 添加歌手
    addsinger () {
      let d = this.registerForm.birth
      let datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate()
      let params = new URLSearchParams()
      params.append('name', this.registerForm.name)
      params.append('sex', this.registerForm.sex)
      params.append('pic', '/img/singerPic/hhh.jpg')
      params.append('birth', datetime)
      params.append('location', this.registerForm.location)
      params.append('introduction', this.registerForm.introduction)
      setSinger(params)
        .then(res => {
          if (res.code === 1) {
            this.getData()
            this.registerForm = {}
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
    // 获取歌手
    getData () {
      this.tableData = []
      this.tempDate = []
      getAllSinger().then(res => {
        this.tableData = res
        this.tempDate = res
        this.currentPage = 1
      })
    },
    // 编辑
    handleEdit (row) {
      this.editVisible = true
      this.idx = row.id
      let datetime = row.birth
      this.form = {
        id: row.id,
        name: row.name,
        sex: row.sex,
        pic: row.pic,
        birth: datetime,
        location: row.location,
        introduction: row.introduction
      }
    },
    // 保存编辑
    saveEdit () {
      let d = new Date(this.form.birth)
      let datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate()
      let params = new URLSearchParams()
      params.append('id', this.form.id)
      params.append('name', this.form.name)
      params.append('sex', this.form.sex)
      params.append('pic', this.form.pic)
      params.append('birth', datetime)
      params.append('location', this.form.location)
      params.append('introduction', this.form.introduction)
      updateSingerMsg(params)
        .then(res => {
          if (res.code === 1) {
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
      deleteSinger(this.idx)
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
    },
    songEdit (id, name) {
      this.$router.push({path: `/song`, query: {id: id, name: name}})
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

.singer-img {
  width: 100%;
  height: 80px;
  border-radius: 5px;
  margin-bottom: 5px;
  overflow: hidden;
}

.pagination {
  display: flex;
  justify-content: center;
}
</style>
