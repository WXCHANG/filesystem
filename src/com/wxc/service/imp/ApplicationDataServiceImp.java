package com.wxc.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wxc.dao.AdminMapper;
import com.wxc.dao.ApplicationDataMapper;
import com.wxc.entity.Admin;
import com.wxc.entity.ApplicationData;
import com.wxc.entity.Origin;
import com.wxc.service.ApplicationDataService;

@Service
public class ApplicationDataServiceImp implements ApplicationDataService{
	
	@Resource
	private ApplicationDataMapper applicationDataMapper;
	@Resource
	private AdminMapper adminMapper;

	@Override
	public ApplicationData queryById(Integer id) {
		return applicationDataMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateData(ApplicationData applicationData) {
		applicationDataMapper.updateByPrimaryKeySelective(applicationData);
	}

	@Override
	public void insertData(ApplicationData applicationData) {
		applicationDataMapper.insertSelective(applicationData);
	}

	@Override
	public List<Origin> queryNoSavedData(Integer page, Integer limit, Integer userId) {
		if (page==null || page==0) {
			page = 1;
		}
		if (limit==null || limit==0) {
			limit = 10;
		}
		return applicationDataMapper.queryNoSavedData((page-1)*limit,limit,userId);
	}

	@Override
	public int queryNoSavedCount(Integer userId) {
		return applicationDataMapper.queryNoSavedCount(userId);
	}

	@Override
	public List<Origin> querySavedData(Integer page, Integer limit, Integer userId) {
		if (page==null || page==0) {
			page = 1;
		}
		if (limit==null || limit==0) {
			limit = 10;
		}
		return applicationDataMapper.querySavedData((page-1)*limit,limit,userId);
	}

	@Override
	public int querySavedCount(Integer userId) {
		return applicationDataMapper.querySavedCount(userId);
	}

	@Override
	public List<Origin> queryAllData(Integer page, Integer limit, Integer userId) {
		if(page==null || page==0)
			page = 1;
		if (limit==null || limit==0)
			limit = 10;
		return applicationDataMapper.queryAllData((page-1)*limit,limit,userId);
	}

	@Override
	public int queryAllCount(Integer userId) {
		return applicationDataMapper.queryAllCount(userId);
	}

	@Override
	public List<Admin> queryAdmin() {
		return adminMapper.queryAdmins();
	}

}
