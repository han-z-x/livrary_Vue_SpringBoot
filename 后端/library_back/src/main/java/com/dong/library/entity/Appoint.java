package com.dong.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import javax.persistence.Entity;
import javax.persistence.Id;

//预约图书实体
@Entity //定义Appoint为实体类
@Data  // 自动生成各种各样的getter和setter方法
public class Appoint {
    @Id//绑定Appoint表里面的id
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String stuId;
    private String bookId;
    private String appointDate;
    private String bookName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getAppointDate() {
        return appointDate;
    }

    public void setAppointDate(String appointDate) {
        this.appointDate = appointDate;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    @Override
    public String toString() {
        return "Appoint{" +
                "id=" + id +
                ", stuId='" + stuId + '\'' +
                ", bookId='" + bookId + '\'' +
                ", appointDate='" + appointDate + '\'' +
                ", bookName='" + bookName + '\'' +
                '}';
    }
}
