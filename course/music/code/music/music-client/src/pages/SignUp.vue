<template>
<div class="signUp-page">
  <loginLogo/>
  <div class="signUp">
    <div class="signUp-head">
      <span>Sign Up</span>
    </div>
    <el-form :model="registerForm" status-icon :rules="rules" ref="registerForm" label-width="80px" class="demo-ruleForm">
      <el-form-item prop="username" label="username">
        <el-input v-model="registerForm.username" placeholder="username"></el-input>
      </el-form-item>
      <el-form-item prop="password" label="password">
        <el-input type="password" placeholder="password" v-model="registerForm.password"></el-input>
      </el-form-item>
      <el-form-item prop="sex" label="sex">
        <el-radio-group v-model="registerForm.sex">
          <el-radio :label="0">female</el-radio>
          <el-radio :label="1">male</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item prop="phoneNum" label="phone" >
        <el-input  placeholder="phone" v-model="registerForm.phoneNum"></el-input>
      </el-form-item>
      <el-form-item prop="email" label="email">
        <el-input v-model="registerForm.email" placeholder="email"></el-input>
      </el-form-item>
      <el-form-item prop="birth" label="birth">
        <el-date-picker type="date" placeholder="select date" v-model="registerForm.birth" style="width: 100%;"></el-date-picker>
      </el-form-item>
      <el-form-item prop="introduction" label="introduction">
        <el-input  type="textarea" placeholder="introduction" v-model="registerForm.introduction" ></el-input>
      </el-form-item>
      <el-form-item prop="location" label="location">
        <el-select v-model="registerForm.location" placeholder="location" style="width:100%">
          <el-option v-for="item in cities" :key="item.value" :label="item.label" :value="item.value"></el-option>
        </el-select>
      </el-form-item>
      <div class="login-btn">
        <el-button @click="goback(-1)">cancel</el-button>
        <el-button type="primary" @click="SignUp">submit</el-button>
      </div>
    </el-form>
  </div>
</div>
</template>

<script>
import loginLogo from '../components/LoginLogo'
import { mixin } from '../mixins'
import { rules, cities } from '../assets/data/form'
import { SignUp } from '../api/index'

export default {
  name: 'SignUp-page',
  components: {
    loginLogo
  },
  mixins: [mixin],
  data () {
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
      rules: {},
      cities: []
    }
  },
  created () {
    this.rules = rules
    this.cities = cities
  },
  methods: {
    SignUp () {
      let _this = this
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
      SignUp(params)
        .then(res => {
          console.log(res)
          if (res.code === 1) {
            _this.notify('register successfully', 'success')
            // 2秒后跳转到首页
            setTimeout(function () {
              _this.$router.push({path: '/'})
            }, 2000)
          } else {
            _this.notify('register failed', 'error')
          }
        })
        .catch(err => {
          console.log(err)
        })
    },
    goback (index) {
      this.$router.go(index)
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/sign-up.scss';
</style>
