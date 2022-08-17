package com.dong.library.controller;

import com.dong.library.Service.AppointService;
import com.dong.library.entity.Appoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/appoints")
public class AppointContrller {

    @Autowired
    private AppointService appointService;

    /**
     * 找到所有预约的书籍
     * @return
     */
    @GetMapping("/findAll")
    public List<Appoint> list(){
        List<Appoint> list = appointService.findAll();
        return list;
    }

    /**
     * 添加appoint数据
     * @param appoint
     * @return
     */
    @PostMapping("/add")
    public boolean add(@RequestBody Appoint appoint){
        Boolean flage =appointService.save(appoint);
        return flage;
    }
}
