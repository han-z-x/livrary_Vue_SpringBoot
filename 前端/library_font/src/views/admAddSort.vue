<!--  管理员  添加图书种类 -->

<template>
  <el-form
    :model="ruleForm"
    :rules="rules"
    ref="ruleForm"
    label-width="200px"
    class="demo-ruleForm"
    style="width:40%"
  >
    <el-form-item label="图书类别名称" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="submitForm('ruleForm')">添加</el-button>
      <el-button @click="resetForm('ruleForm')">重置</el-button>
    </el-form-item>
  </el-form>
</template>


<script>
export default {
  data() {
    return {
      ruleForm: {
        name: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入图书类别名称", trigger: "blur" },
          { min: 1, max: 20, message: "长度在 1 到 20 个字符", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    submitForm(formName) {
      var _this = this;
      this.$refs[formName].validate(valid => {
        if (valid) {
          _this.$axios
            .post("http://localhost:8081/sorts/add", this.ruleForm)
            .then(function(resp) {
              // console.log(resp)
              if (resp.data) {
                _this.$alert("添加成功", "提示", {
                  confirmButtonText: "确定",
                  callback: action => {
                    _this.$router.push("/admSortLook");
                  }
                });
              } else {
                this.$message("添加失败");
              }
            });
        } else {
          // console.log('error submit!!');
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  created() {
    if (this.global.admCount == "") {
      _this.$message({
        message: "请重新登录！"
      });
      _this.$router.push("/stuLog");
    }
  }
};
</script>
