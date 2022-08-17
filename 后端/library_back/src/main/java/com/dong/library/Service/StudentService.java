package com.dong.library.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dong.library.entity.Student;
import com.dong.library.mapper.Studentmapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class StudentService {

    @Autowired
    private Studentmapper studentmapper;

    //登录时查看用户是否在表中存在,eq等值判断
    public Student findUser(Student student) {
        Student student1 = studentmapper.selectOne(new QueryWrapper<Student>()
                            .eq("username",student.getUsername())
                            .eq("pwd",student.getPwd()));
        if(student1 !=null){
            return student1;
        }
        return new Student();
    }

    //保存用户注册信息
    @Transactional
    public Student savestudent(Student student) {
        int insert = studentmapper.insert(student);
        if(insert != -1){
            return student;
        }
        return new Student();
    }

    //查看借书卡的学生的情况
    public ResponseEntity<Object> findByCardContaining(String keyword) {

        List<Student> studentList = studentmapper.selectList(new QueryWrapper<Student>().eq("card",keyword));
        if(studentList.isEmpty()){
            return new ResponseEntity<>(null, HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(studentList, HttpStatus.OK);

    }

    //更新学生的借书卡
    @Transactional
    public String updateCard(Student student) {
        int i = studentmapper.updateById(student);
        if(i != 0){
            return "success";
        }
        return "error";
    }

    /**
     * 通过id去查找学生信息
     * @return
     */
    public Student findById(int id) {
        Student student = studentmapper.selectById(id);
        return student;
    }

    /**
     * 查找所有学生
     * @return
     * queryWrapper:条件查询
     */
    public List<Student> findAll() {
        return studentmapper.selectList(null);
    }
}
