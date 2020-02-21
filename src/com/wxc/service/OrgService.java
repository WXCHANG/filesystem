package com.wxc.service;

import java.util.List;

import com.wxc.entity.Admin;
import com.wxc.entity.GroupComp;
import com.wxc.entity.GroupUser;

public interface OrgService {

	Admin queryAdminByName(String name);

	void addAdmin(String name, String password, String description, String secret);

	List<Admin> queryAdmins(Integer page, Integer limit);

	int getAdminCount();

	Admin queryAdminById(Integer id);

	void deleteAdmin(Integer id);

	void updateAdmin(Admin admin1);

	List<GroupComp> queryOrgs();

	List<GroupUser> queryUserByOrgName(String search);

	int queryUserCountByOrgName(String search);

	GroupUser queryGroupUserByName(String name);

	void addGroupUser(String name, String password, String description, String org, String secret);

	GroupUser queryGroupUserById(Integer id);

	void updateGroupUser(GroupUser groupUser);

	void deleteGroupUser(Integer id);

	GroupUser login(String name, String password);

}
