package com.xhr.dao.baseInfoDao.impl;

import com.xhr.dao.baseInfoDao.PositionDao;
import com.xhr.entity.PageEntity;
import com.xhr.util.DBAgent;
import com.xhr.util.PageUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PositionDaoImpl implements PositionDao {
    DBAgent dbAgent = new DBAgent();

    @Override
    public PageEntity selectPosition(Map query, PageEntity page) throws Exception {
        StringBuffer sql=new StringBuffer("select * from position where 1=1 ");
        if (query!=null){
            if (query.get("positionno")!=null&&!query.get("positionno").equals("")){
                sql.append(" and positionno like '%"+query.get("positionno")+"%'");
            }if (query.get("positionname")!=null&&!query.get("positionname").equals("")){
                sql.append(" and positionname like '%"+query.get("positionname")+"%'");
            }if (query.get("positiondescr")!=null&&!query.get("positiondescr").equals("")){
                sql.append(" and positiondescr like '%"+query.get("positiondescr")+"%'");
            }if (query.get("positionstate")!=null&&!query.get("positionstate").equals("")){
                sql.append(" and positionstate like '%"+query.get("positionstate")+"%'");
            }
        }
        sql.append(" order by positionid ");
        return PageUtil.selectByPage(sql.toString(),page);
    }

    @Override
    public List<Map> selectPositionName() throws Exception {
        String sql="SELECT positionid,positionname FROM position WHERE positionstate=0 ";
        return dbAgent.executeQuery(sql);
    }

    @Override
    public int deletePosition(String state, String id) throws Exception {
        StringBuffer sql=new StringBuffer("UPDATE position SET positionstate=? WHERE positionid=?");
        return dbAgent.excuteUpdate(sql.toString(),state,id);
    }

    @Override
    public List<Map> selectPositionCard(String positionno, String positionid) throws Exception {
        String sql="select * from position where positionno=?";
        if (positionid!=null&&!positionid.equals("")){
            sql=sql+" and positionid!="+positionid;
        }
        List list=dbAgent.executeQuery(sql,positionno);
        return list;
    }

    @Override
    public List<Map> positionNameUnique(String positionname, String positionid) throws Exception {
        String sql="select * from position where positionname=?";
        if (positionid!=null&&!positionid.equals("")){
            sql=sql+" and positionid!="+positionid;
        }
        List<Map> list=dbAgent.executeQuery(sql,positionname);
        return list;
    }

    @Override
    public int addPosition(Map map) throws Exception {
        String sql="insert into position (positionno,positionname,positiondescr,positionstate) values(?,?,?,?)";
        return  dbAgent.excuteUpdate(sql,map.get("positionno"),map.get("positionname"),map.get("positiondescr"),map.get("positionstate"));
    }

    @Override
    public Map selectPositionById(String positionid) throws Exception {
        String sql="select positionno,positionname,positiondescr,positionstate from position where positionid=?";
        List<Map> list=dbAgent.executeQuery(sql,positionid);
        if (list!=null&&list.size()>0){
            return list.get(0);
        }
        return new HashMap();
    }

    @Override
    public int updatePosition(Map map) throws Exception {
        String sql="update position set positionno=?,positionname=?,positiondescr=?,positionstate=? where positionid=?";
        return dbAgent.excuteUpdate(sql,map.get("positionno"),map.get("positionname"),map.get("positiondescr"),map.get("positionstate"),map.get("positionid"));
    }
}
