package com.wxc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wxc.entity.ApplicationData;
import com.wxc.entity.Origin;

public interface ApplicationDataMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ApplicationData record);

    int insertSelective(ApplicationData record);

    ApplicationData selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ApplicationData record);

    int updateByPrimaryKey(ApplicationData record);

	List<Origin> queryNoSavedData(@Param("pageCount")int pageCount, @Param("limit")Integer limit, @Param("userId")Integer userId);

	int queryNoSavedCount(@Param("userId")Integer userId);

	List<Origin> querySavedData(@Param("pageCount")int pageCounti, @Param("limit")Integer limit, @Param("userId")Integer userId);

	int querySavedCount(@Param("userId")Integer userId);

	List<Origin> queryAllData(@Param("pageCount")int pageCount, @Param("limit")Integer limit, @Param("userId")Integer userId);

	int queryAllCount(@Param("userId")Integer userId);
}