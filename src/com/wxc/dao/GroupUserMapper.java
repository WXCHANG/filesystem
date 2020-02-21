package com.wxc.dao;

import java.util.List;

import com.wxc.entity.GroupUser;

public interface GroupUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(GroupUser record);

    int insertSelective(GroupUser record);

    GroupUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(GroupUser record);

    int updateByPrimaryKey(GroupUser record);

	List<GroupUser> queryUserByOrgName(String search);

	int queryUserCountByOrgName(String search);

	GroupUser queryGroupUserByName(String name);

	GroupUser login(String name, String password);
}