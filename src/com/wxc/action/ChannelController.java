package com.wxc.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wxc.entity.Admin;
import com.wxc.entity.Channel;
import com.wxc.httputil.NewApiUtil;
import com.wxc.service.ChannelService;
import com.wxc.util.Layui;

import net.sf.json.JSONObject;

@Controller
public class ChannelController {
	@Resource
	private ChannelService channelService;
	/**
	 * 添加通道
	 * @param channelname
	 * @param description
	 */
	@RequestMapping("/addChannel.do")
	@ResponseBody
	public Map<String, Object> addChannel(String channelname,String description,String org,String symbol,HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		Channel channel = channelService.queryByName(channelname);
		if (channel!=null) {
			result.put("code", 2);
		}else{
			//保存通道到数据库
			Channel newChannel = channelService.addChannel(channelname,description,org,symbol);
			//开启底层创建通道线程
			try {
				fabricCreateChannel(newChannel,admin.getToken());
			} catch (Exception e) {
				//创建失败
				newChannel.setStatus(2);
    			channelService.updateChannel(newChannel);
				e.printStackTrace();
			}
		}
		return result;
	}
	//开启底层创建通道线程
	public void fabricCreateChannel(final Channel channel,final String token){
		 new Thread(new Runnable() {
		        @Override
		        public void run() {
		        	//底层创建通道
		    		Map<String, Object> map = new HashMap<String, Object>();
		    		map.put("symbol", channel.getSymbol());
		    		map.put("sessionKey", token);
		    		String jsonData = NewApiUtil.createChannel(map);
		    		JSONObject jsonObject = JSONObject.fromObject(jsonData);
		    		if (jsonObject.getString("Code").equals("success")) {
		    			JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
		    			String chaincode=json.getString("chaincodeID");
		    			String channelIdentifier = json.getString("channel");
		    			
						//创建成功
						channel.setStatus(1);
						channel.setIdentifier(channelIdentifier);
						channel.setChaincode(chaincode);
						channelService.updateChannel(channel);
					}else {
						//创建失败
						channel.setStatus(2);
						channelService.updateChannel(channel);
					}
		    		/*try {
						String data = ApiUtil.createChannel(map);
						JSONObject json = JSONObject.fromObject(data);
						boolean success = json.getBoolean("success");
						if (success) {
							String chaincode=json.getString("chaincodeID");
							//创建成功
							channel.setStatus(1);
							channel.setChaincode(chaincode);
							channelService.updateChannel(channel);
						}else{
							//创建失败
							channel.setStatus(2);
							channelService.updateChannel(channel);
						}
					} catch (Exception e) {
						//创建失败
						channel.setStatus(2);
						channelService.updateChannel(channel);
						e.printStackTrace();
					}*/
		        }
		    }).start();
	}
	/**
	 * 查询域所含通道
	 * @return
	 */
	@RequestMapping("queryChannel.do")
	@ResponseBody
	public Layui queryChannel(String search){
		List<Channel> list = channelService.queryChannel(search);
		int count = channelService.queryChannelCount(search);
		return Layui.data(count, list);
	}
	/**
	 * 查询域所含链码
	 * @return
	 */
	@RequestMapping("queryChannelcode.do")
	@ResponseBody
	public Layui queryChannelcode(Integer page, Integer limit){
		List<Channel> list = channelService.queryChannelcode(page,limit);
		int count = channelService.queryChannelcodeCount();
		return Layui.data(count, list);
	}
	/**
	 * 修改通道信息
	 * @param channel
	 * @return
	 */
	@RequestMapping("updateChannel.do")
	@ResponseBody
	public Map<String, Object> updateChannel(Channel channel){
		Map<String, Object> result = new HashMap<String, Object>();
		channelService.updateChannel(channel);
		result.put("code", 1);
		return result;
	}
	/**
	 * 删除通道
	 * @param channel
	 * @return
	 */
	@RequestMapping("deleteChannel.do")
	@ResponseBody
	public Map<String, Object> deleteChannel(Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		channelService.deleteChannel(id);
		result.put("code", 1);
		return result;
	}
	/**
	 * 查询所有创建成功的通道
	 * @return
	 */
	@RequestMapping("/queryAllChannel.do")
	@ResponseBody
	public Map<String, Object> queryAllChannel(){
		Map<String, Object> result = new HashMap<String, Object>();
		List<Channel> list = channelService.queryAllChannel();
		result.put("list", list);
		return result;
	}
}
