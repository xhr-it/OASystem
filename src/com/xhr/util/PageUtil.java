package com.xhr.util;

import com.xhr.entity.PageEntity;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class PageUtil {
    public static PageEntity selectByPage(String sql,PageEntity page) throws SQLException {
        DBAgent dbAgent=new DBAgent();
        int begin=(page.getNowPage()-1)*page.getRows();
        //limit (第几页-1)*每页多少条,每页多少条
        String shujuSql=sql.toString()+" limit "+begin+","+page.getRows();
        List list=dbAgent.executeQuery(shujuSql);//当前页数据
        //计算总共多少条。所有页的数据。带检索条件
        String countSql="select count(*) as allRows from( " +sql.toString()+ ")a";
        List list2=dbAgent.executeQuery(countSql);//出来只有一行一列
        int allRows=0;
        if(list2!=null&&list2.size()>0){
            Map map= (Map) list2.get(0);
            Object obj=map.get("allrows");
            if(obj!=null){
                allRows=Integer.parseInt(obj.toString());
            }
        }
        //总页数：
        int allPage=0;//整除不需要加1但是非整除需要加1
        if(allRows%page.getRows()==0){
            allPage=allRows/page.getRows();
        }else{
            allPage=allRows/page.getRows()+1;
        }
        page.setAllPage(allPage);
        page.setAllRows(allRows);
        page.setData(list);
        return page;
    }
}
