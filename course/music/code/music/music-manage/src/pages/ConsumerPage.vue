<template>
  <div class="table">
    <div class="container">
      <div class="handle-box">
        <el-button type="primary" size="mini" class="handle-del mr10" @click="delAll">Batch Delete</el-button>
        <el-input v-model="select_word" size="mini" placeholder="select user" class="handle-input mr10"></el-input>
        <el-button type="primary" size="mini" @click="centerDialogVisible = true">Add Consumer</el-button>
      </div>
      <el-table :data="data" border size="mini" style="width: 100%" ref="multipleTable" height="550px"
        @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="40" align="center"></el-table-column>
        <el-table-column label="pic" width="102" align="center">
          <template slot-scope="scope">
            <img :src="getUrl(scope.row.avator)" alt="" style="width: 80px;" />
            <el-upload class="upload-demo" :action="uploadUrl(scope.row.id)" :show-file-list="false"
              :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
              <el-button size="mini">update pic</el-button>
            </el-upload>
          </template>
        </el-table-column>
        <el-table-column label="username" prop="username" width="80" align="center"></el-table-column>
        <el-table-column label="password" prop="password" width="80" align="center"></el-table-column>
        <el-table-column label="sex" width="50" align="center">
          <template slot-scope="scope">
            <div>{{ changeSex(scope.row.sex) }}</div>
          </template>
        </el-table-column>
        <el-table-column label="phoneNum" prop="phoneNum" width="120" align="center"></el-table-column>
        <el-table-column label="email" prop="email" width="120" align="center"></el-table-column>
        <el-table-column label="birth" width="120" align="center">
          <template slot-scope="scope">
            <div>{{ attachBirth(scope.row.birth) }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="introduction" label="introduction" align="center"></el-table-column>
        <el-table-column prop="location" label="location" width="80" align="center"></el-table-column>
        <el-table-column label="colection" width="110" align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="getCollect(data[scope.$index].id)">colection</el-button>
          </template>
        </el-table-column>
        <el-table-column label="option" width="180" align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">edit</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row.id)">del</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination">
        <el-pagination @current-change="handleCurrentChange" background layout="total, prev, pager, next"
          :current-page="currentPage" :page-size="pageSize" :total="tableData.length">
        </el-pagination>
      </div>
    </div>

    <!--添加新用户-->
    <el-dialog title="Add Consumer" :visible.sync="centerDialogVisible" width="400px" center>
      <el-form :model="registerForm" status-icon :rules="rules" ref="registerForm" label-width="100px"
        class="demo-ruleForm">
        <el-form-item label="username" prop="username" size="mini">
          <el-input v-model="registerForm.username" placeholder="username"></el-input>
        </el-form-item>
        <el-form-item label="password" prop="password" size="mini">
          <el-input type="password" placeholder="password" v-model="registerForm.password"></el-input>
        </el-form-item>
        <el-form-item label="sex" size="mini">
          <el-radio-group v-model="registerForm.sex">
            <el-radio :label="0">female</el-radio>
            <el-radio :label="1">male</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="phoneNum" prop="phoneNum" size="mini">
          <el-input placeholder="phoneNum" v-model="registerForm.phoneNum"></el-input>
        </el-form-item>
        <el-form-item label="email" prop="email" size="mini">
          <el-input v-model="registerForm.email" placeholder="email"></el-input>
        </el-form-item>
        <el-form-item label="birth" prop="birth" size="mini">
          <el-date-picker type="date" placeholder="select date" v-model="registerForm.birth"
            style="width: 100%;"></el-date-picker>
        </el-form-item>
        <el-form-item label="introduction" prop="introduction" size="mini">
          <el-input type="textarea" placeholder="introduction" v-model="registerForm.introduction"></el-input>
        </el-form-item>
        <el-form-item label="location" prop="location" size="mini">
          <el-select v-model="registerForm.location" placeholder="location">
            <el-option v-for="item in cities" :key="item.value" :label="item.label" :value="item.value"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="centerDialogVisible = false">cancel</el-button>
        <el-button type="primary" size="mini" @click="addPeople">submit</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹出框 -->
    <el-dialog title="Edit" :visible.sync="editVisible" width="400px">
      <el-form ref="form" :model="form" label-width="80px" :rules="rules">
        <el-form-item label="username" size="mini">
          <el-input v-model="form.username" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="password" size="mini">
          <el-input v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item label="sex" size="mini">
          <el-radio-group v-model="form.sex">
            <el-radio :label="0">female</el-radio>
            <el-radio :label="1">male</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="phoneNum" size="mini">
          <el-input v-model="form.phoneNum"></el-input>
        </el-form-item>
        <el-form-item label="email" size="mini">
          <el-input v-model="form.email"></el-input>
        </el-form-item>
        <el-form-item label="birth" prop="birth" size="mini">
          <el-date-picker type="date" placeholder="select date" v-model="form.birth"
            style="width: 100%;"></el-date-picker>
        </el-form-item>
        <el-form-item label="introduction" size="mini">
          <el-input v-model="form.introduction"></el-input>
        </el-form-item>
        <el-form-item label="location" size="mini">
          <el-input v-model="form.location"></el-input>
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
        <el-button size="mini" type="primary" @click="deleteRow">submit</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mixin } from '../mixins'
