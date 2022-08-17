<!-- 学生注册页面 -->
<template>
  <div>
    <div class="nav">
      <i
        style="font-size:50px; color:#409EFF; line-height:80px;text-indent:50px"
        class="el-icon-upload"
      >
        <span style="font-size:40px;">图书管理系统</span>
      </i>
    </div>

    <div class="stuRegistry">
      <el-form ref="form" :model="sizeForm" label-width="80px" size="mini">
        <el-form-item label="用户名">
          <el-input v-model="sizeForm.username" placeholder="请输入2-12位用户名"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="sizeForm.pwd" placeholder="请输入6-16位密码"></el-input>
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="sizeForm.tel" placeholder="请输入11位手机号"></el-input>
        </el-form-item>
        <el-form-item size="large" style="margin:50px 50px">
          <el-button type="primary" @click="onSubmit">注册</el-button>
          <el-button @click="canceled">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sizeForm: {
        name:"",
        username: "",
        pwd: "",
        card: "0",
        tel: "",
        brrCount: "10",
        timeOut:"0"
      }
    };
  },
  methods: {
    onSubmit() {
      const _this = this;
      // console.log("submit!");
      var usernameReg = /^[\u4e00-\u9fa5]|[A-Z]|[a-z]|[0-9]{2,12}$/;
      var pwdReg = /^[A-Z]|[a-z]|[0-9]{6,20}$/;
      var telReg = /^[1]([3-9])[0-9]{9}$/;
      if (
        usernameReg.test(this.sizeForm.username) &&
        pwdReg.test(this.sizeForm.pwd) &&
        telReg.test(this.sizeForm.tel)
      ) {
        // console.log(_this.sizeForm)
        var _telIsExist = false;  //用来判断注册用户是否重复
        _this.$axios
          .get("http://localhost:8081/students/findAll")
          .then(function(resp) {
            
            for (var i = 0; i < resp.data.length; i++) {
              //判断电话号码或者是用户名是否有重复的
              if (resp.data[i].tel == _this.sizeForm.tel || resp.data[i].username == _this.sizeForm.username) {
                _telIsExist = true;
              }
            }
            if (_telIsExist!=true) {
              _this.$axios
                .post("http://localhost:8081/students/add", _this.sizeForm)
                .then(function(resp) {
                  // console.log(resp);
                  
                  var _confirm = confirm("您的id和账号分别为：" + resp.data);
                  if (_confirm) {
                    _this.$router.push({ path: "/stulog" });
                  }
                });
            }else{
            
              _this.$message({
                            
                            message: "该手机或者用户名已注册，请重新填写。"
                          });
            }
          });
      } else {
        alert("你输入的用户名或密码或手机号码错误");
      }
    },
    canceled(){
      this.$router.push("/stuLog");
    }
  }
};
</script>
<style>

* {
  padding: 0;
  margin: 0;
}
.stuRegistry {
  width: 30%;
  margin: 100px auto;
}
.nav {
  width: 100%;
  height: 80px;
  background-color: #f8f8f8;
}
</style>
