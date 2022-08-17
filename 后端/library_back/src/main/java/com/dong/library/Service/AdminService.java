package com.dong.library.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dong.library.entity.Admin;
import com.dong.library.mapper.Adminmapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class AdminService {

    @Autowired//对成员变量、方法和构造函数进行标注，来完成自动装配的工作
             // 根据类型进行自动装配的。
    private Adminmapper adminmapper;

    public Admin findAdmin(Admin admin) {
        Admin admin1 = adminmapper.selectOne(new QueryWrapper<Admin>()
                       .eq("username",admin.getUsername())
                       .eq("pwd",admin.getPwd()));
        if(admin1 !=null){
            return admin1;
        }
        return new Admin();
    }

    /**
     * 通过名字去查找
     * @param name
     * @return
     * QueryWrapper：条件构造器
     */
    public Admin findbyname(String name) {
        Admin name1 = adminmapper.selectOne(new QueryWrapper<Admin>().eq("name", name));
        return name1;
    }

    /**
     * 更新系统管理员信息
     * @param admin
     * @return
     */
    @Transactional
    public String updateAdmin(Admin admin) {
        int i = adminmapper.update(admin,new QueryWrapper<Admin>().eq("id",admin.getId()));
        if(i != 0){
            return "success";
        }
        return "error";
    }

    /**
     * 通过id去查找
     * @param id
     * @return
     */
    public Admin findbyId(int id) {
        Admin admin = adminmapper.selectById(id);
        return admin;
    }

    /**
     * 获取所有管理员信息
     * @return
     */
    public List<Admin> findAll() {
        List<Admin> admins = adminmapper.selectList(null);
        return admins;
    }
}
