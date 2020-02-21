package com.wxc.service;

import java.util.List;

import com.wxc.entity.Admin;
import com.wxc.entity.Licence;
import com.wxc.entity.Origin;
import com.wxc.entity.User;
import com.wxc.entity.VideoToken;

public interface OriginService {
	Origin queryById(Integer id);

	void updateOrigin(Origin origin);

	int insertOrigin(Origin origin);

	List<Origin> getAllOrigins(int i, Integer limit, String channel);

	int queryCount(String channel);

	List<Origin> getNoBlockOrigins(int i, Integer limit, int userId);

	int getNoCount(int userId);

	List<Origin> getBlockOrigins(int i, Integer limit, int userId);

	int getYesCount(int userId);

	void deleteOrigin(Integer id);

	Origin queryByTxIdOrHash(String searchContent);

	Admin login(String name, String password);

	void updateAdmin(Admin admin);

	User queryByName(String username);

	void addUser(String username, String description, String secret);

	User getUserById(Integer id);

	void deleteUser(Integer id);

	List<User> queryUsers(Integer page, Integer limit);

	int getUserCount();

	void updateUser(User user);

	List<Admin> queryAdmin();

	List<Origin> getNoSave(String channel);
	List<Origin> getShowCalligraphyBlockOrigins(String type, Integer id, Integer limit, Integer integer);

	void insertLicences(Licence licences);

	Licence selectlicence(Integer id);

	int getShowCalligraphyBlockOriginsCount(Integer id, String type);

	int addVideoToken(VideoToken videoToken);

	VideoToken selectVideoTokenByUserId(VideoToken videoToken);

	int updateVideoTokenById(VideoToken v);

	



}
