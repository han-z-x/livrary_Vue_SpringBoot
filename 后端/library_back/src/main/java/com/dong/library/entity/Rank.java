package com.dong.library.entity;

import lombok.Data;

/**
 * 用来统计借阅排行榜
 */
@Data
public class Rank {

    private String id;
    private String name;
    private Integer brrCount;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getBrrCount() {
        return brrCount;
    }

    public void setBrrCount(Integer brrCount) {
        this.brrCount = brrCount;
    }

    @Override
    public String toString() {
        return "Rank{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", brrCount=" + brrCount +
                '}';
    }
}
