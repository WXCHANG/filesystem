package com.wxc.service.imp;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wxc.dao.ChannelMapper;
import com.wxc.entity.Channel;
import com.wxc.service.ChannelService;

@Service
public class ChannelServiceImp implements ChannelService{
	
	@Resource
	private ChannelMapper channelMapper;

	@Override
	public Channel queryByName(String channelname) {
		return channelMapper.queryByName(channelname);
	}

	@Override
	public Channel addChannel(String channelname, String description, String org, String symbol) {
		Channel channel = new Channel();
		channel.setChannelname(channelname);
		channel.setDescription(description);
		channel.setGroupuser(org);
		channel.setSymbol(symbol);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		channel.setCreatetime(sdf.format(new Date()));
		channel.setStatus(0);
		channelMapper.insertSelective(channel);
		return channel;
	}

	@Override
	public List<Channel> queryChannel(String org) {
		return channelMapper.queryChannel(org);
	}

	@Override
	public int queryChannelCount(String org) {
		return channelMapper.queryChannelCount(org);
	}

	@Override
	public void updateChannel(Channel channel) {
		channelMapper.updateByPrimaryKeySelective(channel);
	}

	@Override
	public void deleteChannel(int id) {
		channelMapper.deleteByPrimaryKey(id);
		
	}

	@Override
	public List<Channel> queryChannelcode(Integer page, Integer limit) {
		if (page==null) {
			page=1;
		}
		if (limit==null) {
			limit=10;
		}
		return channelMapper.queryChannelcode((page-1)*limit,limit);
	}

	@Override
	public int queryChannelcodeCount() {
		return channelMapper.queryChannelcodeCount();
	}

	@Override
	public List<Channel> queryAllChannel() {
		return channelMapper.queryAllChannel();
	}

}
