package com.dong.library.controller;

import com.dong.library.Service.StudentService;
import com.dong.library.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    /**
     * 查询所有Student
     * @return
     */
    @GetMapping("/findAll")
    public List<Student>list(){
        List<Student> studentList=studentService.findAll();
        return studentList;
    }

    /**
     * 通过名字去查寻
     * @param
     * @return
     */
    @PostMapping("/findById")
    public Student findByName(@RequestBody Student student){
        Student student1 = studentService.findUser(student);
        return student1;
    }

    /**
     * 通过id去查找学生信息
     * @param id
     * @return
     */
    @GetMapping("/findById/{id}")
    public Student findById(@PathVariable("id") int id){
         Student student = studentService.findById(id);
         return student;
    }

    /**
     * 添加学生
     * @param student
     * @return
     */
    @PostMapping("/add")
    public String add(@RequestBody Student student){
        Student save =  studentService.savestudent(student);
        return save.toString();
    }

    /**
     * 修改学生信息
     * @param student
     * @return
     */
    @PutMapping("/update")
    public String update(@RequestBody Student student){
         String status =  studentService.updateCard(student);  //返回修改成功与否
         return status;
    }

    //查询学生借书证的情况
    @GetMapping("/searchByCard")
    public ResponseEntity<Object> searchByCard(@RequestParam("keyword") String keyword){
        ResponseEntity<Object> responseEntity = studentService.findByCardContaining(keyword);
        return responseEntity;
    }
}
