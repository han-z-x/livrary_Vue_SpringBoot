<!--  学生主页-->
<template>
  <div>
    <el-container style="height: 500px; border: 1px solid #eee" router>
      <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
        <el-menu :default-openeds="['1', '2']">
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-message"></i>图书管理
            </template>
            <el-menu-item-group>
              <el-menu-item index="1-1"><router-link to='/stuBookLook'>浏览图书</router-link></el-menu-item>
              <el-menu-item index="1-2"><router-link to='/stuBookQuery'>查询图书</router-link></el-menu-item>
              <el-menu-item index="1-3"><router-link to='/stuBookSort'>图书分类</router-link> </el-menu-item>
              <el-menu-item index="1-4"><router-link to='/stuBookBorrow'>已借图书</router-link></el-menu-item>
              <el-menu-item index="1-5"><router-link to='/stuBrrHistory'>已还图书</router-link></el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-menu"></i>信息管理
            </template>
            <el-menu-item-group>
              <el-menu-item index="2-1"><router-link to='/stuInfo'>个人信息</router-link></el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-container>
        <el-header style="text-align: right; font-size: 12px">
          <span>{{userName}}</span>
          <el-dropdown>
            <i class="el-icon-setting" style="margin-right: 15px"></i>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item><router-link :to="{path:'stuLog'}">退出登录</router-link> </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-header>
        <el-main>
           <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>



<style>
.el-header {
  background-color: #f8f8f8;
  color: #333;
  line-height: 50px;
}

.el-aside {
  color: #333;

}
a{
  text-decoration: none;
  color: black;
}
.router-link-active{
  text-decoration: none;
  color: black;
}
</style>

<script>
export default {
  data() {
    return {
      userName:this.global.stuName,
    }
  },
};
</script>
