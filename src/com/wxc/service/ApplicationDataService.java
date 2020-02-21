package com.wxc.service;

import java.util.List;

import com.wxc.entity.Admin;
import com.wxc.entity.ApplicationData;
import com.wxc.entity.Origin;

public interface ApplicationDataService {

	ApplicationData queryById(Integer id);

	void updateData(ApplicationData applicationData);

	void insertData(ApplicationData applicationData);

	List<Origin> queryNoSavedData(Integer page, Integer limit, Integer userId);

	int queryNoSavedCount(Integer userId);

	List<Origin> querySavedData(Integer page, Integer limit, Integer userId);

	int querySavedCount(Integer userId);

	List<Origin> queryAllData(Integer page, Integer limit, Integer userId);

	int queryAllCount(Integer userId);

	List<Admin> queryAdmin();

}
