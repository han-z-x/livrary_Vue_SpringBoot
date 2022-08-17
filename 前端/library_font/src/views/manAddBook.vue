<!-- 1-1-2  人员增加图书 -->
<template>
  <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm" style="width:40%">
    <el-form-item label="书名" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
    </el-form-item>
    <el-form-item label="作者" prop="author">
      <el-input v-model="ruleForm.author"></el-input>
    </el-form-item>
    <el-form-item label="书籍分类" prop="sort">
     <el-select v-model="ruleForm.sort" placeholder="请选择">
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
      <el-button type="primary" @click="submitForm('ruleForm')">添加</el-button>
      <el-button @click="resetForm('ruleForm')">重置</el-button>
    </el-form-item>
  </el-form>
</template>


<script>
export default {
  data() {
    return {
      options:[],
      ruleForm: {
        name: "",
        author: "",
        sort: "",
        bookdesc: "",
        count: "10"
      },
      rules: {
        name: [
          { required: true, message: "请输入书名", trigger: "blur" },
          { min: 1, max: 20, message: "长度在 1 到 20 个字符", trigger: "blur" }
        ],
        author: [
          { required: true, message: "请输入作者", trigger: "blur" },
          { min: 2, max: 10, message: "长度在 1 到 10 个字符", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    submitForm(formName) {
      var _this = this;
      this.$refs[formName].validate(valid => {
        if (valid) {
          _this.$axios //默认传递的是json格式的数据
            .post("http://localhost:8081/books/add", this.ruleForm)
            .then(function(resp) {
              // console.log(resp)
              if (resp.data) {
                _this.$alert("添加成功", "提示", {
                  confirmButtonText: "确定",
                  callback: action => {
                    _this.$router.push("/manBookLook");
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
  created(){
     const _this = this;
    
    if (this.global.manCount == "") {
      _this.$message({
        message: "请重新登录"
      });
      _this.$router.push("/stuLog");
    }else{
        _this.$axios.get("http://localhost:8081/sorts/findAll").then(function(resp){
            // console.log(resp)
            _this.options=resp.data
        })
    }
  }
};
</script>
