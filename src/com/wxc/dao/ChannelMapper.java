package com.wxc.dao;

import java.util.List;

import com.wxc.entity.Channel;

public interface ChannelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Channel record);

    int insertSelective(Channel record);

    Channel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Channel record);

    int updateByPrimaryKey(Channel record);

	Channel queryByName(String channelname);

	List<Channel> queryChannel(String org);

	int queryChannelCount(String org);

	Channel queryChannelByIdentifier(String channelname);

	List<Channel> queryChannelcode(int i, Integer limit);

	int queryChannelcodeCount();

	List<Channel> queryAllChannel();
}