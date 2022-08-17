package com.dong.library.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dong.library.Service.BookService;
import com.dong.library.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * controller控制层
 */
@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    /**
     * 找到所有书籍
     * @return
     */
    @GetMapping("/findAll")
    public List<Book> list(){
        List<Book> bookList = bookService.findAll();

        return bookList;
    }

    /**
     * 分页查询数据
     * @param page
     * @param size
     * @return
     */
    @GetMapping("/findAll/{page}/{size}")
    public Page<Book> listByPage(@PathVariable("page") int page,@PathVariable("size") int size){
        Page<Book> all = bookService.findByPage(page,size);

        return all;
    }

    /**
     * 根据id获取book
     * @param id
     * @return
     */
    @GetMapping("/findById/{id}")
    public Book findById(@PathVariable("id") int id){
        Book book = bookService.findById(id);
        return book;
    }

    /**
     * 修改图书信息
     * @param book
     * @return
     */
    @PutMapping("/update")
    public String update(@RequestBody Book book){
         String status = bookService.updateBook(book);
         return status;
    }

    /**
     * 根据id删除图书
     * @param id
     */
    @DeleteMapping("/delete/{id}")  //PathVariable:获取路径参数,即url/{id}这种形式
    public void delete(@PathVariable("id") int id){
        bookService.deleteById(id);
    }

    /**
     * 添加图书
     * @param book
     * @return
     */
    @PostMapping("/add")
    public boolean add(@RequestBody Book book){
        Boolean falg = bookService.save(book);
        return falg;
    }

    /**
     * 通过关键字来查询数据
     * @param keyword
     * @return
     */
    @GetMapping("/search")     //RequestParam:获取查询参数
    public ResponseEntity<Object> search(@RequestParam("keyword") String keyword){
        ResponseEntity<Object> responseEntity = bookService.searchByKey(keyword);
        return responseEntity;
    }

    /**
     * 根据sort查询符合书籍
     * @param keyword
     * @return
     */
    @GetMapping("/searchBySort")
    public ResponseEntity<Object> searchBySort(@RequestParam("keyword") String keyword){
        ResponseEntity<Object> responseEntity = bookService.searchBysort(keyword);
        return responseEntity;
    }
}
