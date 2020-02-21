package com.wxc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wxc.entity.GroupComp;

public interface OrganizationMapper {

	int addGroupComp(GroupComp group);

	int updateGroupComp(GroupComp group);

	List<GroupComp> getGroupComp(GroupComp group);

	int deleteGroupComp(@Param("id")Integer id);

	List<GroupComp> selelctGroupComp(@Param("pageNum")Integer page,@Param("limit") Integer limit);

	int getGroupCount();

	List<GroupComp> queryOrgs();

	List<GroupComp> getGroupCompByName(@Param("name")String name);

	List<GroupComp> getGroupCompByOrgCode(@Param("orgCode")String orgCode);

}