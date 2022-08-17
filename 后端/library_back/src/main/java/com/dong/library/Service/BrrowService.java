package com.dong.library.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dong.library.entity.Brrow;
import com.dong.library.entity.Rank;
import com.dong.library.mapper.Brrowmapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Service
public class BrrowService {

    @Autowired
    private Brrowmapper brrowmapper;

    /**
     * 找到所有的图书
     * @return
     */
    public List<Brrow> findAll() {
        List<Brrow> brrowList = brrowmapper.selectList(null);
        return brrowList;
    }

    /**
     * 处理图书借阅排行
     * @return
     */
    public List<Rank> bookRank() {
        List<Brrow> brrowList = findAll();
        List<Rank> rankList = new ArrayList<>();
        int length = brrowList.size();
        int t=length-1;
        int i,j;
        for ( i = 0; i < t-1; i++) {
            int count = 1;
            Rank rank = new Rank();
            for (j = t; j > i; j--) {
                if (brrowList.get(i).getBookId().equals(brrowList.get(j).getBookId()) ) {
                    count++;
                    brrowList.remove(j);
                    t--;
                }
            }
            rank.setBrrCount(count);
            rank.setId(brrowList.get(i).getBookId());
            rank.setName(brrowList.get(i).getBookName());
            rankList.add(rank);
        }
        //List.sort()
        //进行排序
        rankList.sort(Comparator.comparing(Rank::getBrrCount).reversed());
        return rankList;
    }

    /**
     * 通过学生id查询图书
     * @param keyword
     * @return
     */
    public ResponseEntity<Object> findByStuIdContaining(String keyword) {
        List<Brrow> brrowList = brrowmapper.selectList(new QueryWrapper<Brrow>().eq("stu_id", keyword));
        if(brrowList.isEmpty()){
            return new ResponseEntity<>(null, HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(brrowList, HttpStatus.OK);
    }

    /**
     * 通过图书id查找图书
     * @param keyword
     * @return
     */
    public ResponseEntity<Object> findByBookId(String keyword) {
        List<Brrow> brrowList = brrowmapper.selectList(new QueryWrapper<Brrow>().eq("book_id", keyword));
        if(brrowList.isEmpty()){
            return new ResponseEntity<>(null, HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(brrowList, HttpStatus.OK);
    }

    /**
     * 保存借书记录
     * @param brrow
     * @return
     */
    @Transactional
    public boolean save(Brrow brrow) {
        int insert = brrowmapper.insert(brrow);
        if(insert !=-1){
            return true;
        }
        return false;
    }

    /**
     * 借书数据更新
     * @param brrow
     * @return
     */
    @Transactional
    public String updateBrrow(Brrow brrow) {
        int i = brrowmapper.updateById(brrow);
        if(i != 0){
            return "success";
        }
        return "error";
    }
}
