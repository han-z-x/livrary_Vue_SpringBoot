package com.dong.library.controller;

import com.dong.library.Service.SortService;
import com.dong.library.entity.Sort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/sorts")
public class SortController {

    @Autowired
    private SortService sortService;

    /**
     * 找到所有图书分类
     * @return
     */
    @GetMapping("/findAll")
    public List<Sort> list(){
        List<Sort> sortList = sortService.findAll();
        return sortList;
    }

    /**
     * 通过id查找图书分类
     * @param id
     * @return
     */
    @GetMapping("/findById/{id}")
    public Sort findById(@PathVariable("id") int id){
        Sort sort = sortService.findById(id);
        return sort;
    }

    /**
     * 更新图书分类
     * @param sort
     * @return
     */
    @PutMapping("/update")
    public String update(@RequestBody Sort sort){
        String status = sortService.updateSort(sort);
        return status;
    }

    /**
     * 通过id删除分类
     * @param id
     */
    @DeleteMapping("delete/{id}")
    public void delete(@PathVariable("id") int id){
        sortService.deleteById(id);
    }

    /**
     * 添加分类
     * @param sort
     * @return
     */
    @PostMapping("/add")
    public boolean add(@RequestBody Sort sort){
        boolean flage = sortService.insertSort(sort);
        return flage;
    }
}
