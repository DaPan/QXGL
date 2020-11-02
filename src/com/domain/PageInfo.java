package com.domain;

import java.io.Serializable;
import java.util.List;

/**
 * 装载分页数据
 */
public class PageInfo implements Serializable {
    private Integer maxPage;
    private List<?> list;

    public Integer getMaxPage() {
        return maxPage;
    }

    public void setMaxPage(Integer maxPage) {
        this.maxPage = maxPage;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }

    public PageInfo(Integer maxPage, List<?> list) {
        this.maxPage = maxPage;
        this.list = list;
    }

    public PageInfo() {
    }
}
