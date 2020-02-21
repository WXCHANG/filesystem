package com.wxc.service;

import java.util.List;

import com.wxc.entity.Channel;

public interface ChannelService {
	
	Channel queryByName(String channelname);

	Channel addChannel(String channelname, String description, String org, String symbol);

	List<Channel> queryChannel(String org);

	int queryChannelCount(String org);

	void updateChannel(Channel channel);

	void deleteChannel(int id);

	List<Channel> queryChannelcode(Integer page, Integer limit);

	int queryChannelcodeCount();

	List<Channel> queryAllChannel();

}
