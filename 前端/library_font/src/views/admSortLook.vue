<!-- 管理员  查看图书分类 -->

<template>
  <div>
    <el-table
      :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
      border
      style="width: 100%"
      @row-click="getDetails"
    >
      <el-table-column fixed prop="id" label="图书分类序号" width="300"></el-table-column>
      <el-table-column prop="name" label="分类名称" width="300"></el-table-column>

      <el-table-column fixed="right" label="操作" width="300">
        <template slot-scope="scope">
          <el-button @click="updateSort(scope.row)" type="text" size="small">修改</el-button>
          <el-button @click="deleteSort(scope.row)" type="text" size="small">删除</el-button>
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
    updateSort(row) {
      const _this = this;
      this.$router.push({
        path: "/admUpdateSort",
        query: {
          id: row.id
        }
      });
    },
    deleteSort(row) {
      const _this = this;
      _this
        .$confirm("确认删除吗, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
        .then(() => {
          _this.$axios
            .delete("http://localhost:8081/sorts/delete/" + row.id)
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
          name: ""
        }
      ]
    };
  },
  created() {
    const _this = this;
    if (this.global.admCount == "") {
      _this.$message({
        message: "请重新登录！"
      });
      _this.$router.push("/stuLog");
    } else {
      _this.$axios
        .get("http://localhost:8081/sorts/findAll")
        .then(function(resp) {
          // console.log(resp);
          _this.tableData = resp.data;
          // console.log(_this.tableData);
        });
    }
  }
};
</script>
