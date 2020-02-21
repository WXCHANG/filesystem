package com.wxc.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wxc.dao.AdminMapper;
import com.wxc.dao.OriginMapper;
import com.wxc.dao.UserMapper;
import com.wxc.entity.Admin;
import com.wxc.entity.Licence;
import com.wxc.entity.Origin;
import com.wxc.entity.User;
import com.wxc.entity.VideoToken;
import com.wxc.service.OriginService;
@Service
public class OriginServiceImp implements OriginService{

	
	@Resource
	private OriginMapper originMapper;
	@Resource
	private UserMapper userMapper;
	@Resource
	private AdminMapper adminMapper;
	
	@Override
	public Origin queryById(Integer id) {
		return originMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateOrigin(Origin origin) {
		originMapper.updateByPrimaryKeySelective(origin);
	}

	@Override
	public int insertOrigin(Origin origin) {
		int  count = originMapper.insert(origin);
		return count;
	}

	@Override
	public List<Origin> getAllOrigins(int page, Integer limit, String channel) {
		return originMapper.getAllOrigins(page,limit,channel);
	}

	@Override
	public int queryCount(String channel) {
		return originMapper.queryCount(channel);
	}

	@Override
	public List<Origin> getNoBlockOrigins(int page, Integer limit, int userId) {
		return originMapper.getNoBlockOrigins(page,limit,userId);
	}

	@Override
	public int getNoCount(int userId) {
		return originMapper.getNoCount(userId);
	}

	@Override
	public List<Origin> getBlockOrigins(int page, Integer limit, int userId) {
		return originMapper.getBlockOrigins(page,limit,userId);
	}

	@Override
	public int getYesCount(int userId) {
		return originMapper.getYesCount(userId);
	}

	@Override
	public void deleteOrigin(Integer id) {
		originMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Origin queryByTxIdOrHash(String searchContent) {
		return originMapper.queryByTxIdOrHash(searchContent);
	}


	@Override
	public Admin login(String name, String password) {
		return adminMapper.login(name,password);
	}

	@Override
	public void addUser(String username, String description, String secret) {
		User user = new User();
		user.setDescription(description);
		user.setSecret(secret);
		user.setUsername(username);
		user.setStatus("1");
		userMapper.insertSelective(user);
	}

	@Override
	public void deleteUser(Integer id) {
		userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public User getUserById(Integer id) {
		return userMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<User> queryUsers(Integer page,Integer limit) {
		if(page == null || page<=0){
			page=1;
		}
		if (limit == null) {
			limit = 10;
		}
		return userMapper.queryUsers((page-1)*limit,limit);
	}

	@Override
	public int getUserCount() {
		return userMapper.queryUserCount();
	}

	@Override
	public User queryByName(String username) {
		return userMapper.queryByName(username);
	}

	@Override
	public void updateUser(User user) {
		userMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public void updateAdmin(Admin admin) {
		adminMapper.updateByPrimaryKeySelective(admin);
	}

	@Override
	public List<Admin> queryAdmin() {
		return adminMapper.queryAdmins();
	}

	@Override
	public List<Origin> getNoSave(String channel) {
		return originMapper.getNoSave(channel);
	}
	@Override
	public List<Origin> getShowCalligraphyBlockOrigins(String type,Integer page,Integer limit, Integer id) {
		return originMapper.getShowCalligraphyBlockOrigins(type,page,limit,id);
	}

	@Override
	public void insertLicences(Licence licences) {
		originMapper.insertLicences(licences);
		
	}

	@Override
	public Licence selectlicence(Integer id) {
		Licence licence = originMapper.selectlicence(id);
		return licence;
	}

	@Override
	public int getShowCalligraphyBlockOriginsCount(Integer id, String type) {
		int count = originMapper.getShowCalligraphyBlockOriginsCount(id,type);
		return count;
	}

	@Override
	public int addVideoToken(VideoToken videoToken) {
		int count = originMapper.addVideoToken(videoToken);
		return count;
	}

	@Override
	public VideoToken selectVideoTokenByUserId(VideoToken videoToken) {
		
		return originMapper.selectVideoTokenByUserId( videoToken);
	}

	@Override
	public int updateVideoTokenById(VideoToken v) {
		
		return originMapper.updateVideoTokenById(v);
	}


}
