package com.wxc.service;

import java.util.List;

import com.wxc.entity.Channel;
import com.wxc.entity.ChannelUser;
import com.wxc.entity.Files;
import com.wxc.entity.GroupUser;

public interface ChannelUserService {
	
	void addChannelUser(ChannelUser group);
	
	void updateChannelUser(ChannelUser group);

	void deleteChannelUser(Integer id);
	
	List<ChannelUser> getChannelUser(String userName);
	float getGroupCount();
	
	List<ChannelUser> queryChannelUser(Integer page, Integer limit);

	List<Channel> queryChannels();

	ChannelUser getChannelUserById(Integer id);

	GroupUser groupUserLogin(String name, String password);

	void updateGroupUser(GroupUser groupuser);

	ChannelUser channelUserLogin(String name, String password);
	boolean getUserByUserName(String string);

	Channel queryChannelByIdentifier(String channelname);

	List<ChannelUser> queryChannelUserExamined(Integer page, Integer limit);

	int queryChannelUserExaminedCount();

	List<ChannelUser> queryChannelUserUnexamined(Integer page, Integer limit);

	int queryChannelUserUnexaminedCount();

	List<ChannelUser> queryChannelUserByUserName(ChannelUser admin);

	void userUpdateChannelUser(ChannelUser comp);

	float selectDigitalcount();

	List<Files> selectDigitalall(int pagenum1);

	float selectfilecount(Integer dif);

	List<Files> selectallfile(int pagenum1, Integer dif);
	
	int selectnum(Integer id);
	
	void numless(Integer id);
}
