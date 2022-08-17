package com.dong.library.controller;

import com.dong.library.Service.ManagerService;
import com.dong.library.entity.Manager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/managers")
public class ManagerController {

    @Autowired
    private ManagerService managerService;

    /**
     * 找到所有员工
     * @return
     */
    @GetMapping("findAll")
    public List<Manager> list(){
        List<Manager> managerList = managerService.findAll();
        return managerList;
    }

    /**
     * 员工登录
     * @param manager
     * @return
     */
    @PostMapping("/findById")  //RequestBody:
    public Manager findByManager(@RequestBody Manager manager){
        Manager manager1 = managerService.findManager(manager);
        return manager1;
    }

    //通过id查找员工
    @GetMapping("findById/{id}")
    public Manager findManagerById(@PathVariable("id") int id){
        Manager manager = managerService.FindById(id);
        return manager;
    }

    //更新员工信息
    @PutMapping("/update")
    public String update(@RequestBody Manager manager){
         String status= managerService.updateManager(manager);
         return status;
    }

    //添加员工
    @PostMapping("/add")
    public boolean add(@RequestBody Manager manager){
        boolean flage = managerService.addManager(manager);
        return flage;
    }

    /**
     * 删除员工
     * @param id
     */
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable("id") int id){
        managerService.deleteManager(id);
    }

}
