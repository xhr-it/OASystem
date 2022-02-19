package com.xhr.service.baseInfoService;

import com.xhr.entity.Message;
import com.xhr.entity.PageEntity;

import java.util.List;
import java.util.Map;

public interface PositionService {
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
     * 删除职务
     * @param state
     * @param id
     * @return
     * @throws Exception
     */
    Message deletePosition(String state, String id) throws Exception;

    /**
     * 职位编号唯一性校验
     * @param positionno
     * @param positionid
     * @return
     * @throws Exception
     */
    Message selectPositionCard(String positionno, String positionid) throws Exception;

    /**
     * 职位名称唯一性校验
     * @param positionname
     * @param positionid
     * @return
     * @throws Exception
     */
    Message positionNameUnique(String positionname,String positionid) throws Exception;

    /**
     * 新增职位
     * @param map
     * @return
     * @throws Exception
     */
    Message addPosition(Map map) throws Exception;

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
    Message updatePosition(Map map) throws Exception;
}
