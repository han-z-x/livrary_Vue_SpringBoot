<!-- 1-1-3 人员更新图书 -->

<template>
  <el-form
    :model="ruleForm"
    :rules="rules"
    ref="ruleForm"
    label-width="100px"
    class="demo-ruleForm"
    style="width:40%"
  >
    <el-form-item label="书名" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
    </el-form-item>
    <el-form-item label="作者" prop="author">
      <el-input v-model="ruleForm.author"></el-input>
    </el-form-item>
    <el-form-item label="书籍分类" prop="sort">
     <el-select v-model="ruleForm.typename" placeholder="请选择">
      <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id"></el-option>
    </el-select>
    </el-form-item>
    <el-form-item label="书籍信息" prop="bookdesc">
      <el-input v-model="ruleForm.bookdesc"></el-input>
    </el-form-item>
    <el-form-item label="书籍数量" prop="count">
      <el-input v-model="ruleForm.count"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm('ruleForm')">更新</el-button>
      <el-button @click="resetForm('ruleForm')">重置</el-button>
    </el-form-item>
  </el-form>
</template>


<script>
export default {
  data() {
    return {
      name:"",
      options:[],
      ruleForm: {
        id: "",
        name: "",
        author: "",
        sort: "1",
        bookdesc: "",
        count: "10",
        typename:""
      },
      rules: {
        name: [
          { required: true, message: "请输入书名", trigger: "blur" },
          { min: 1, max: 20, message: "长度在 1 到 20 个字符", trigger: "blur" }
        ],
        author: [
          { required: true, message: "请输入作者", trigger: "blur" },
          { min: 2, max: 20, message: "长度在 1 到 20 个字符", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.ruleForm.sort = String(this.ruleForm.typename);  //修改图书分类
      // console.log(this.resetForm.sort);
      var _this = this;
      this.$refs[formName].validate(valid => {
        if (valid) {
          // console.log(this.ruleForm.sort);
          // console.log(this.ruleForm);
          _this.$axios
            .put("http://localhost:8081/books/update", this.ruleForm)
            .then(function(resp) {
              // console.log(resp)
              if (resp.data == "success") {
                _this.$alert("更新成功", "提示", {
                  confirmButtonText: "确定",
                  callback: action => {
                    _this.$router.push("/manBookLook");
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
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  created() {
    const _this = this;
    if (this.global.manCount == "") {
      _this.$message({
        message: "请重新登录"
      });
      _this.$router.push("/stuLog");
    } else {
      _this.$axios
        .get("http://localhost:8081/books/findById/" + this.$route.query.id)
        .then(function(resp) {
          // console.log(resp)
          _this.ruleForm = resp.data;

          //查看所属分类
          _this.$axios.get("http://localhost:8081/sorts/findById/"+ resp.data.sort)
          .then(function(resp){
            // console.log(resp);
            _this.ruleForm.typename = resp.data.name;  //分类
          })

        });

      _this.$axios.get("http://localhost:8081/sorts/findAll").then(function(resp){
            // console.log(resp)
            _this.options=resp.data
        })
    }
  }
};
</script>
