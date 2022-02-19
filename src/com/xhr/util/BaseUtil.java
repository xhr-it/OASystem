package com.xhr.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * @author xhr
 * @date 2020/3/26
 *  判空以及数据类型转换工具类
**/
public class BaseUtil {
    public static boolean checkNull(Object obj){
        if(obj!=null){
            String str=obj.toString();
            if(str!=""&&!str.equals("")&&!str.trim().equals("")){
                return false;
            }
        }
        return true;
    }
    public static String transObjToStr(Object obj){
        if(obj!=null){
            return obj.toString();
        }
        return "";
    }
    public static Date transObjToSqlDate(Object obj){
        if(obj!=null){
            String dateStr=obj.toString();
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
            try {
                java.util.Date date=simpleDateFormat.parse(dateStr);
                Date dateSql=new Date(date.getTime());
                return dateSql;
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    public static int transObjToInt(Object obj){
        if(obj!=null){
            return Integer.parseInt(obj.toString());
        }
        return -1;
    }
}
