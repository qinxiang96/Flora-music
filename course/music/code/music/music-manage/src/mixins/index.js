export const mixin = {
  methods: {
    // 提示信息
    notify (title, type) {
      this.$notify({
        title: title,
        type: type
      })
    },
    getUrl (url) {
      return `${this.$store.state.HOST}${url}`
    },
    // 获取要删除列表的id
    handleDelete (id) {
      this.idx = id
      this.delVisible = true
    },
    // 获取批量要删除的列表
    handleSelectionChange (val) {
      this.multipleSelection = val
    },
    // 批量删除
    delAll () {
      for (let item of this.multipleSelection) {
        this.handleDelete(item.id)
        this.deleteRow(item.id)
      }
      this.multipleSelection = []
      this.deleteAllVisible = false
    },
    // 得到歌曲名字
    replaceFName (str) {
      let arr = str.split('-')
      return arr[1]
    },
    // 得到歌手名字
    replaceLName (str) {
      let arr = str.split('-')
      return arr[0]
    },
    attachBirth (val) {
      let birth = String(val).match(/[0-9-]+(?=\s)/)
      return Array.isArray(birth) ? birth[0] : birth
    },
    changeSex (value) {
      if (value === 0) {
        return '女'
      } else if (value === 1) {
        return '男'
      } else if (value === 2) {
        return '组合'
      } else if (value === 3) {
        return '不明'
      } else if (value === '男' || value === '女') {
        return value
      }
    },
    toggleSex (value) {
      if (value === '女') {
        return 0
      } else if (value === '男') {
        return 1
      }
    },
    // 更新图片
    handleAvatarSuccess (res, file) {
      let _this = this
      if (res.code === 1) {
        _this.imageUrl = URL.createObjectURL(file.raw)
        _this.getData()
        _this.$notify({
          title: 'update successfully',
          type: 'success'
        })
      } else {
        _this.$notify({
          title: 'update failed',
          type: 'error'
        })
      }
    },
    beforeAvatarUpload (file) {
      const isJPG = (file.type === 'image/jpeg') || (file.type === 'image/png')
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isJPG) {
        this.$message.error('the upload pic must be JPG type!')
      }
      if (!isLt2M) {
        this.$message.error('the upload pic can\'t be larger than 2MB!')
      }
      return isJPG && isLt2M
    }
  }
}
