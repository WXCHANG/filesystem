package com.wxc.dao;

import java.util.List;

import com.wxc.entity.Admin;

public interface AdminMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);

    Admin login(String name, String password);

	void queryAdmin();

	List<Admin> queryAdmins();

	Admin queryAdminByName(String name);

	List<Admin> queryAdminsPaged(int i, Integer limit);

	int getAdminCount();
}