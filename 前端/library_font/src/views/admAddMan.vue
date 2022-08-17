<!--  管理员  添加员工 -->

<template>
  <el-form
    :model="ruleForm"
    :rules="rules"
    ref="ruleForm"
    label-width="200px"
    class="demo-ruleForm"
    style="width:40%"
  >
    <el-form-item label="姓名" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
    </el-form-item>
    <el-form-item label="用户名" prop="username">
      <el-input v-model="ruleForm.username"></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="pwd">
      <el-input v-model="ruleForm.pwd"></el-input>
    </el-form-item>
    <el-form-item label="手机号" prop="tel">
      <el-input v-model="ruleForm.tel"></el-input>
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
        name: "",
        username:"",
        pwd: "",
        tel: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入书名", trigger: "blur" },
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
          _this.$axios //发送post请求
            .post("http://localhost:8081/managers/add", this.ruleForm)
            .then(function(resp) {
              // console.log(resp)
              if (resp.data) {
                _this.$alert("添加成功", "提示", {
                  confirmButtonText: "确定",
                  callback: action => {
                    _this.$router.push("/admManLook");
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

  //检测登录
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
