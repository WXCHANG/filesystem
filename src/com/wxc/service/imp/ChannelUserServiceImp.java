package com.wxc.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wxc.dao.ChannelMapper;
import com.wxc.dao.ChannelUserMapper;
import com.wxc.dao.GroupUserMapper;
import com.wxc.entity.Channel;
import com.wxc.entity.ChannelUser;
import com.wxc.entity.Files;
import com.wxc.entity.GroupUser;
import com.wxc.service.ChannelUserService;

@Service
public class ChannelUserServiceImp implements ChannelUserService{

	@Resource
	private ChannelUserMapper channelUserMapper;
	
	@Resource
	private GroupUserMapper groupUserMapper;
	
	@Resource
	private ChannelMapper channelMapper;
	
	@Override
	public void addChannelUser(ChannelUser group) {
		channelUserMapper.insert(group);
		
	}

	@Override
	public void updateChannelUser(ChannelUser group) {
		channelUserMapper.updateByPrimaryKey(group);
		
	}

	@Override
	public void deleteChannelUser(Integer id) {
		channelUserMapper.deleteByPrimaryKey(id);
		
	}

	@Override
	public List<ChannelUser> getChannelUser(String userName) {
		List<ChannelUser> chanUser =channelUserMapper.getChannelUser( userName);
		return chanUser;
	}

	@Override
	public float getGroupCount() {
		int count = channelUserMapper.getChannelUserCount();
		return count;
	}

	@Override
	public List<ChannelUser> queryChannelUser(Integer page, Integer limit) {
		List<ChannelUser> chanUser =channelUserMapper.queryChannelUser(page,limit);
		return chanUser;
		
	}

	@Override
	public List<Channel> queryChannels() {
		List<Channel> chanUser =channelUserMapper.queryChannels();
		return chanUser;
	}

	@Override
	public ChannelUser getChannelUserById(Integer id) {
		return channelUserMapper.selectByPrimaryKey(id);
	}

	@Override
	public boolean getUserByUserName(String string) {
		List<ChannelUser> chanUser =channelUserMapper.getChannelUser(string);
		if(chanUser!=null && chanUser.size()>0){
			return false;
		}
		return true;
	}
	@Override
	public GroupUser groupUserLogin(String name, String password) {
		return groupUserMapper.login(name, password);
	}

	@Override
	public void updateGroupUser(GroupUser groupuser) {
		groupUserMapper.updateByPrimaryKeySelective(groupuser);
		
	}

	@Override
	public ChannelUser channelUserLogin(String name, String password) {
		
		return channelUserMapper.login(name,password);
	}

	@Override
	public Channel queryChannelByIdentifier(String channelname) {
		return channelMapper.queryChannelByIdentifier(channelname);
	}

	@Override
	public List<ChannelUser> queryChannelUserExamined(Integer page, Integer limit) {
		if (page==null) {
			page=1;
		}
		if (limit==null) {
			limit=10;
		}
		return channelUserMapper.queryChannelUserExamined((page-1)*limit,limit);
	}

	@Override
	public int queryChannelUserExaminedCount() {
		return channelUserMapper.queryChannelUserExaminedCount();
	}

	@Override
	public List<ChannelUser> queryChannelUserUnexamined(Integer page, Integer limit) {
		if (page==null) {
			page=1;
		}
		if (limit==null) {
			limit=10;
		}
		return channelUserMapper.queryChannelUserUnexamined((page-1)*limit,limit);
	}

	@Override
	public int queryChannelUserUnexaminedCount() {
		return channelUserMapper.queryChannelUserUnexaminedCount();
	}

	@Override
	public List<ChannelUser> queryChannelUserByUserName(ChannelUser admin) {
		List<ChannelUser> chanUser =channelUserMapper.getChannelUser(admin.getUsername());
		return chanUser;
	}

	@Override
	public void userUpdateChannelUser(ChannelUser comp) {
		channelUserMapper.updateByPrimaryKeySelective(comp);
		
	}

	@Override
	public float selectDigitalcount() {
		float count =channelUserMapper.selectDigitalcount();
		return count;
	}

	@Override
	public List<Files> selectDigitalall(int pagenum1) {
		// TODO Auto-generated method stub
		return channelUserMapper.selectDigitalall( pagenum1);
	}

	@Override
	public float selectfilecount(Integer dif) {
		float count =channelUserMapper.selectfilecount(dif);
		return count;
	}

	@Override
	public List<Files> selectallfile(int pagenum1, Integer dif) {
		// TODO Auto-generated method stub
		return channelUserMapper.selectallfile( pagenum1,dif);
	}
	@Override
	public int selectnum(Integer id) {
		int count = channelUserMapper.selectnum(id);
		return count;
	}

	@Override
	public void numless(Integer id) {
		channelUserMapper.numless(id);
		
	}
	
	
	



}
