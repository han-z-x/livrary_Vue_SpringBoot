<!-- 管理员  修改图书种类 -->

<template>
  <el-form
    :model="ruleForm"
    :rules="rules"
    ref="ruleForm"
    label-width="100px"
    class="demo-ruleForm"
    style="width:40%"
  >
    <el-form-item label="图书分类序号" prop="id">
      <el-input :disabled="true" v-model="ruleForm.id"></el-input>
    </el-form-item>
    <el-form-item label="分类名称" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
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
        name: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入图书分类名称", trigger: "blur" },
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
            .put("http://localhost:8081/sorts/update", this.ruleForm)
            .then(function(resp) {
              // console.log(resp)
              if (resp.data == "success") {
                _this.$alert("更新成功", "提示", {
                  confirmButtonText: "确定",
                  callback: action => {
                    _this.$router.push("/admSortLook");
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
  },
  created() {
    var _this = this;
    // alert(this.$route.query.id)
    // console.log(this.$route.query.id)
    if (this.global.admCount == "") {
      _this.$message({
        message: "请重新登录！"
      });
      _this.$router.push("/stuLog");
    } else {
      _this.$axios
        .get("http://localhost:8081/sorts/findById/" + this.$route.query.id)
        .then(function(resp) {
          // console.log(resp)
          _this.ruleForm = resp.data;
          console.log(resp.data);
        });
    }
  }
};
</script>
