package com.dong.library.controller;

import com.dong.library.Service.AdminService;
import com.dong.library.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController//等于@ResponseBody+@Controller，
              // 代表这是一个Controller类，并且将返回的数据对象转换为json格式
@RequestMapping("/admins") //代表对指定的请求路径进行响应,一级路径
public class AdminController {

    @Autowired //对成员变量、方法和构造函数进行标注，来完成自动装配的工作
             // 根据类型进行自动装配的。
    private AdminService adminService;

    /**
     * 获取所有管理员
     * @return
     */
    @GetMapping("/findAll") //get请求使用GetMapping
    public List<Admin> list(){
        List<Admin> adminList=adminService.findAll();
        return adminList;
    }

    /**
     * 管理员登录
     * @param admin
     * @return
     */
    @PostMapping("/findById")  //@RequestBody:用于读取http请求的内容(字符串)
    // 通过springmvc提供的HttpMessageConverter接口将读到的内容（json数据）转换为java对象并绑定到Controller方法的参数上。
    public Admin findByAdmin(@RequestBody Admin admin){
        Admin admin1 =  adminService.findAdmin(admin);
        return admin1;
    }

    /**
     * 通过名字查找
     * @param name
     * @return
     */
    @GetMapping("/findByName/{name}")
    public Admin findByName(@PathVariable("name") String name ){
        Admin admin1 = adminService.findbyname(name);

        return admin1;
    }

    /**
     * 通过id查找
     * @param
     * @return
     */
    @GetMapping("/findById/{id}")
    public Admin findById(@PathVariable("id") int id ){
        Admin admin1 = adminService.findbyId(id);
        return admin1;
    }

    /**
     * 更新员工信息
     * @param admin
     * @return
     */
    @PutMapping("/update")
    public String update(@RequestBody Admin admin){
        String status = adminService.updateAdmin(admin);
        return status;
    }
}
