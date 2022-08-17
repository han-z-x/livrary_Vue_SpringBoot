<!-- 1-1-1 人员图书查看 -->
<template>
  <div>
    <div class="bookList">
      <el-table :data="tableData" border style="width: 100%;padding-top:0" @row-click="getDetails">
        <el-table-column fixed prop="id" label="图书编号" width="150"></el-table-column>
        <el-table-column prop="name" label="书名" width="200"></el-table-column>
        <el-table-column prop="author" label="作者" width="200"></el-table-column>
        <el-table-column prop="count" label="书籍数量" width="200"></el-table-column>
        <el-table-column fixed="right" label="操作" width="250">
          <template slot-scope="scope">
            <!-- 查看图书信息 -->
            <el-button @click="updateBook(scope.row)" type="text" size="small">修改</el-button>
            <el-button @click="deleteBook(scope.row)" type="text" size="small">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
        style="margin-top:20px"
        background
        layout="prev, pager, next"
        :page-size="pageSize"
        :total="total"
        @current-change="change"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  inject: ["reload"],
  methods: {
    deleteBook(row) {
      // 删除书籍
      const _this = this;
      _this
        .$confirm("确认删除吗, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
        .then(() => {
          _this.$axios
            .delete("http://localhost:8081/books/delete/" + row.id)
            .then(function(resp) {
              _this.$message({
                type: "success",
                message: "删除成功"
              });
              _this.reload();
            });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    updateBook(row) {
      //  修改书籍
      const _this = this;
      this.$router.push({
        path: "/manUpdateBook",
        query: {
          id: row.id
        }
      });
    },

    change(currentPage) {
      // console.log("pagecurrent")
      var _this = this;
      this.$axios
        .get("http://localhost:8081/books/findAll/" + (currentPage) + "/6")
        .then(function(resp) {
          // console.log(resp);
          _this.tableData = resp.data.records;
          // console.log(resp.data.content)
          _this.total = resp.data.total;
        });
    }
  },

  data() {
    return {
      pageSize: 6,
      // 书籍分页
      total: 20,
      bookDesc: "",

      tableData: [
        {
          id: "",
          name: "",
          author: "",
          sort: "",
          bookdesc: "",
          count: ""
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
        .get("http://localhost:8081/books/findAll/1/6")
        .then(function(resp) {
          // console.log(resp);
          _this.tableData = resp.data.records;
          // console.log(_this.tableData);
        });
    }
  }
};
</script>
<style></style>
