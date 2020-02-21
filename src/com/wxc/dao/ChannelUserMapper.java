package com.wxc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wxc.entity.Admin;
import com.wxc.entity.Channel;
import com.wxc.entity.ChannelUser;
import com.wxc.entity.Files;
import com.wxc.entity.GroupUser;

public interface ChannelUserMapper {
    int deleteByPrimaryKey(@Param("id")Integer id);

    int insert(ChannelUser record);

    int insertSelective(ChannelUser record);

    ChannelUser selectByPrimaryKey(@Param("id")Integer id);

    int updateByPrimaryKeySelective(ChannelUser record);

    int updateByPrimaryKey(ChannelUser record);

	List<ChannelUser> getChannelUser(@Param("username")String userName);

	int getChannelUserCount();

	List<ChannelUser> queryChannelUser(@Param("pageNum")Integer page,@Param("limit") Integer limit);

	List<Channel> queryChannels();

	ChannelUser getChannelUserById(@Param("id")Integer id);

	List<GroupUser> queryGroupUserByName(String string);
	List<Admin> queryAdminUserByName(String string);
	ChannelUser login(String name, String password);

	List<ChannelUser> queryChannelUserExamined(int index, Integer limit);

	int queryChannelUserExaminedCount();

	List<ChannelUser> queryChannelUserUnexamined(int i, Integer limit);

	int queryChannelUserUnexaminedCount();

	float selectDigitalcount();

	List<Files> selectDigitalall(int pagenum1);

	float selectfilecount(Integer dif);

	List<Files> selectallfile(int pagenum1, Integer dif);

	int selectnum(Integer id);

	void numless(Integer id);
}