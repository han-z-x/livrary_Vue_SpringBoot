<!-- 1-3-3 人员  图书借书排行榜 -->
<template>
  <div>
    <h1 style="color:#303133;text-align:center;font-size:24px;margin-bottom:50px">图书借阅排行榜</h1>
    <div class="bookName" style="width:20%;height:150px;float: left">
      <div
        v-for="(item, index) in bookInfo"
        :key="index"
        style="height:30px;line-hieght:30px;text-align:center"
      >{{item.name}}</div>
    </div>
    <div class="rank" style="width:80%;float:left">
      <el-progress
        :text-inside="true"
        :stroke-width="30"
        :percentage="parseInt(bookInfo[0].brrCount/totalBrrCount*100)"
      ></el-progress>
      <el-progress :text-inside="true" :stroke-width="30" :percentage="parseInt(bookInfo[1].brrCount/totalBrrCount*100)" status="success"></el-progress>
      <el-progress :text-inside="true" :stroke-width="30" :percentage="parseInt(bookInfo[2].brrCount/totalBrrCount*100)" status="exception"></el-progress>
      <el-progress :text-inside="true" :stroke-width="30" :percentage="parseInt(bookInfo[3].brrCount/totalBrrCount*100)"></el-progress>
      <el-progress :text-inside="true" :stroke-width="30" :percentage="parseInt(bookInfo[4].brrCount/totalBrrCount*100)" status="success"></el-progress>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      //图书所有信息
      bookInfo: [],
      totalBrrCount: 0
    };
  },
  methods: {},
  created() {
    const _this = this;
    if (this.global.admCount == "") {
      _this.$message({
        message: "请重新登录"
      });
      _this.$router.push("/stuLog");
    } else {
      _this.$axios
        .get("http://localhost:8081/brrows/findRank")
        .then(function(resp) {
          _this.bookInfo = resp.data;
          // console.log(_this.bookInfo)
          for (var i = 0; i < resp.data.length; i++) {
            _this.totalBrrCount += parseInt(resp.data[i].brrCount);
          }

          _this.bookInfo = _this.bookInfo.splice(0, 5);
        });
    }
  }
};
</script>

<style></style>
