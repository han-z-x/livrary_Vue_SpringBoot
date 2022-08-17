package com.dong.library.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dong.library.entity.Sort;
import com.dong.library.mapper.Sortmapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class SortService {
    @Autowired
    private Sortmapper sortmapper;

    /**
     * 找到所有图书分类
     * @return
     */
    public List<Sort> findAll() {
        return sortmapper.selectList(null);
    }

    /**
     * 通过id删除图书
     * @param id
     */
    @Transactional
    public void deleteById(int id) {
        sortmapper.deleteById(id);
    }

    /**
     * 通过id查找图书分类
     * @param id
     * @return
     */
    public Sort findById(int id) {
        Sort sort = sortmapper.selectById(id);
        if(sort !=null){
            return sort;
        }
        return new Sort();
    }

    /**
     * 更新图书分类
     * @return
     */
    @Transactional
    public String updateSort(Sort sort) {
        int i = sortmapper.update(sort, new QueryWrapper<Sort>().eq("id", sort.getId()));
        if(i != 0){
            return "success";
        }
        return "error";
    }

    /**
     * 新增图书分类
     * @param sort
     * @return
     */
    public boolean insertSort(Sort sort) {
        int insert = sortmapper.insert(sort);
        if(insert != -1){
            return true;
        }
        return false;
    }
}
