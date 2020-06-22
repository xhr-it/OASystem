package com.xhr.util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.*;

public class DBAgent {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    /**
     * 数据源是共享的（数据库连接池）
     */
    static DataSource ds;
    static {
        //获取数据源
        try {
            Context context=new InitialContext();
            ds= (DataSource) context.lookup("java:comp/env/jdbc/oa");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public Connection getConn() throws SQLException {
        conn = ds.getConnection();
        return conn;
    }
    public List<Map> executeQuery(String sql,Object... objects) throws SQLException {
        List list = new ArrayList();
        try{
            conn = getConn();
            pstmt = conn.prepareStatement(sql);
            if (objects != null&&objects.length>0) {
                for (int i = 0; i < objects.length; i++) {
                    pstmt.setObject(i+1,objects[i]);
                }
            }
            rs = pstmt.executeQuery();
            ResultSetMetaData metaData = rs.getMetaData();
            int colnum = metaData.getColumnCount();
            while (rs.next()){
                Map map = new HashMap();
                for (int i = 1; i <= colnum; i++) {
                    String cloname = metaData.getColumnName(i);
                    Object value = rs.getObject(i);
                    map.put(cloname.toLowerCase(),value);
                }
                list.add(map);
            }
        }finally {
            close();
        }
        return list;
    }

    public int excuteUpdate(String sql,Object... objects) throws SQLException {
        try{
            conn = getConn();
            pstmt = conn.prepareStatement(sql);
            if (objects != null&&objects.length>0) {
                for (int i = 0; i < objects.length; i++) {
                    pstmt.setObject(i+1,objects[i]);
                }
            }
            int row = pstmt.executeUpdate();
            return row;
        }finally {
            close();
        }
    }

    public int insertAndGetKey(String sql,Object... objects) throws SQLException {
        try {
            conn = getConn();
            ResultSet rs = null;
            pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            if (objects != null&&objects.length!=0) {
                for (int i = 0; i <objects.length ; i++) {
                    pstmt.setObject(i+1,objects[i]);
                }
            }
            int row = pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            while (rs.next()){
                int key = rs.getInt(1);
                return key;
            }
        }finally {
            close();
        }
        return -1;
    }

    public void close(){
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
