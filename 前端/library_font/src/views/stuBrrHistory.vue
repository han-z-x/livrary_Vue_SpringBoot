 <template>
  <el-table :data="tableData" style="width: 100%">
    <el-table-column prop="bookId" label="书籍编号" width="250"></el-table-column>
    <el-table-column prop="bookName" label="书名" width="250"></el-table-column>
    <el-table-column prop="brrowDate" label="借书时间" width="250"></el-table-column>
    <el-table-column prop="returnDate" label="还书时间" width="250" ></el-table-column>
  </el-table>
</template>

  <script>
export default {
  data() {
    return {
      tableData: [
        {
          bookId: "",
          bookName: "",
          brrowDate: "",
          returnDate: ""
        }
      ]
    };
  },
  created(){
      const _this=this;
      if (this.global.stuCount == "") {
      _this.$message({
        message: "请重新登录"
      });
      _this.$router.push("/stuLog");
    } else {
        _this.$axios.get("http://localhost:8081/brrows/searchByStuId?keyword="+_this.global.stuCount).then(function(resp){
            var _tableDate=[];
            for(var i=0;i<resp.data.length;i++){
                if(resp.data[i].retCheck==2){
                    _tableDate.push(resp.data[i])
                }
            }
            _this.tableData=_tableDate;
            
        })

    }
  }
};
</script>
