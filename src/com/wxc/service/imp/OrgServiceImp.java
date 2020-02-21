package com.wxc.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wxc.dao.AdminMapper;
import com.wxc.dao.GroupUserMapper;
import com.wxc.dao.OrganizationMapper;
import com.wxc.entity.Admin;
import com.wxc.entity.GroupComp;
import com.wxc.entity.GroupUser;
import com.wxc.service.OrgService;
@Service
public class OrgServiceImp implements OrgService{
	@Resource
	private AdminMapper adminMapper;
	@Resource
	private OrganizationMapper organizationMapper;
	@Resource
	private GroupUserMapper groupUserMapper;

	@Override
	public Admin queryAdminByName(String name) {
		return adminMapper.queryAdminByName(name);
	}

	@Override
	public void addAdmin(String name, String password, String description, String secret) {
		Admin admin = new Admin();
		admin.setName(name);
		admin.setPassword(password);
		admin.setDescription(description);
		admin.setStatus(1);
		admin.setToken(secret);
		adminMapper.insertSelective(admin);
	}

	@Override
	public List<Admin> queryAdmins(Integer page, Integer limit) {
		if(page == null || page<=0){
			page=1;
		}
		if (limit == null) {
			limit = 10;
		}
		return adminMapper.queryAdminsPaged((page-1)*limit,limit);
	}

	@Override
	public int getAdminCount() {
		return adminMapper.getAdminCount();
	}

	@Override
	public Admin queryAdminById(Integer id) {
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public void deleteAdmin(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void updateAdmin(Admin admin1) {
		adminMapper.updateByPrimaryKeySelective(admin1);
	}

	@Override
	public List<GroupComp> queryOrgs() {
		return organizationMapper.queryOrgs();
	}

	@Override
	public List<GroupUser> queryUserByOrgName(String search) {
		return groupUserMapper.queryUserByOrgName(search);
	}

	@Override
	public int queryUserCountByOrgName(String search) {
		return groupUserMapper.queryUserCountByOrgName(search);
	}

	@Override
	public GroupUser queryGroupUserByName(String name) {
		return groupUserMapper.queryGroupUserByName(name);
	}

	@Override
	public void addGroupUser(String name, String password, String description, String org, String secret) {
		GroupUser groupUser = new GroupUser();
		groupUser.setName(name);
		groupUser.setCompany(org);
		groupUser.setPassword(password);
		groupUser.setDescription(description);
		groupUser.setStatus(1);
		groupUser.setToken(secret);
		groupUserMapper.insertSelective(groupUser);
	}

	@Override
	public GroupUser queryGroupUserById(Integer id) {
		return groupUserMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateGroupUser(GroupUser groupUser) {
		groupUserMapper.updateByPrimaryKeySelective(groupUser);
	}

	@Override
	public void deleteGroupUser(Integer id) {
		groupUserMapper.deleteByPrimaryKey(id);
	}

	@Override
	public GroupUser login(String name, String password) {
		return groupUserMapper.login(name,password);
	}

}
