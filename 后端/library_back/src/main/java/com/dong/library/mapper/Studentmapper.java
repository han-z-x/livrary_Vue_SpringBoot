package com.dong.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dong.library.entity.Student;
import org.springframework.stereotype.Repository;

@Repository//用在持久层的接口上，这个注解是将接口的一个实现类交给spring管理。
public interface Studentmapper extends BaseMapper<Student> {
}
