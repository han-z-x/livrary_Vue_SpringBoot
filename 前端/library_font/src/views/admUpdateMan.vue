<!-- 管理员  修改员工信息 -->
<template>
  <el-form
    :model="ruleForm"
    :rules="rules"
    ref="ruleForm"
    label-width="100px"
    class="demo-ruleForm"
    style="width:40%"
  >
    <el-form-item label="账号" prop="id">
      <el-input :disabled="true" v-model="ruleForm.id"></el-input>
    </el-form-item>
    <el-form-item label="姓名" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
    </el-form-item>
    <el-form-item label="用户名" prop="username">
      <el-input v-model="ruleForm.username"></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="pwd">
      <el-input v-model="ruleForm.pwd"></el-input>
    </el-form-item>
    <el-form-item label="手机号码" prop="tel">
      <el-input v-model="ruleForm.tel"></el-input>
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="submitForm('ruleForm')">更新</el-button>
    </el-form-item>
  </el-form>
</template>


<script>
export default {
  data() {
    return {
      ruleForm: {
        id: "",
        name: "",
        username:"",
        pwd: "",
        tel: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入管理员姓名", trigger: "blur" },
          { min: 2, max: 12, message: "长度在 2 到 12 个字符", trigger: "blur" }
        ],
        username: [
          { required: true, message: "请输入用户名称", trigger: "blur" },
          { min: 2, max: 12, message: "长度在 2 到 12 个字符", trigger: "blur" }
        ],
        pwd: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 6, max: 16, message: "长度在 6 到 16 个字符", trigger: "blur" }
        ],
        tel: [
          { required: true, message: "请输入手机号", trigger: "blur" },
          { min: 11, max: 11, message: "长度 11 个字符", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    submitForm(formName) {
      var _this = this;
      var flag = false;
      var nameReg = /^[\u4e00-\u9fa5]|[A-Z]|[a-z]|[0-9]{2,12}$/;
      var usernameReg = /^[\u4e00-\u9fa5]|[A-Z]|[a-z]|[0-9]{2,12}$/;
      var pwdReg = /^[A-Z]|[a-z]|[0-9]{6,20}$/;
      var telReg = /^[1]([3-9])[0-9]{9}$/;
      if (
        nameReg.test(this.ruleForm.name) &&
        usernameReg.test(this.ruleForm.username) &&
        pwdReg.test(this.ruleForm.pwd) &&
        telReg.test(this.ruleForm.tel)
      ) {
        flag = true;
      } else {
        alert("你输入的呢称或用户名或密码或手机号码错误");
      }

      if (flag) {
        _this.$refs[formName].validate(valid => {
          if (valid) {
            _this.$axios
              .put("http://localhost:8081/managers/update", this.ruleForm)
              .then(function(resp) {
                // console.log(resp)
                if (resp.data == "success") {
                  _this.$alert("更新成功", "提示", {
                    confirmButtonText: "确定",
                    callback: action => {
                      _this.$router.push("/admManLook");
                    }
                  });
                } else {
                  this.$message("更新失败");
                }
              });
          } else {
            console.log("error submit!!");
            return false;
          }
        });
      }
    }
  },
  created() {
    var _this = this;
    // alert(this.$route.query.id)
    // console.log(this.$route.query.id)
    console.log(this.global.admCount);
    if (this.global.admCount == "") {
      _this.$message({
        message: "请重新登录！"
      });
      _this.$router.push("/stuLog");
    }else{
      _this.$axios
      .get("http://localhost:8081/managers/findById/" + this.$route.query.id)
      .then(function(resp) {
        // console.log(resp)
        _this.ruleForm = resp.data;
        // console.log(resp.data)
      });
    }
  }
};
</script>
