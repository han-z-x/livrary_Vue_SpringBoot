package com.dong.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dong.library.entity.Admin;
import org.springframework.stereotype.Repository;
/**
 *
 * @repository则需要在Spring中配置扫描包地址，然后生成dao层的bean，
 * 之后被注入到ServiceImpl中。
 */
@Repository //用在持久层的接口上，这个注解是将接口的一个实现类交给spring管理。
public interface Adminmapper extends BaseMapper<Admin> {
}
