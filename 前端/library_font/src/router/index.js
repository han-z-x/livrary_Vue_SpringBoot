import Vue from 'vue'

import Router from 'vue-router'
import stuLog from "../views/stuLog.vue"
import stuRegistry from "../views/stuRegistry.vue"
import student from "../views/student.vue"
import stuBookLook from "../views/stuBookLook.vue"
import stuBookBorrow from "../views/stuBookBorrow.vue"
import stuBookQuery from "../views/stuBookQuery.vue"
import stuBookSort from "../views/stuBookSort.vue"
import stuInfo from "../views/stuInfo.vue"
import stuBrrHistory from "../views/stuBrrHistory.vue"

import manager from "../views/manager.vue"

import manBookLook from "../views/manBookLook.vue"
import manAddBook from "../views/manAddBook.vue"
import manUpdateBook from "../views/manUpdateBook.vue"
import manBrrCheck from "../views/manBrrCheck.vue"
import manAddCheck from "../views/manAddCheck.vue"
import manRetCheck from "../views/manRetCheck.vue"
import manBrrInfo from "../views/manBrrInfo.vue"
import manRetInfo from "../views/manRetInfo.vue"
import manBrrTotalInfo from "../views/manBrrTotalInfo.vue"
import manAppointInfo from "../views/manAppointInfo.vue"
import manInfo from "../views/manInfo.vue"

import admin from "../views/admin.vue"
import admAddCard from "../views/admAddCard.vue"
import admDeleteCard from "../views/admDeleteCard.vue"
import admManLook from "../views/admManLook.vue"
import admAddMan from "../views/admAddMan.vue"
import admUpdateMan from "../views/admUpdateMan.vue"
import admSortLook from "../views/admSortLook.vue"
import admAddSort from "../views/admAddSort.vue"
import admUpdateSort from "../views/admUpdateSort.vue"
import admBrrInfo from "../views/admBrrInfo.vue"
import admRetInfo from "../views/admRetInfo.vue"
import admTotalBrrInfo from "../views/admTotalBrrInfo.vue"
import admInfo from "../views/admInfo.vue"

Vue.use(Router)

export default new Router({
  mode: 'hash',
  routes: [
    {
      path:'',
      redirect:'/stuLog'
    },
    //登录路由
    {
      path: '/stuLog',
      name: 'stuLog',
      component: stuLog
    },
    //注册路由
    {
      path: '/stuRegistry',
      name: 'stuRegistry',
      component: stuRegistry
    },

    //学生路由
    {
      path: '/student',
      name: 'student',
      redirect: '/stuBookLook',
      component: student,
      children: [
        {
          path: '/stuBookLook',
          name: 'stuBookLook',
          show: true,
          component: stuBookLook
        },
        {
          path: '/stuInfo',
          name: 'stuInfo',
          component: stuInfo
        },

        {
          path: '/stuBookBorrow',
          name: 'stuBookBorrow',
          component: stuBookBorrow
        },
        {
          path: '/stuBrrHistory',
          name: 'stuBrrHistory',
          component: stuBrrHistory
        },
        {
          path: '/stuBookSort',
          name: 'stuBookSort',
          component: stuBookSort
        }
        ,
        {
          path: '/stuBookQuery',
          name: 'stuBookQuery',
          component: stuBookQuery
        }
      ]

    },
    //员工路由
    {
      path: '/manager',
      name: 'manager',
      component: manager,
      redirect: '/manBookLook',
      children: [

        {
          path: '/manBookLook',
          name: 'manBookLook',
          component: manBookLook
        },
        {
          path: '/manAddBook',
          name: 'manAddBook',
          component: manAddBook
        },
        {
          path: '/manUpdateBook',
          name: 'manUpdateBook',
          component: manUpdateBook
        },
        {
          path: '/manBrrCheck',
          name: 'manBrrCheck',
          component: manBrrCheck
        },
        {
          path: '/manAddCheck',
          name: 'manAddCheck',
          component: manAddCheck
        },
        {
          path: '/manRetCheck',
          name: 'manRetCheck',
          component: manRetCheck
        },
        {
          path: '/manBrrInfo',
          name: 'manBrrInfo',
          component: manBrrInfo
        },
        {
          path: '/manAppointInfo',
          name: 'manAppointInfo',
          component: manAppointInfo
        },
        {
          path: '/manRetInfo',
          name: 'manRetInfo',
          component: manRetInfo
        },
        {
          path: '/manBrrTotalInfo',
          name: 'manBrrTotalInfo',
          component: manBrrTotalInfo
        },

        {
          path: '/manInfo',
          name: 'manInfo',
          component: manInfo
        }
      ]
    },
    //管理员路由
    {
      path: '/admin',
      name: 'admin',
      component: admin,
      redirect: '/admAddCard',
      children:[
        {
          path:'/admAddCard',
          name:'admAddCard',
          component:admAddCard
        },
        {
          path:'/admDeleteCard',
          name:'admDeleteCard',
          component:admDeleteCard
        },
        {
          path:'/admManLook',
          name:'admManLook',
          component:admManLook
        },
        {
          path:'/admAddMan',
          name:'admAddMan',
          component:admAddMan
        },
        {
          path:'/admUpdateMan',
          name:'admUpdateMan',
          component:admUpdateMan
        },
        {
          path:'/admSortLook',
          name:'admSortLook',
          component:admSortLook
        },
        {
          path:'/admAddSort',
          name:'admAddSort',
          component:admAddSort
        },
        {
          path:'/admUpdateSort',
          name:'admUpdateSort',
          component:admUpdateSort
        },
        {
          path:'/admBrrInfo',
          name:'admBrrInfo',
          component:admBrrInfo
        },
        {
          path:'/admRetInfo',
          name:'admRetInfo',
          component:admRetInfo
        },
        {
          path:'/admTotalBrrInfo',
          name:'admTotalBrrInfo',
          component:admTotalBrrInfo
        },
        {
          path:'/admInfo',
          name:'admInfo',
          component:admInfo
        }
      ]
    }


  ],


})
