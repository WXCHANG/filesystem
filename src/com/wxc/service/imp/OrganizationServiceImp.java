package com.wxc.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wxc.dao.OrganizationMapper;
import com.wxc.entity.GroupComp;
import com.wxc.service.OrganizationService;

@Service
public class OrganizationServiceImp implements OrganizationService{

	
	@Resource
	private OrganizationMapper organizationMapper;

	@Override
	public void addGroupComp(GroupComp group) {
		int count =organizationMapper.addGroupComp(group);
		
	}
	@Override
	public void updateGroupComp(GroupComp group) {
		int count =organizationMapper.updateGroupComp(group);
		
	}
	@Override
	public void deleteGroupComp(Integer id) {
		int count =organizationMapper.deleteGroupComp(id);
		
	}
	@Override
	public List<GroupComp> getGroupComp(GroupComp group) {
		List<GroupComp> groups =organizationMapper.getGroupComp(group);
		return groups;
	}
	@Override
	public List<GroupComp> queryGroupComps(Integer page, Integer limit) {
		List<GroupComp> groups =organizationMapper.selelctGroupComp(page,limit);
		return groups;
	}
	@Override
	public float getGroupCount() {
		float count =organizationMapper.getGroupCount();
		return count;
	}
	@Override
	public List<GroupComp> getGroupCompByName(String name) {
		List<GroupComp> groups =organizationMapper.getGroupCompByName(name);
		return groups;
	}
	@Override
	public List<GroupComp> getGroupCompByOrgCode(String orgCode) {
		List<GroupComp> groups =organizationMapper.getGroupCompByOrgCode(orgCode);
		return groups;
	}
	@Override
	public List<GroupComp> queryOrgs() {
		List<GroupComp> orgs = organizationMapper.queryOrgs();
		return orgs;
	}
	
	



}
