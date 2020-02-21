package com.wxc.action;

import java.util.Date;
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
import com.wxc.service.OrganizationService;
import com.wxc.util.Layui;

@Controller
public class OrganizationController {

	@Resource
	private OrganizationService organizationService;
	/**
	 * 添加组织集团信息
	 * @param username
	 * @param description
	 */
	@RequestMapping("/addOrg.do")
	@ResponseBody
	public Map<String, Object> addUser(GroupComp comp,HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		//.通过数据库查询唯一标识,如果重复，返回；如果没重复，返回到数据库
		
		try {
			List<GroupComp> groupComp = organizationService.getGroupCompByName(comp.getName());
			List<GroupComp> grou = organizationService.getGroupCompByOrgCode(comp.getOrgCode());
			
			if(groupComp.size()>0){
				result.put("code", 2);//名字不能重复
			}else if(grou.size()>0){
				result.put("code", 3);//唯一标识不能重复
			}else{
			    //将数据信息添加到数据库	
				comp.setCreator(admin.getName());
				comp.setCreateTime(new Date());
				comp.setUpdateTime(new Date());
				organizationService.addGroupComp(comp);
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
	 * 修改组织集团信息
	 * @param username
	 * @param description
	 */
	@RequestMapping("/updateOrg.do")
	@ResponseBody
	public Map<String, Object> updateOrg(GroupComp comp,HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		//.通过数据库查询唯一标识,如果重复，返回；如果没重复，返回到数据库
		
		try {
		    //将数据信息添加到数据库	
			comp.setUpdator(admin.getName());
			comp.setUpdateTime(new Date());
			organizationService.updateGroupComp(comp);
			result.put("code", 1);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.put("code", 0);
		}
		return result;
	}
	/**
	 * 查询所有用户
	 * @return
	 */
	@RequestMapping("/queryOrg.do")
	@ResponseBody
	public Layui queryUsers(Integer page,Integer limit){
		float countmessage= organizationService.getGroupCount();
		//总页数
		int countpage=(int) Math.ceil(countmessage/10);
		List<GroupComp> list;
		//所有信息
		if(page<1||countpage<1){
			int pagenum1=0;
			 list = organizationService.queryGroupComps(page, limit);
		  
		}else if(page <=countpage){
			 list= organizationService.queryGroupComps((page-1)*limit, limit);
			
		}else{
			int pagenum1=(countpage-1)*limit;
			 list = organizationService.queryGroupComps(pagenum1,limit);
		  
		}
		
		
		return  Layui.data(countpage, list);
	} 
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	@RequestMapping("deleteOrgr.do")
	@ResponseBody
	public Map<String, Object> deleteUser(Integer id, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		
		
		organizationService.deleteGroupComp(id);
		//删除通道
		
			result.put("code", 1);
			
		
		return result;
	}
	/**
	 * 用户停用
	 * @param id
	 * @return
	 */
	/*@RequestMapping("/stopUser.do")
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
	}*/

	

}
