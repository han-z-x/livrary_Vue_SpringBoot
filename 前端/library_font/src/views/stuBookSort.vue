<!-- 学生图书分类 -->
<template>
  <div>
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane v-for="item in sortData" :key="item.id" :label="item.name" :name="item.id">
        <el-table
          :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
          border
          style="width: 100%;padding-top=0"
        >
          <el-table-column fixed prop="id" label="图书编号" width="150"></el-table-column>
          <el-table-column prop="name" label="书名" width="200"></el-table-column>
          <el-table-column prop="author" label="作者" width="200"></el-table-column>
          <el-table-column prop="count" label="书籍数量" width="200"></el-table-column>

          <el-table-column fixed="right" label="操作" width="250">
            <template slot-scope="scope">
              <!-- 查看图书信息 -->

              <el-button @click="showDesc(scope.row)" type="text" size="small">查看</el-button>
              <el-button @click="brrowBook(scope.row)" type="text" size="small">借阅</el-button>
              <el-button @click="appoint(scope.row)" type="text" size="small">预约</el-button>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页 -->
        <el-pagination
          style="margin-top:20px"
          @current-change="change"
          background
          layout="prev, pager, next"
          :page-size="pageSize"
          :total="tableData.length"
        ></el-pagination>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>
<script>
export default {
  data() {
    return {
      pageSize: 6,
      total: 10,
      currentPage: 1,
      sortId: "",
      activeName: 1,
      sortData: [
        {
          id: "",
          name: ""
        }
      ],

      tableData: [
        {
          id: "",
          name: "",
          author: "",
          sort: "",
          bookdesc: "",
          count: ""
        }
      ],
      brrowData: {
        id: "",
        stuId: "",
        bookId: "",
        brrowDate: "",
        returnDate: "",
        bookName: "",
        brrCheck: "",
        retCheck: "",
        addCheck: ""
      },
      appointData: {
        id: "",
        stuId: "",
        bookId: "",
        appointDate: "",
        bookName: ""
      }
    };
  },
  methods: {
    change(currentPage) {
      this.currentPage = currentPage;
    },
    //分类查询图书
    handleClick(tab, event) {
      // console.log(tab, event);
      this.sortId = parseInt(tab.index) + 1;
      const _this = this;
      // console.log(this.sortId)
      this.$axios
        .get("http://localhost:8081/books/searchBySort?keyword=" + this.sortId)
        .then(function(resp) {
          _this.tableData = resp.data;
          
        });
    },
    appoint(row) {
      var _this = this;
      if (this.global.stuCard == "0") {
        _this.$message({
          message: "暂时没有借书卡，请等候管理员审核"
        });
      } else {
        var _row = row;
        _this.appointData.bookId = row.id + "";
        _this.appointData.bookName = row.name;

        _this.appointData.stuId = _this.global.stuCount + "";
        var now = new Date();
        var nowStr =
          now.getFullYear() + "/" + (now.getMonth() + 1) + "/" + now.getDate();

        _this.appointData.appointDate = nowStr;

        // console.log(this.appointData);
        if (_row.count == 0) {
          _this.$axios
            .post("http://localhost:8081/appoints/add", _this.appointData)
            .then(function(resp) {
              // console.log("appoint");
              _this.$message({
                message: "预约成功",
                type: "success"
              });
            });
        } else {
          _this.$message({
            message: "书籍充裕，可以借阅"
          });
        }
      }
    },
    brrowBook(row) {
      // console.log(row)
      // 为了借阅申请不可以多于剩余书籍数量
      var _bookId = row.id;
      var _bookCount = row.count;
      var _row = row;
      var _this = this;
      // brrowBook 信息
      // console.log(row)
      if (this.global.stuCard == "0") {
        _this.$message({
          message: "暂时没有借书卡，请等候超级管理员审核"
        });
      }
      else {
        if (_this.global.stuTimeOut == 1) {
          _this.$message({
            message: "你有一本书已经逾期，请先还书后再来借阅！"
          });
        }
        else {
                _this.$axios
                  .get(
                    "http://localhost:8081/brrows/searchByStuId?keyword=" + _this.global.stuCount
                  )
                  .then(function(resp) {
                    //  stu 申请借书count
                    var _stuAppBrrCount = 0;
                    var _stuAppBrrCountArray = resp.data;
                    for (var i = 0; i < resp.data.length; i++) {
                      if (resp.data[i].retCheck != 2) {
                        _stuAppBrrCount = _stuAppBrrCount + 1;
                      }
                    }
              if (_stuAppBrrCount > 9) {
                _this.$message({
                  message: "你的借阅申请数量已达上限"
                });
              }
              else {
                _this.$axios
                  .get(
                    "http://localhost:8081/brrows/searchByBookId?keyword=" +
                      _bookId
                  )
                  .then(function(resp) {
                    // console.log(resp)
                    var _haveBrr = true;
                    for (var i = 0; i < resp.data.length; i++) {
                      if (
                        resp.data[i].stuId == _this.global.stuCount &&
                        (resp.data[i].brrCheck == 1 ||
                          resp.data[i].brrCheck == 2) &&
                        resp.data[i].retCheck != 2
                      ) {
                        _haveBrr = false;
                      }
                    }
                    if (_haveBrr) {
                      if (_this.global.stuBrrCount == 0) {
                        _this.$message({
                          message: "你借书的数量已经达到上限！"
                        });
                      }
                      else {
                        _this.brrowData.bookId = row.id + "";
                        _this.brrowData.bookName = row.name;
                        _this.brrowData.stuId = _this.global.stuCount;

                        _this.brrowData.retCheck = "0";
                        _this.brrowData.addCheck = "0";

                        var now = new Date();
                        var nowStr =
                          now.getFullYear() +
                          "/" +
                          (now.getMonth() + 1) +
                          "/" +
                          now.getDate();
                        _this.brrowData.brrowDate = nowStr;

                        if (_row.count > 0) {
                          // 设置申请借书数量
                          _this.$axios
                            .get(
                              "http://localhost:8081/brrows/searchByBookId?keyword=" +
                                _bookId
                            )
                            .then(function(resp) {
                              // console.log(resp.data)
                              var _count = 1;
                              for (var i = 0; i < resp.data.length; i++) {
                                if (resp.data[i].brrCheck == 1) {
                                  _count = _count + 1;
                                }
                              }
                              if (_count > _bookCount) {
                                _this.$message({
                                  message: "借阅申请已满，请稍后借阅",
                                  type: "warning"
                                });
                              } else {
                                _this.brrowData.brrCheck = 1;
                                _this.$axios
                                  .post(
                                    "http://localhost:8081/brrows/add",
                                    _this.brrowData
                                  )
                                  .then(function(resp) {
                                    _this.$message({
                                      message: "提交借书申请成功",
                                      type: "success"
                                    });
                                  });
                              }
                            });
                        } else {
                          // alert("书籍已被借完，可以预约");
                          _this.$message({
                            message: "书籍已被借完，可以预约",
                            type: "warning"
                          });
                        }
                      }
                    } else {
                      _this.$message({
                        message: "你已经借阅过了，"
                      });
                    }
                  });
              }
            });
        }
      }
    },
    showDesc(row) {
      var _row = row;
      const _this = this;
      if (!_row.bookdesc.length == 0) {
        _this.$message({
          message: _row.bookdesc,
          center: true,
          showClose: true,
          duration: 5000,
          type: "success"
        });
      }
    }
  },
  created() {
    const _this = this;

    if (_this.global.stuCount == "") {
      _this.$message({
        message: "请重新登录"
      });
      _this.$router.push("/stuLog");
    } else {
      _this.brrowData.stuId = _this.global.stuCount;
      _this.$axios
        .get("http://localhost:8081/books/searchBySort?keyword=1")
        .then(function(resp) {
          _this.tableData = resp.data;
        });

      _this.$axios
        .get("http://localhost:8081/sorts/findAll")
        .then(function(resp) {
          _this.sortData = resp.data;
          // console.log(resp)
          // console.log(_this.sortData);
        });
    }
  }
};
</script>
