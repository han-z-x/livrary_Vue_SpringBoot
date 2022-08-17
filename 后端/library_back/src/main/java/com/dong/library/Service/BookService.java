package com.dong.library.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dong.library.entity.Book;
import com.dong.library.mapper.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookService {

    @Autowired
    private BookMapper bookMapper;

    /**
     * 通过分页查找图书
     * @param page
     * @param size
     * @return
     */
    public Page<Book> findByPage(int page, int size) {
        Page<Book> page1 = new Page<>(page, size);
        Page<Book> bookPage = bookMapper.selectPage(page1, null);
        return bookPage;
    }

    /**
     * 通过关键字来查询数据
     * @param keyword
     * @return
     * 逻辑判断使用Wrapper来处理（Map只能做等值判断）
     */
    public ResponseEntity<Object> searchByKey(String keyword) {
        List<Book> books = bookMapper.selectList(new QueryWrapper<Book>()
                .like("id", keyword).or()
                .like("name", keyword).or()
                .like("author", keyword));
        if (books.isEmpty()) {
            return new ResponseEntity<>(null, HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(books, HttpStatus.OK);
    }

    /**
     * 根据sort查询符合书籍
     * @param keyword
     * @return
     */
    public ResponseEntity<Object> searchBysort(String keyword) {
        List<Book> sort = bookMapper.selectList(new QueryWrapper<Book>().eq("sort", keyword));
        if (sort.isEmpty()) {
            return new ResponseEntity<>(null, HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(sort, HttpStatus.OK);
    }

    /**
     * 找到所有图书
     * @return
     */
    public List<Book> findAll() {
        return bookMapper.selectList(null);
    }

    /**
     * 根据id获取book
     * @param id
     * @return
     */
    public Book findById(int id) {
        Book book = bookMapper.selectById(id);
        if (book != null) {
            return book;
        }
        return new Book();
    }

    /**
     * 员工修改图书信息
     * @param book
     * @return
     */
    @Transactional
    public String updateBook(Book book) {
        int i = bookMapper.updateById(book);
        if (i != 0) {
            return "success";
        }
        return "error";
    }

    /**
     * 根据id删除图书
     * @param id
     */
    @Transactional
    public void deleteById(int id) {
        bookMapper.deleteById(id);
    }

    /**
     * 添加图书
     * @param book
     * @return
     */
    @Transactional
    public Boolean save(Book book) {
        int insert = bookMapper.insert(book);
        if(insert != -1){
            return true;
        }
        return false;
    }
}
