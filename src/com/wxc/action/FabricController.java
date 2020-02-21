package com.wxc.action;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wxc.entity.Admin;
import com.wxc.entity.Peer;
import com.wxc.entity.User;
import com.wxc.httputil.ApiUtil;
import com.wxc.service.OriginService;
import com.wxc.util.Layui;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class FabricController {

	@Resource
	private OriginService originService;
	/**
	 * 添加用户
	 * @param username
	 * @param description
	 */
	@RequestMapping("/addUser.do")
	@ResponseBody
	public Map<String, Object> addUser(String username,String description,HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		User user = originService.queryByName(username);
		if (user!=null) {
			result.put("code", 2);
		}else{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("username", username);
			map.put("orgname", "org1");
			map.put("description", description);
			map.put("secret", admin.getToken());
			try {
				String data  = ApiUtil.createAccount(map);
				JSONObject json = JSONObject.fromObject(data);
				String secret = json.getString("secret");
				originService.addUser(username,description,secret);
				result.put("code", 1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result.put("code", 0);
			}
		}
		return result;
	}
	/**
	 * 查询所有用户
	 * @return
	 */
	@RequestMapping("/queryUsers.do")
	@ResponseBody
	public Layui queryUsers(Integer page,Integer limit){
		List<User> list = originService.queryUsers(page,limit);
		int count = originService.getUserCount();
		return  Layui.data(count, list);
	} 
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	@RequestMapping("deleteUser.do")
	@ResponseBody
	public Map<String, Object> deleteUser(Integer id, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		Admin admin = (Admin) session.getAttribute("admin");
		User user = originService.getUserById(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("secret", admin.getToken());
		map.put("username", user.getUsername());
		String data = ApiUtil.deleteUser(map);
		JSONObject jsonStr = JSONObject.fromObject(data);
		boolean success_status = jsonStr.getBoolean("success");
		if (!success_status) {
			result.put("code", 0);
		}else {
			originService.deleteUser(id);
			result.put("code", 1);
			
		}
		return result;
	}
	/**
	 * 用户停用
	 * @param id
	 * @return
	 */
	@RequestMapping("/stopUser.do")
	@ResponseBody
	public Map<String, Object> stopUser(Integer id, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		Admin admin = (Admin) session.getAttribute("admin");
		User user = originService.getUserById(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("secret", admin.getToken());
		map.put("username", user.getUsername());
		String data = ApiUtil.deleteUser(map);
		try {
			JSONObject jsonStr = JSONObject.fromObject(data);
			boolean success_status = jsonStr.getBoolean("success");
			if (!success_status) {
				result.put("code", 0);
			}else {
				user.setStatus("0");
				originService.updateUser(user);
				result.put("code", 1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.put("code", 0);
		}
		return result;
	}
	/**
	 * 查询所有节点IP
	 * @return
	 */
	@RequestMapping("/getPeerList.do")
	@ResponseBody
	public Layui getPeerList(HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Properties prop = new Properties();
		List<Peer> list = new ArrayList<Peer>();
		int count = 0;
		try{
			//读取属性文件a.properties
			InputStream in = new BufferedInputStream (new FileInputStream(FabricController.class.getResource("/peerIps.properties").getPath()));
			prop.load(in);     ///加载属性列表
			Iterator<String> it=prop.stringPropertyNames().iterator();
			List<String> peerList = new ArrayList<String>();
			while(it.hasNext()){
				String key=it.next();
				peerList.add("tcp://"+prop.getProperty(key)+":2375");
			}
			in.close();
			//调底层获取容器名
			try {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("urllist", peerList);
				map.put("secret", admin.getToken());
				String data = ApiUtil.getContainerName(map);
				JSONObject jsonData = JSONObject.fromObject(data);
				boolean success_status = jsonData.getBoolean("success");
				if(success_status){
					JSONArray jsonArray = jsonData.getJSONArray("list");
					for (int i = 0; i < jsonArray.size(); i++) {
						   Object object = jsonArray.get(i);
						   JSONObject jsonObject = JSONObject.fromObject(object);
						   Peer peer = new Peer();
						   if (jsonObject.getString("status")!=null && jsonObject.getString("status").equals("running")) {
							   peer.setStatus(1);
						   }else{
							   peer.setStatus(0);
						   }
						   String containerName = jsonObject.getString("name");
						   String peerIP1 = jsonObject.getString("url");
						   String peerIP = peerIP1.substring((peerIP1.indexOf("//")+2),peerIP1.lastIndexOf(":"));
						   peer.setContainerName(containerName);
						   peer.setPeerIP(peerIP);
						   list.add(peer);
						   count += 1;
					}
					
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return Layui.data(count, list);
	}
	/**
	 * 启动节点容器
	 * @param peerIp
	 * @param containerName
	 */
	@RequestMapping("/startContainer.do")
	@ResponseBody
	public Map<String, Object> startContainer(String peerIP,String containerName,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		if (containerName!=null && !containerName.equals("")) {
			Admin admin = (Admin) session.getAttribute("admin");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("secret", admin.getToken());
			map.put("url", "tcp://"+peerIP+":2375");
			map.put("container_name", containerName);
			try {
				String data = ApiUtil.startContainer(map);
				JSONObject jsonData = JSONObject.fromObject(data);
				boolean success_status = jsonData.getBoolean("success");
				if (success_status) {
					result.put("code", 1);
				}else{
					result.put("code", 0);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result.put("code", 0);
			}
		}else{
			result.put("code", 0);
		}
		
		return result;
	}
	/**
	 * 停止节点容器
	 * @param peerIp
	 * @param containerName
	 */
	@RequestMapping("/stopContainer.do")
	@ResponseBody
	public Map<String, Object> stopContainer(String peerIP,String containerName,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		if(containerName!=null && !containerName.equals("")){
			Admin admin = (Admin) session.getAttribute("admin");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("secret", admin.getToken());
			map.put("url", "tcp://"+peerIP+":2375");
			map.put("container_name", containerName);
			try {
				String data = ApiUtil.stopContainer(map);
				JSONObject jsonData = JSONObject.fromObject(data);
				boolean success_status = jsonData.getBoolean("success");
				if (success_status) {
					result.put("code", 1);
				}else{
					result.put("code", 0);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result.put("code", 0);
			}
		}else{
			result.put("code", 0);
		}
		return result;
	}

}
