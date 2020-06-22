package com.xhr.dao.baseInfoDao;

import com.xhr.entity.PageEntity;

import java.util.List;
import java.util.Map;

/***
 * @author xhr
 * @date 2020/3/23
 *  职位Dao接口
**/
public interface PositionDao {
    /**
     * 查询所有职位
     * @param query
     * @param page
     * @return
     * @throws Exception
     */
    PageEntity selectPosition(Map query, PageEntity page) throws Exception;

    /**
     * 查询职位-下拉框
     * @return
     * @throws Exception
     */
    List<Map> selectPositionName() throws Exception;

    /**
     * 删除职位
     * @param state
     * @param id
     * @return
     * @throws Exception
     */
    int deletePosition(String state, String id) throws Exception;

    /**
     * 职位编号唯一性校验
     * @param positionno
     * @param positionid
     * @return
     * @throws Exception
     */
    List<Map> selectPositionCard(String positionno, String positionid) throws Exception;

    /**
     * 职位名称唯一性校验
     * @param positionname
     * @param positionid
     * @return
     * @throws Exception
     */
    List<Map> positionNameUnique(String positionname,String positionid) throws Exception;

    /**
     * 新增职位
     * @param map
     * @return
     * @throws Exception
     */
    int addPosition(Map map) throws Exception;

    /**
     * 修改职位-根据职位id查找职位
     * @param positionid
     * @return
     * @throws Exception
     */
    Map selectPositionById(String positionid) throws Exception;

    /**
     * 修改职位
     * @param map
     * @return
     * @throws Exception
     */
    int updatePosition(Map map) throws Exception;
}
