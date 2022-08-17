<!--  管理员  借书信息统计 -->
<!--  人员借书统计信息 -->
<template>
  <div class="bookList">
    <el-table :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)" border style="width: 100%">
      <el-table-column prop="id" label="序号" width="200"></el-table-column>
      <el-table-column prop="stuId" label="学生ID" width="200"></el-table-column>
      <el-table-column prop="bookId" label="图书编号" width="200"></el-table-column>
      <el-table-column prop="bookName" label="书名" width="250"></el-table-column>
      <el-table-column prop="brrowDate" label="申请借书时间" width="240"></el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      @current-change="change"
      background
      layout="prev, pager, next"
      :page-size="pageSize"
      :total="tableData.length"
    ></el-pagination>
  </div>
</template>

<script>
export default {
  methods: {
     change(currentPage) {
      this.currentPage = currentPage;
    }
  },

  data() {
    return {
      pageSize: 6,
      total: 10,
      currentPage: 1,
      tableData: [
        {
          id: "",
          bookId: "",
          brrowDate: "",
          bookName: "",
          stuId: "",
          returnDate: "",
          brrCheck: "",
          retCheck: "",
          addCheck: ""
        }
      ],

     
    };
  },
  created() {
    const _this = this;
    if (this.global.admCount == "") {
      _this.$message({
        message: "请重新登录！"
      });
      _this.$router.push("/stuLog");
    }else{
      _this.$axios
      .get("http://localhost:8081/brrows/findAll")
      .then(function(resp) {
        var demoArray = [];
        for (var i = 0; i < resp.data.length; i++) {
          if (resp.data[i].brrCheck == 2 && resp.data[i].retCheck!=2) {
            demoArray.push(resp.data[i]);
            console.log(resp.data[i]);
          }
        }
        _this.tableData = demoArray;
      });
    }
    
  }
};
</script>
<style >
</style>
