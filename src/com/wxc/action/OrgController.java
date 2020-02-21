package com.wxc.action;


import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wxc.entity.Admin;
import com.wxc.entity.GroupComp;
import com.wxc.entity.GroupUser;
import com.wxc.httputil.ApiUtil;
import com.wxc.httputil.HttpUtil;
import com.wxc.httputil.Response;
import com.wxc.service.ChannelUserService;
import com.wxc.service.OrgService;
import com.wxc.util.Layui;
import com.wxc.util.YmConfiguration;

import net.sf.json.JSONObject;

@Controller
public class OrgController {
	@Resource
	private OrgService orgService;
	@Resource
	private ChannelUserService channelUserService;
	/**
	 * 查询所有集团组织
	 * @return
	 */
	@RequestMapping("/queryOrgs.do")
	@ResponseBody
	public Map<String, Object> queryOrgs(){
		Map<String, Object> result = new HashMap<String, Object>();
		List<GroupComp> list = orgService.queryOrgs();
		if (list!=null && list.size()>0) {
			result.put("list", list);
		}
		return result;
	}
	/**
	 * 根据集团组织查询组织用户
	 * @param search
	 * @return
	 */
	@RequestMapping("queryUserByOrgName.do")
	@ResponseBody
	public Layui queryUserByOrgName(String search){
		try {
			search = new String(search.getBytes("GBK") , "GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<GroupUser> list = orgService.queryUserByOrgName(search);
		int count = orgService.queryUserCountByOrgName(search);
		return Layui.data(count, list);
	}
	/**
	 * 添加组织用户
	 * @param username
	 * @param description
	 */
	@RequestMapping("/addGroupUser.do")
	@ResponseBody
	public Map<String, Object> addGroupUser(String name,String password,String description,String org,HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		boolean existence = channelUserService.getUserByUserName(name);
		if (existence==false) {
			result.put("code", 2);
		}else{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("username", name);
//			map.put("orgname", "org1");
//			map.put("description", description);
			map.put("secret", admin.getToken());
			try {
				String data  = ApiUtil.createAccount(map);
				JSONObject json = JSONObject.fromObject(data);
				String secret = json.getString("secret");
				orgService.addGroupUser(name,password,description,org,secret);
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
	 * 删除组织用户
	 * @param id
	 * @return
	 */
	@RequestMapping("deleteGroupUser.do")
	@ResponseBody
	public Map<String, Object> deleteGroupUser(Integer id, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		Admin admin = (Admin) session.getAttribute("admin");
		GroupUser groupUser = orgService.queryGroupUserById(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("secret", admin.getToken());
		map.put("username", groupUser.getName());
		String data = ApiUtil.deleteUser(map);
		JSONObject jsonStr = JSONObject.fromObject(data);
		boolean success_status = jsonStr.getBoolean("success");
		if (!success_status) {
			result.put("code", 0);
		}else {
			orgService.deleteGroupUser(id);
			result.put("code", 1);
			
		}
		return result;
	}
	/**
	 * 组织用户停用
	 * @param id
	 * @return
	 */
	@RequestMapping("/stopGroupUser.do")
	@ResponseBody
	public Map<String, Object> stopGroupUser(Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		GroupUser groupUser = orgService.queryGroupUserById(id);
		if (groupUser==null) {
			result.put("code", 0);
		}else{
			groupUser.setStatus(0);
			orgService.updateGroupUser(groupUser);
			result.put("code", 1);
		}
		return result;
	}
	/**
	 * 组织用户启用
	 * @param id
	 * @return
	 */
	@RequestMapping("/startGroupUser.do")
	@ResponseBody
	public Map<String, Object> startGroupUser(Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		GroupUser groupUser = orgService.queryGroupUserById(id);
		if (groupUser==null) {
			result.put("code", 0);
		}else{
			groupUser.setStatus(1);
			orgService.updateGroupUser(groupUser);
			result.put("code", 1);
		}
		return result;
	}
	/**
	 * 查询所有管理员
	 * @return
	 */
	@RequestMapping("/queryAdmins.do")
	@ResponseBody
	public Layui queryAdmins(Integer page,Integer limit){
		List<Admin> list = orgService.queryAdmins(page,limit);
		int count = orgService.getAdminCount();
		return  Layui.data(count, list);
	} 
	
	/**
	 * 添加管理员
	 * @param username
	 * @param description
	 */
	@RequestMapping("/addAdmin.do")
	@ResponseBody
	public Map<String, Object> addAdmin(String name,String password,String description,HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		boolean existence = channelUserService.getUserByUserName(name);
		if (existence==false) {
			result.put("code", 2);
		}else{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userName", name);
//			map.put("orgname", "org1");
//			map.put("description", description);
			map.put("sessionKey", admin.getToken());
			Response response = HttpUtil.postJson(YmConfiguration.APIServer+"createUserForUserSessionKey.do", map);
			JSONObject jsonObject = JSONObject.fromObject(response.getBody());
			if (jsonObject.getString("Code").equals("success")) {
				JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
				String secret = json.getString("sessionKey");
				orgService.addAdmin(name,password,description,secret);
				result.put("code", 1);
			}else{
				result.put("code", 0);
			}
			/*try {
				String data  = ApiUtil.createAccount(map);
				JSONObject json = JSONObject.fromObject(data);
				String secret = json.getString("secret");
				orgService.addAdmin(name,password,description,secret);
				result.put("code", 1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result.put("code", 0);
			}*/
		}
		return result;
	} 
	/**
	 * 删除管理员
	 * @param id
	 * @return
	 */
	@RequestMapping("deleteAdmin.do")
	@ResponseBody
	public Map<String, Object> deleteAdmin(Integer id, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			orgService.deleteAdmin(id);
			result.put("code", 1);
		} catch (Exception e) {
			result.put("code", 0);
		}
		return result;
	}
	/**
	 * 管理员停用
	 * @param id
	 * @return
	 */
	@RequestMapping("/stopAdmin.do")
	@ResponseBody
	public Map<String, Object> stopAdmin(Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		Admin admin1 = orgService.queryAdminById(id);
		if (admin1==null) {
			result.put("code", 0);
		}else{
			admin1.setStatus(0);
			orgService.updateAdmin(admin1);
			result.put("code", 1);
		}
		return result;
	}
	/**
	 * 管理员启用
	 * @param id
	 * @return
	 */
	@RequestMapping("/startAdmin.do")
	@ResponseBody
	public Map<String, Object> startAdmin(Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		Admin admin1 = orgService.queryAdminById(id);
		if (admin1==null) {
			result.put("code", 0);
		}else{
			admin1.setStatus(1);
			orgService.updateAdmin(admin1);
			result.put("code", 1);
		}
		return result;
	}
	/**
	 * 修改管理员信息
	 * @param admin
	 * @return
	 */
	@RequestMapping("/updateAdmin.do")
	@ResponseBody
	public Map<String, Object> updateAdmin(Admin admin){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			orgService.updateAdmin(admin);
			result.put("code", 1);
		} catch (Exception e) {
			result.put("code", 0);
		}
		return result;
	}
}
