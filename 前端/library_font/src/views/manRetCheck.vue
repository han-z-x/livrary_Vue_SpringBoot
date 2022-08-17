<!-- 1-2-3 人员图书归还审核 -->
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
          <el-button @click="agreeReturn(scope.row)" type="text" size="small">同意归还</el-button>
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
    agreeReturn(row) {
      // 设置还书时间
      var _row = row;
      var _stuId = row.stuId;
      var now = new Date();

      // 临时逾期时间
      var _returnDate = row.returnDate;

      var _now = new Date(_returnDate);

      var nowStr =
        now.getFullYear() + "/" + (now.getMonth() + 1) + "/" + now.getDate();
      _row.brrowDate = nowStr;

      const _this = this;
      _row.retCheck = 2;  //确认归还
      _row.returnDate=nowStr;
      this.$axios
        .put("http://localhost:8081/brrows/update", _row)
        .then(function(resp) {
          _this.$axios
            .get("http://localhost:8081/books/findById/" + _row.bookId)
            .then(function(resp) {
              var _book = resp.data;
              _book.count = resp.data.count + 1;
              _this.$axios
                .put("http://localhost:8081/books/update", _book)
                .then(function(resp) {
                  _this.$axios
                    .get("http://localhost:8081/students/findById/" + _stuId)
                    .then(function(resp) {
                      // console.log(resp)
                      var _tempStudent = resp.data;
                      _tempStudent.brrCount += 1;  //借书数量+1
                      // console.log(now.getTime);
                      var _nowStamp = Date.parse(_now);
                      var nowStamp = Date.parse(now);
                      // console.log(nowStamp)
                      // console.log(_nowStamp)
                      {
                        if (
                          _nowStamp - nowStamp < 0 &&
                          _tempStudent.brrCount > 5
                        ) {
                          _tempStudent.brrCount -= 1;
                        }else{
                           _this.$axios
                          .put(
                            "http://localhost:8081/students/update",
                            _tempStudent
                          )
                          .then(function(resp) {
                            _this.$message({
                              type: "success",
                              message: "已同意归还"
                            });
                            setTimeout(function(){
                            _this.reload();
                         },1000)
                          });
                        }

                       
                      }
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
          var demoArray = [];
          for (var i = 0; i < resp.data.length; i++) {
            if (resp.data[i].retCheck == 1) {
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
