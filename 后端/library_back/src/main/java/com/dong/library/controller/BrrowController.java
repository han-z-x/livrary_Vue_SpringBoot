package com.dong.library.controller;

import com.dong.library.Service.BrrowService;
import com.dong.library.entity.Brrow;
import com.dong.library.entity.Rank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/brrows")
public class BrrowController {

    @Autowired
    private BrrowService brrowService;

    /**
     * 找到所有借阅图书
     * @return
     */
    @GetMapping("/findAll")
    public List<Brrow> list(){
        List<Brrow> brrowList = brrowService.findAll();
        return brrowList;
    }

    /**
     * 处理图书借阅排行
     * @return
     */
    @GetMapping("/findRank")
    public List<Rank> brrList(){
        List<Rank> rankList = brrowService.bookRank();
        return rankList;
    }

    /**
     * 添加brrow记录
     * @param brrow
     * @return
     */
    @PostMapping("/add")
    public boolean add(@RequestBody Brrow brrow){
        boolean flage = brrowService.save(brrow);
        return flage;
    }

    /**
     * 通过学生id查看图书
     * @param keyword
     * @return
     */
    @GetMapping("/searchByStuId")
    public ResponseEntity<Object> searchByStuId(@RequestParam("keyword") String keyword){
         ResponseEntity<Object> responseEntity= brrowService.findByStuIdContaining(keyword);
         return responseEntity;
    }

    /**
     * 通过图书id查找图书
     * @param keyword
     * @return
     */
    @GetMapping("/searchByBookId")
    public ResponseEntity<Object> searchByBookId(@RequestParam("keyword") String keyword){
        ResponseEntity<Object> responseEntity = brrowService.findByBookId(keyword);
        return responseEntity;
    }



    /**
     * 借书数据更新
     * @param brrow
     * @return
     */
    @PutMapping("/update")
    public String update(@RequestBody Brrow brrow){
        String status =  brrowService.updateBrrow(brrow);

        return status;
    }
}
