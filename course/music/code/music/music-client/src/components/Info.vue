<template>
  <div class="info">
    <p class="title">Edit Info</p>
    <hr/>
    <div class="personal">
      <el-form :model="registerForm" class="demo-ruleForm" label-width="80px">
        <el-form-item prop="username" label="Name">
          <el-input v-model="registerForm.username" placeholder="Name"></el-input>
        </el-form-item>
        <el-form-item prop="password" label="Password">
          <el-input type="password" placeholder="Password" v-model="registerForm.password"></el-input>
        </el-form-item>
        <el-form-item label="Gender">
          <el-radio-group v-model="registerForm.sex">
            <el-radio :label="0">female</el-radio>
            <el-radio :label="1">male</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item prop="phoneNum" label="Phone">
          <el-input  placeholder="Phone" v-model="registerForm.phoneNum" ></el-input>
        </el-form-item>
        <el-form-item prop="email" label="Email">
          <el-input v-model="registerForm.email" placeholder="Email"></el-input>
        </el-form-item>
        <el-form-item prop="birth" label="Birth">
          <el-date-picker type="date" placeholder="select date" v-model="registerForm.birth" style="width: 100%;"></el-date-picker>
        </el-form-item>
        <el-form-item prop="introduction" label="Introduction">
          <el-input  type="textarea" placeholder="Introduction" v-model="registerForm.introduction" ></el-input>
        </el-form-item>
        <el-form-item prop="location" label="Location">
          <el-select v-model="registerForm.location" placeholder="Location" style="width:100%">
            <el-option
              v-for="item in cities"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
    <div class="btn">
      <div @click="goback">cancel</div>
      <div @click="saveMsg()">submit</div>
    </div>
    </div>
</div>
</template>

<script>
import { mapGetters } from 'vuex'
import { cities } from '../assets/data/form'
import { updateUserMsg, getUserOfId } from '../api/index'

export default {
  name: 'info',
  data: function () {
    return {
      registerForm: { // 注册
        username: '',
        password: '',
        sex: '',
        phoneNum: '',
        email: '',
        birth: '',
        introduction: '',
        location: ''
      },
      cities: []
    }
  },
  computed: {
    ...mapGetters([
      'userId'
    ])
  },
  created () {
    this.cities = cities
  },
  mounted () {
    this.getMsg(this.userId)
  },
  methods: {
    getMsg (id) {
      getUserOfId(id)
        .then(res => {
          this.registerForm.username = res.username
          this.registerForm.password = res.password
          this.registerForm.sex = res.sex
          this.registerForm.phoneNum = res.phoneNum
          this.registerForm.email = res.email
          this.registerForm.birth = res.birth
          this.registerForm.introduction = res.introduction
          this.registerForm.location = res.location
          this.registerForm.avator = res.avator
        })
        .catch(err => {
          console.log(err)
        })
    },
    goback () {
      this.$router.go(-1)
    },
    saveMsg () {
      let d = new Date(this.registerForm.birth)
      let datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate()
      let params = new URLSearchParams()
      params.append('id', this.userId)
      params.append('username', this.registerForm.username)
      params.append('password', this.registerForm.password)
      params.append('sex', this.registerForm.sex)
      params.append('phone_num', this.registerForm.phoneNum)
      params.append('email', this.registerForm.email)
      params.append('birth', datetime)
      params.append('introduction', this.registerForm.introduction)
      params.append('location', this.registerForm.location)
      updateUserMsg(params)
        .then(res => {
          if (res.code === 1) {
            this.showError = false
            this.showSuccess = true
            this.$store.commit('setUsername', this.registerForm.username)
            this.$notify.success({
              title: 'edit successfully',
              showClose: true
            })
            setTimeout(function () {
              this.$router.go(-1)
            }, 2000)
          } else {
            this.showSuccess = false
            this.showError = true
            this.$notify.error({
              title: 'edit failed',
              showClose: true
            })
          }
        })
        .catch(err => {
          console.log(err)
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/info.scss';
</style>
