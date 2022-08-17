<!-- 学生图书借阅 -->
<template>
  <div class="bookList">
    <el-table
      :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
      border
      style="width: 100%"
    >
      <el-table-column fixed prop="bookId" label="图书编号" width="200"></el-table-column>
      <el-table-column prop="bookName" label="书名" width="200"></el-table-column>
      <el-table-column prop="brrowDate" label="借书时间" width="200"></el-table-column>
      <el-table-column prop="returnDate" label="还书截止日期" width="200"></el-table-column>

      <el-table-column fixed="right" label="操作" width="250">
        <template slot-scope="scope">
          <el-button @click="addBrrowDate(scope.row)" type="text" size="small">续借</el-button>
          <el-button @click="returnBook(scope.row)" type="text" size="small">归还</el-button>
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
  methods: {
    change(currentPage) {
      this.currentPage = currentPage;
    },
    returnBook(row) {
      var _row = row;
      // retCheck 1:提交还书申请 2.同意提交申请 。
      _row.retCheck = 1;   //设置状态
      const _this = this;
      this.$axios
        .get(
          "http://localhost:8081/brrows/searchByStuId?keyword=" +
            _this.global.stuCount
        )
        .then(function(resp) {
          var _haveAdd = false;
          for (var i = 0; i < resp.data.length; i++) {
            if (_row.id == resp.data[i].id && resp.data[i].addCheck == 1) { //续借
              _haveAdd = true;
            }
          }
          if (!_haveAdd) {
            _this.$axios
              .get(
                "http://localhost:8081/brrows/searchByStuId?keyword=" +
                  _this.global.stuCount
              )
              .then(function(resp) {
                // 归回申请一次

                var _haveRet = false;
                for (var i = 0; i < resp.data.length; i++) {
                  if (
                    resp.data[i].bookId == _row.bookId &&
                    resp.data[i].retCheck == 1
                  ) {
                    _haveRet = true;
                  }
                }
                if (!_haveRet) {
                  _this.$axios
                    .put("http://localhost:8081/brrows/update", _row)
                    .then(function(resp) {
                      // _this.$message({
                      //   message: "归还申请成功",
                      //   type: "success"
                      // });
                      _this.$axios
                        .get(
                          "http://localhost:8081/students/findById/" +
                            _this.global.stuCount
                        )
                        .then(function(resp) {
                          // console.log(resp)
                          //临时学生信息，修改timeout
                         var _temStuInfo = resp.data;
                          _temStuInfo.timeOut = 0;
                          // console.log(_temStuInfo)
                          if (_this.global.stuTimeOut == 1) {
                            _this.$axios
                              .put(
                                "http://localhost:8081/students/update",
                                _temStuInfo
                              )
                              .then(function(resp) {
                                // console.log("success")
                                _this.$message({
                                  message: "归还申请成功",
                                  type: "success"
                                });

                              });
                          } else {
                            _this.$message({
                              message: "归还申请成功",
                              type: "success"
                            });
                          }
                        });
                    });
                } else {
                  _this.$message({
                    message: "你已经提交归还书籍申请"
                  });
                }
              });
          } else {
            _this.$message({
              message: "你已经提交续借申请"
            });
          }
        });
    },
    addBrrowDate(row) {
      // console.log(row);
      // 续约申请，应该写到manager   manAddCheck

      // const _this = this;
      //  var tempDate = this.fixedBrrow.brrowDate;
      // var tempArray = tempDate.split("/");
      // if (tempArray[1] == "12") {
      //   tempArray[0] = parseInt(tempArray[0]) + 1;
      // } else {
      //   tempArray[1] = parseInt(tempArray[1]) + 1;
      // }
      // this.fixedBrrow.brrowDate = tempArray.join("/");
      var _row = row;
      const _this = this;
      _row.addCheck = 1;

      this.$axios
        .get(
          "http://localhost:8081/brrows/searchByStuId?keyword=" +
            _this.global.stuCount
        )
        .then(function(resp) {
          var _haveRet = false;  //是否还书
          for (var i = 0; i < resp.data.length; i++) {
            if (_row.id == resp.data[i].id && resp.data[i].retCheck == 1) {  //提交了还书申请
              _haveRet = true;
            }
          }
          if (!_haveRet) {
            _this.$axios
              .put("http://localhost:8081/brrows/update", _row)
              .then(function(resp) {
                _this.$message({
                  message: "续借申请成功",
                  type: "success"
                });
              });
          } else {
            _this.$message({
              message: "你已经提交还书申请！"
            });
          }
        });
    }
  },

  data() {
    return {
      pageSize: 7,
      total: 10,
      currentPage: 1,
      tableData: [
        {
          bookId: "",
          bookName: "",
          brrowDate: "",
          returnDate: "",
          brrCheck: "0",
          retCheck: "0",
          addCheck: "0"
        }
      ],
      tempTableData: []
      //更改brrow时间
    };
  },
  created() {
    //  brrCheck: 0 ：初始化   1：提交申请   2：同意申请
    const _this = this;

    if (this.global.stuCount == "") {
      _this.$message({
        message: "请重新登录"
      });
      _this.$router.push("/stuLog");
    } else {
      var demoArray = [];  //存放正在借阅书籍

      _this.$axios
        .get(
          "http://localhost:8081/brrows/searchByStuId?keyword=" +
            _this.global.stuCount
        )
        .then(function(resp) {
          // console.log(resp.data);
          _this.tempTableData = resp.data;
          // console.log(resp.data)
          // console.log(_this.tempTableData[0].returnDate.length==0)
          // console.log(_this.tempTableData[0].returnDate.length)

          // console.log(_this.tempTableData[0].returnDate.length)
          // console.log(_this.tempTableData.length)
          for (var i = 0; i < _this.tempTableData.length; i++) {
            // console.log(_this.tempTableData[i].returnDate == "")
            // console.log(_this.tempTableData[i].returnDate == "")
            if (
              _this.tempTableData[i].retCheck != 2 &&
              _this.tempTableData[i].brrCheck == 2
            ) {
              demoArray.push(_this.tempTableData[i]);
            }
          }
          // console.log(demoArray)
          _this.tableData = demoArray;
        });
    }
  }
};
</script>
<style >
</style>
