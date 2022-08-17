package com.dong.library;

import com.dong.library.entity.Student;
import com.dong.library.mapper.Studentmapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class LibraryApplicationTests {
    @Autowired
    private Studentmapper studentmapper;

    @Test
    void contextLoads() {
        Student student = studentmapper.selectById(100049);
        System.out.println(student.getName());
    }

}