import { setUser, updateUserMsg, getAllUser, deleteUser } from '../api/index'

export default {
  name: 'consumer-page',
  mixins: [mixin],
  data () {
    return {
      registerForm: { // 注册
        username: '',
        password: '',
        sex: 1,
        phoneNum: '',
        email: '',
        birth: '',
        introduction: '',
        location: ''
      },
      cities: [{
        value: '北京',
        label: '北京'
      }, {
        value: '天津',
        label: '天津'
      }, {
        value: '河北',
        label: '河北'
      }, {
        value: '山西',
        label: '山西'
      }, {
        value: '内蒙古',
        label: '内蒙古'
      }, {
        value: '辽宁',
        label: '辽宁'
      }, {
        value: '吉林',
        label: '吉林'
      }, {
        value: '黑龙江',
        label: '黑龙江'
      }, {
        value: '上海',
        label: '上海'
      }, {
        value: '江苏',
        label: '江苏'
      }, {
        value: '浙江',
        label: '浙江'
      }, {
        value: '安徽',
        label: '安徽'
      }, {
        value: '福建',
        label: '福建'
      }, {
        value: '江西',
        label: '江西'
      }, {
        value: '山东',
        label: '山东'
      }, {
        value: '河南',
        label: '河南'
      }, {
        value: '湖北',
        label: '湖北'
      }, {
        value: '湖南',
        label: '湖南'
      }, {
        value: '广东',
        label: '广东'
      }, {
        value: '广西',
        label: '广西'
      }, {
        value: '海南',
        label: '海南'
      }, {
        value: '重庆',
        label: '重庆'
      }, {
        value: '四川',
        label: '四川'
      }, {
        value: '贵州',
        label: '贵州'
      }, {
        value: '云南',
        label: '云南'
      }, {
        value: '西藏',
        label: '西藏'
      }, {
        value: '陕西',
        label: '陕西'
      }, {
        value: '甘肃',
        label: '甘肃'
      }, {
        value: '青海',
        label: '青海'
      }, {
        value: '宁夏',
        label: '宁夏'
      }, {
        value: '新疆',
        label: '新疆'
      }, {
        value: '香港',
        label: '香港'
      }, {
        value: '澳门',
        label: '澳门'
      }, {
        value: '台湾',
        label: '台湾'
      }],
      rules: {
        username: [
          { required: true, trigger: 'blur' }
        ],
        password: [
          { required: true, trigger: 'blur' }
        ],
        sex: [
          { required: true, message: 'please select sex', trigger: 'change' }
        ],
        phoneNum: [
          { essage: 'please select phoneNum', trigger: 'blur' }
        ],
        email: [
          { message: 'please input email address', trigger: 'blur' },
          { type: 'email', message: 'please input right email address', trigger: ['blur', 'change'] }
        ],
        birth: [
          { required: true, type: 'date', message: 'please selete date', trigger: 'change' }
        ],
        introduction: [
          { message: 'please input introduction', trigger: 'blur' }
        ],
        location: [
          { message: 'please input location', trigger: 'change' }
        ]
      },
      tableData: [], // 记录用户信息，用于显示
      tempDate: [], // 记录用户信息，用于搜索时能临时记录一份用户信息
      is_search: false,
      multipleSelection: [], // 记录要删除的用户信息
      centerDialogVisible: false,
      editVisible: false, // 显示编辑框
      delVisible: false, // 显示删除框
      select_word: '', // 记录输入框输入的内容
      form: { // 记录编辑的信息
        id: '',
        username: '',
        password: '',
        sex: '',
        phoneNum: '',
        email: '',
        birth: '',
        introduction: '',
        location: '',
        createTime: '',
        updateTime: ''
      },
      pageSize: 5, // 页数
      currentPage: 1, // 当前页
      idx: -1 // 记录当前点中的行
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
          if (item.username.includes(this.select_word)) {
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
      return `${this.$store.state.HOST}/consumer/updatePic?id=${id}`
    },
    // 获取用户信息
    getData () {
      this.tableData = []
      this.tempDate = []
      getAllUser().then((res) => {
        this.tableData = res
        this.tempDate = res
        this.currentPage = 1
      })
    },
    getCollect (id) {
      this.$router.push({ path: '/collect', query: { id } })
    },
    // 添加用户
    addPeople () {
      this.$refs['registerForm'].validate(valid => {
        if (valid) {
          let d = this.registerForm.birth
          let datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate()
          let params = new URLSearchParams()
          params.append('username', this.registerForm.username)
          params.append('password', this.registerForm.password)
          params.append('sex', this.registerForm.sex)
          params.append('phone_num', this.registerForm.phoneNum)
          params.append('email', this.registerForm.email)
          params.append('birth', datetime)
          params.append('introduction', this.registerForm.introduction)
          params.append('location', this.registerForm.location)
          params.append('avator', '/img/user.jpg')
          setUser(params)
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
        }
      })
    },
    // 编辑
    handleEdit (row) {
      this.idx = row.id
      this.form = {
        id: row.id,
        username: row.username,
        password: row.password,
        sex: row.sex,
        phoneNum: row.phoneNum,
        email: row.email,
        birth: new Date(row.birth),
        introduction: row.introduction,
        location: row.location,
        avator: row.avator
      }
      this.editVisible = true
    },
    // 保存编辑
    saveEdit () {
      this.$refs['form'].validate(valid => {
        if (valid) {
          let d = new Date(this.form.birth)
          let datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate()
          let params = new URLSearchParams()
          params.append('id', this.form.id)
          params.append('username', this.form.username)
          params.append('password', this.form.password)
          params.append('sex', this.form.sex)
          params.append('phone_num', this.form.phoneNum)
          params.append('email', this.form.email)
          params.append('birth', datetime)
          params.append('introduction', this.form.introduction)
          params.append('location', this.form.location)
          updateUserMsg(params).then(res => {
            if (res.code === 1) {
              this.getData()
              this.notify('edit successfully', 'success')
            } else {
              this.notify('edit failed', 'error')
            }
          }).catch(err => {
            console.log(err)
          })
          this.editVisible = false
        }
      })
    },
    // 确定删除
    deleteRow () {
      deleteUser(this.idx)
        .then(res => {
          if (res) {
            this.getData()
            this.notify('delete successfully', 'success')
          } else {
            this.notify('delete failed', 'error')
          }
        })
        .catch(failResponse => { })
      this.delVisible = false
    }
  }
}

</script>

<style scoped>
.handle-box {
  margin-bottom: 20px;
  font-size: 12px;
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
