<!-- 1-2-1 人员图书借阅审核 -->
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
          <el-button @click="agreeBrrow(scope.row)" type="text" size="small">同意借阅</el-button>
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
    agreeBrrow(row) {
      // console.log(row)
      // 设置借阅时间
      // console.log(row)
      var _stuId = row.stuId;
      var _row = row;
      var now = new Date();
      var nowStr =
        now.getFullYear() + "/" + (now.getMonth() + 1) + "/" + now.getDate();
      _row.brrowDate = nowStr;
      // 设置归还时间  （默认一个月）

      var tempArray = nowStr.split("/");
      if (tempArray[1] == "12") {
        tempArray[0] = parseInt(tempArray[0]) + 1;
      } else {
        tempArray[1] = parseInt(tempArray[1]) + 1;
      }
      _row.returnDate = tempArray.join("/");
      const _this = this;
      _row.brrCheck = 2;  //设置为同意借阅
      this.$axios
        .put("http://localhost:8081/brrows/update", _row)
        .then(function(resp) {
          _this.$axios
            .get("http://localhost:8081/books/findById/" + _row.bookId)
            .then(function(resp) {
              //同意借阅后，相应id的书籍的数量应该减一。
              var _book = resp.data;
              _book.count = resp.data.count - 1;
              _this.$axios
                .put("http://localhost:8081/books/update", _book)  //提交图书更新信息
                .then(function(resp) {
                  _this.$axios
                  //通过学生id查找到当前学生表信息
                    .get("http://localhost:8081/students/findById/" + _stuId)
                    .then(function(resp) {
                      // console.log(resp)
                      //学生最大借书数量为10本，借了一本后，将相应学生的brrCount-1
                      var _tempStudent = resp.data;
                      _tempStudent.brrCount -= 1;
                      _this.$axios
                        .put(
                          "http://localhost:8081/students/update",
                          _tempStudent
                        )
                        .then(function(resp) {
                          _this.$message({
                            type: "success",
                            message: "已同意借阅"
                          });
                         setTimeout(function(){
                            _this.reload();
                         },1000)
                        });
                    });
                });
              // console.log(typeof(_book.count))
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
          var demoArray = [];  //用来存放待审核的借书信息
          for (var i = 0; i < resp.data.length; i++) {
            if (resp.data[i].brrCheck == 1) {
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
