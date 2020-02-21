package com.wxc.service;

import java.util.List;

import com.wxc.entity.GroupComp;

public interface OrganizationService {

	
	
	void addGroupComp(GroupComp group);
	
	void updateGroupComp(GroupComp group);

	void deleteGroupComp(Integer id);
	
	List<GroupComp> getGroupComp(GroupComp group);
	float getGroupCount();
	
	List<GroupComp> queryGroupComps(Integer page, Integer limit);

	List<GroupComp> getGroupCompByName(String name);

	List<GroupComp> getGroupCompByOrgCode(String orgCode);

	List<GroupComp> queryOrgs();

	/*Origin queryByNubmerOrHash(String searchContent);

	

	

	


	
	

	*/



}
