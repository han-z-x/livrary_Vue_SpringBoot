package com.dong.library.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

//作用于类上表示这是一个配置类，可理解为用spring的时候xml里面的< beans>标签
@Configuration
//com.dong.library.mapper下面的接口类，在编译之后都会生成相应的实现类
//开启mapper的扫描配置，扫描com.dong.library.mapper目录下的所有Mapper文件作为Mapper接口类
@MapperScan("com.dong.library.mapper")
public class MpConfig {

    /**
     * 分页插件
     * @return
     */
    @Bean
    public PaginationInterceptor paginationInterceptor(){
        return new PaginationInterceptor();
    }
}
