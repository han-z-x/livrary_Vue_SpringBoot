package com.dong.library.Service;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dong.library.entity.Manager;
import com.dong.library.mapper.Managermapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ManagerService {

    @Autowired
    //导入 Mapper 下的 Managermapper 数据库接口
    private Managermapper managermapper;

    /**
     * 员工登录
     * @param manager
     * @return
     */
    public Manager findManager(Manager manager) {
        Manager manager1 = managermapper.selectOne(new QueryWrapper<Manager>()
                            .eq("username",manager.getUsername())
                            .eq("pwd",manager.getPwd()));

        if(manager1 != null){
            return manager1;
        }
        return new Manager();
    }

    /**
     * 根据id删除员工
     * @param id
     */
    public void deleteManager(int id) {
        managermapper.deleteById(id);
    }

    /**
     * 通过id查找员工
     * @param id
     * @return
     */
    public Manager FindById(int id) {
        Manager manager = managermapper.selectById(id);
        return manager;
    }

    /**
     * 更新员工信息
     * @param manager
     * @return
     */
    public String updateManager(Manager manager) {
        int i = managermapper.update(manager, new QueryWrapper<Manager>().eq("id", manager.getId()));
        if(i != 0){
            return "success";
        }
        return "error";
    }

    /**
     * 添加员工操作
     * @param manager
     * @return
     */
    public boolean addManager(Manager manager) {
        int insert = managermapper.insert(manager); //调用API接口实现插入数据操作

        if(insert !=-1){
            return true;
        }
        return false;
    }

    /**
     * 找到所有员工
     * @return
     */
    public List<Manager> findAll() {
        return managermapper.selectList(null);
    }
}
