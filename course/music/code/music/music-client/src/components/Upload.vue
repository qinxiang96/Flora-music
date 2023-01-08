<template>
  <div class="upload">
    <p class="title">Update Avatar</p>
    <hr/>
    <div class="section">
      <el-upload
        drag
        :action="uploadUrl()"
        :show-file-list="false"
        :on-success="handleAvatarSuccess"
        :before-upload="beforeAvatarUpload">
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">Please drag file here, or <em>update avatar</em></div>
        <div class="el-upload__tip" slot="tip">the upload pic must be JPG/PNG type and can't be larger than 10M</div>
      </el-upload>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { mixin } from '../mixins'

export default {
  name: 'upload',
  mixins: [mixin],
  data () {
    return {
      imageUrl: ''
    }
  },
  computed: {
    ...mapGetters([
      'userId'
    ])
  },
  methods: {
    uploadUrl () {
      return `${this.$store.state.configure.HOST}/consumer/updatePic?id=${this.userId}`
    },
    handleAvatarSuccess (res, file) {
      if (res.code === 1) {
        this.imageUrl = URL.createObjectURL(file.raw)
        this.$store.commit('setAvator', res.avator)
        this.$message({
          message: 'update successfully',
          type: 'success'
        })
      } else {
        this.notify('edit failed', 'error')
      }
    },
    beforeAvatarUpload (file) {
      const isJPG = file.type === 'image/jpeg'
      const isLt2M = file.size / 1024 / 1024 < 10
      if (!isJPG) {
        this.$message.error('the upload pic must be JPG type!')
      }
      if (!isLt2M) {
        this.$message.error('the upload pic can\'t be larger than 10MB!')
      }
      return isJPG && isLt2M
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/css/upload.scss';
</style>
