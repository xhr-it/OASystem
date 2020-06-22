package com.xhr.entity;

import java.util.List;
import java.util.Map;

/**
 * 为分页服务的一个实体
 */
public class PageEntity {
    private int nowPage;//第几页
    private int rows;
    private int allPage;
    private int allRows;
    private List<Map> data;//当前页数据
    public int getAllPage() {
        return allPage;
    }

    public void setAllPage(int allPage) {
        this.allPage = allPage;
    }

    public int getAllRows() {
        return allRows;
    }

    public void setAllRows(int allRows) {
        this.allRows = allRows;
    }

    public List<Map> getData() {
        return data;
    }

    public void setData(List<Map> data) {
        this.data = data;
    }


    public int getNowPage() {
        return nowPage;
    }

    public void setNowPage(int nowPage) {
        this.nowPage = nowPage;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    @Override
    public String toString(){
        return rows+"---------"+nowPage;
    }
}
