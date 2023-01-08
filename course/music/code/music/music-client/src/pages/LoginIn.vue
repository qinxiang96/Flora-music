<template>
<div class="login-in">
  <login-logo/>
  <div class="login">
    <div class="login-head">
      <span>Login</span>
    </div>
    <el-form :model="loginForm" status-icon :rules="rules" ref="loginForm" class="demo-ruleForm" >
      <el-form-item prop="username">
        <el-input placeholder="username" v-model="loginForm.username"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" placeholder="password" v-model="loginForm.password" @keyup.enter.native="loginIn"></el-input>
      </el-form-item>
      <div class="login-btn">
        <el-button @click="goSignUp()">register</el-button>
        <el-button type="primary" @click="handleleLoginIn">login</el-button>
      </div>
    </el-form>
  </div>
</div>
</template>

<script>
import { mixin } from '../mixins'
import LoginLogo from '../components/LoginLogo'
import { loginIn } from '../api/index'

export default {
  name: 'login-in',
  components: {
    LoginLogo
  },
  mixins: [mixin],
  data: function () {
    let validateName = (rule, value, callback) => {
      if (!value) {
        return callback(new Error('username can not be empty'))
      } else {
        callback()
      }
    }
    let validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('please input password'))
      } else {
        callback()
      }
    }
    return {
      loginForm: { // 登录用户名密码
        username: '',
        password: ''
      },
      rules: {
        username: [
          { validator: validateName, message: 'please input username', trigger: 'blur' }
        ],
        password: [
          { validator: validatePassword, message: 'please input password', trigger: 'blur' }
        ]
      }
    }
  },
  mounted () {
    this.changeIndex('login')
  },
  methods: {
    changeIndex (value) {
      this.$store.commit('setActiveName', value)
    },
    handleleLoginIn () {
      let _this = this
      let params = new URLSearchParams()
      params.append('username', this.loginForm.username)
      params.append('password', this.loginForm.password)
      loginIn(params)
        .then(res => {
          // console.log('-----------获取登录信息---------------')
          if (res.code === 1) {
            _this.$message({
              message: 'login successfully',
              type: 'success'
            })
            _this.setUserMsg(res.userMsg[0])
            _this.$store.commit('setLoginIn', true)
            setTimeout(function () {
              _this.changeIndex('Home Page')
              _this.$router.push({path: '/'})
              _this.$router.go(0)
            }, 2000)
          } else {
            _this.notify('username or password is wrong', 'error')
          }
        })
        .catch(failResponse => {})
    },
    setUserMsg (item) {
      this.$store.commit('setUserId', item.id)
      this.$store.commit('setUsername', item.username)
      this.$store.commit('setAvator', item.avator)
    },
    goSignUp () {
      this.$router.push({path: '/sign-up'})
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/login-in.scss';
</style>
