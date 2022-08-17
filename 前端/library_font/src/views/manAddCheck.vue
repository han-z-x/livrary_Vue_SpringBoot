<!-- 1-2-2 人员图书续借审核审核 -->
<template>
  <div class="bookList">
    <el-table
      :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
      border
      style="width: 100%"
    >
      <el-table-column prop="id" label="序号" width="100"></el-table-column>
      <el-table-column prop="stuId" label="学生ID" width="100"></el-table-column>
      <el-table-column prop="bookId" label="图书编号" width="200"></el-table-column>
      <el-table-column prop="bookName" label="书名" width="200"></el-table-column>
      <el-table-column prop="brrowDate" label="申请借书时间" width="200"></el-table-column>

      <el-table-column fixed="right" label="操作" width="250">
        <template slot-scope="scope">
          <el-button @click="addBrrow(scope.row)" type="text" size="small">同意续借</el-button>
        </template>
      </el-table-column>
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
  inject: ["reload"],

  methods: {
    change(currentPage) {
      this.currentPage = currentPage;
    },
    addBrrow(row) {
      // 设置还书时间
      var _row = row;
      var timeStr = _row.returnDate;
      var tempArray = timeStr.split("/");
      if (tempArray[1] == "12") {
        tempArray[0] = parseInt(tempArray[0]) + 1;
      } else {
        tempArray[1] = parseInt(tempArray[1]) + 1;
      }
      _row.returnDate = tempArray.join("/");
      const _this = this;
      _row.addCheck = 2;  //设置为同意借阅
      this.$axios
        .put("http://localhost:8081/brrows/update", _row)
        .then(function(resp) {
          _this.$message({
            type: "success",
            message: "已同意续借"
          });
          setTimeout(function() {
            _this.reload();
          }, 1000);
        });
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
      ]
    };
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
        .get("http://localhost:8081/brrows/findAll")
        .then(function(resp) {
          // console.log(resp)
          // _this.tableData=resp.data;
          var demoArray = [];
          for (var i = 0; i < resp.data.length; i++) {
            if (resp.data[i].addCheck == 1) {
              demoArray.push(resp.data[i]);
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
