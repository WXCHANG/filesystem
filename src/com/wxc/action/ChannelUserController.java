package com.wxc.action;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.wxc.entity.ChannelUser;
import com.wxc.entity.Files;
import com.wxc.entity.GroupComp;
import com.wxc.httputil.NewApiUtil;
import com.wxc.service.ChannelUserService;
import com.wxc.service.OrganizationService;
import com.wxc.service.OriginService;
import com.wxc.util.Layui;

import net.sf.json.JSONObject;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;


@Controller
public class ChannelUserController {

	@Resource
	private ChannelUserService channelUserService;
	
	@Resource
	private OrganizationService organizationService;
	
	@Resource
	private OriginService originService;
	/**
	 * 添加通道用户信息
	 * @param username
	 * @param description
	 */
	@RequestMapping("/addChannelUser.do")
	@ResponseBody
	public Map<String, Object> addUser(ChannelUser channelUser,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		//.通过数据库查询唯一标识,如果重复，返回；如果没重复，返回到数据库
		
		try {
			
			if(!(channelUserService.getUserByUserName(channelUser.getUsername()))){
				result.put("code", 2);//名字不能重复
			}else{
			    //将数据信息添加到数据库	
				channelUser.setStatus("1");
				channelUser.setAuditstatus("0");
				channelUserService.addChannelUser(channelUser);
				result.put("code", 1);
				/*//调用底层创建用户接口
				Map<String, Object> map = new HashMap<String, Object>();
				Admin admin = originService.queryAdmin().get(0);
				map.put("userName", channelUser.getUsername());
				map.put("sessionKey", admin.getToken());
				map.put("channel", channelUser.getChannelidentifier());
				Response response = HttpUtil.postJson(YmConfiguration.APIServer+"createUserForUserSessionKey.do", map);
				JSONObject jsonObject = JSONObject.fromObject(response.getBody());
				if (jsonObject.getString("Code").equals("success")) {
					JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
					String secret = json.getString("sessionKey");
					channelUser.setAuditstatus("1");
					channelUser.setSecretkey(secret);
					channelUserService.addChannelUser(channelUser);
					result.put("code", 1);
				}else {
					result.put("code", 0);
				}*/
				/*try {
					String data  = ApiUtil.createAccount(map);
					JSONObject json = JSONObject.fromObject(data);
					String secret = json.getString("secret");
					channelUser.setAuditstatus("1");
					channelUser.setSecretkey(secret);
					channelUserService.addChannelUser(channelUser);
					result.put("code", 1);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					result.put("code", 0);
				}*/
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.put("code", 0);
		}
		return result;
	}
	
	/**
	 * 管理员修改用户通道信息
	 * @param username
	 * @param description
	 */
	@RequestMapping("/updateChannelUser.do")
	@ResponseBody
	public Map<String, Object> updateChannelUser(Integer id, String auditstatus, String email, HttpSession session){
		//GroupUser groupUser = (GroupUser) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		//.通过数据库查询唯一标识,如果重复，返回；如果没重复，返回到数据库
		try {
			ChannelUser channelUser = channelUserService.getChannelUserById(id);
		    //将数据信息添加到数据库	
			channelUser.setAuditstatus(auditstatus);
			channelUser.setEmail(email);
			channelUserService.updateChannelUser(channelUser);
			result.put("code", 1);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.put("code", 0);
		}
		return result;
	}
	
	/**
	 * 用户修改用户通道信息
	 * @param username
	 * @param description
	 */
	@RequestMapping("/userUpdateChannelUser.do")
	@ResponseBody
	public Map<String, Object> userUpdateChannelUser(ChannelUser comp,HttpSession session,String type){
		//GroupUser groupUser = (GroupUser) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			//type=1 修改密码：不需要判断用户审核状态，，type=2 修改用户通道和用户所属公司，需要判断审核状态
			
			//通过用户名查询用户审核状态，，，如果已审核，则不能再修改；
			if("2".equals(type)){//修改用户信息 eg：用户通道，用户所属公司
				 List<ChannelUser> users= channelUserService.queryChannelUserByUserName(comp);
				   if(users.size()>0 &&"1".equals(users.get(0).getAuditstatus()) ){
						result.put("code", 2);
						result.put("msg", "此用户已经审核通过，不能修改信息");
						return result;
				   }
			}
			
		 //修改数据库信息
			comp.setAuditstatus("0");
			channelUserService.userUpdateChannelUser(comp);
			result.put("code", 1);
			session.setAttribute("auditstatus", "未审核");
			
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
	@RequestMapping("/queryChannelUser.do")
	@ResponseBody
	public Layui queryUsers(Integer page,Integer limit){
		float countmessage= channelUserService.getGroupCount();
		//总页数
		int countpage=(int) Math.ceil(countmessage/10);
		List<ChannelUser> list;
		//所有信息
		if(page<1||countpage<1){
			int pagenum1=0;
			 list = channelUserService.queryChannelUser(page, limit);
		  
		}else if(page <=countpage){
			 list= channelUserService.queryChannelUser((page-1)*limit, limit);
			
		}else{
			int pagenum1=(countpage-1)*limit;
			 list = channelUserService.queryChannelUser(pagenum1,limit);
		  
		}
		
		
		return  Layui.data(countpage, list);
	} 
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	@RequestMapping("deleteChannelUser.do")
	@ResponseBody
	public Map<String, Object> deleteUser(Integer id, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		/*GroupUser  groupUser = (GroupUser) session.getAttribute("admin");
		Map<String, Object> map = new HashMap<String, Object>();
		ChannelUser channelUser = channelUserService.getChannelUserById(id);
		map.put("secret", groupUser.getToken());
		map.put("username", channelUser.getUsername());
		String data = ApiUtil.deleteUser(map);
		JSONObject jsonStr = JSONObject.fromObject(data);
		boolean success_status = jsonStr.getBoolean("success");
		if (!success_status) {
			result.put("code", 0);
		}else {
			channelUserService.deleteChannelUser(id);
			result.put("code", 1);
		}*/
		try {
			channelUserService.deleteChannelUser(id);
		} catch (Exception e) {
			result.put("code", 0);
		}
		result.put("code", 1);
		return result;
	}
	
	/**
	 * 查询所有通道
	 * @return
	 */
	@RequestMapping("/queryChannels.do")
	@ResponseBody
	public Map<String, Object> queryChannels(Integer page,Integer limit,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		List<ChannelUser> userNames=null;
		//所有通道
		List<Channel> list= channelUserService.queryChannels();
		//所有公司
		List<GroupComp> groups =organizationService.queryOrgs();
		//根据用户名，查询所属通道和所属公司
		ChannelUser admin = (ChannelUser) session.getAttribute("channelUser");
		if(admin!=null){
			 userNames = channelUserService.queryChannelUserByUserName(admin);
		}
		
		if (list!=null && list.size()>0) {
			result.put("list", list);
		}
		if (groups!=null && groups.size()>0) {
			result.put("groups", groups);
		}
		if(userNames!=null&& userNames.size()>0){
			result.put("channelUser", userNames.get(0));
		}
		
		return result;
	} 
	
	/**
	 * 查询所有通道
	 * @return
	 */
	@RequestMapping("/queryChannelByIdentifier.do")
	@ResponseBody
	public Map<String, Object> queryChannelByIdentifier(String identifier){
		Map<String, Object> result = new HashMap<String, Object>();
		Channel channel= channelUserService.queryChannelByIdentifier(identifier);
		
		if (channel!=null) {
			result.put("channel", channel);
		}
		return result;
	} 
	/**
	 * 用户停用
	 * @param id
	 * @return
	 */
	@RequestMapping("/updateChannelUserStatus.do")
	@ResponseBody
	public Map<String, Object> stopUser(ChannelUser chs, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
//		Admin admin = (Admin) session.getAttribute("admin");
		ChannelUser user = channelUserService.getChannelUserById(chs.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		/*map.put("secret", admin.getToken());
		map.put("username", user.getUsername());*/
		String data;
		JSONObject jsonStr;
		boolean success_status=true;
		if("0".equals(chs.getStatus())){//停用用户
			//data = ApiUtil.deleteUser(map);
			try {
				/*jsonStr = JSONObject.fromObject(data);
				success_status = jsonStr.getBoolean("success");
				if (!success_status) {
					result.put("code", 0);
				}else {
					user.setStatus("0");
					channelUserService.updateChannelUser(chs);
					result.put("code", 1);
				}*/
				
				channelUserService.updateChannelUser(chs);
				result.put("code", 1);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result.put("code", 0);
			}
		}else if("1".equals(chs.getStatus())){
			//启动需要修改
			try {
				
					
					channelUserService.updateChannelUser(chs);
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
	 * 查询已审核用户
	 * @return
	 */
	@RequestMapping("queryChannelUserExamined")
	@ResponseBody
	public Layui queryChannelUserExamined(Integer page,Integer limit){
		//分页查询已审核用户
		List<ChannelUser> list = channelUserService.queryChannelUserExamined(page,limit);
		//查询已审核用户总条数
		int count = channelUserService.queryChannelUserExaminedCount();
		return Layui.data(count, list);
	}
	/**
	 * 查询未审核用户
	 * @return
	 */
	@RequestMapping("queryChannelUserUnexamined")
	@ResponseBody
	public Layui queryChannelUserUnexamined(Integer page,Integer limit){
		//分页查询未审核用户
		List<ChannelUser> list = channelUserService.queryChannelUserUnexamined(page,limit);
		//查询未审核用户总条数
		int count = channelUserService.queryChannelUserUnexaminedCount();
		return Layui.data(count, list);
	}
	/**
	 * 审核通过
	 * @return
	 */
	@RequestMapping("approve.do")
	@ResponseBody
	public Map<String, Object> approve(Integer id,HttpSession session,String channelidentifier,String channelname){
		Admin admin = (Admin) session.getAttribute("admin");
		Map<String, Object> result = new HashMap<String, Object>();
		if(id==null || id ==0){
			result.put("code", 0);
		}else{
			ChannelUser channelUser = channelUserService.getChannelUserById(id);
			//调用底层创建用户接口
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userName", channelUser.getUsername());
			map.put("sessionKey", admin.getToken());
			map.put("channel", channelidentifier);
			String jsonData = NewApiUtil.createUserForUserSessionKey(map);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			if (jsonObject.getString("Code").equals("success")) {
				JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
				String secret = json.getString("sessionKey");
				channelUser.setAuditstatus("1");
				channelUser.setSecretkey(secret);
				channelUser.setChannelidentifier(channelidentifier);
				channelUser.setChannelname(channelname);
				channelUserService.updateChannelUser(channelUser);
				result.put("code", 1);
			}else {
				result.put("code", 0);
			}
			/*try {
				String data  = ApiUtil.createAccount(map);
				JSONObject json = JSONObject.fromObject(data);
				String secret = json.getString("sessionKey");
				channelUser.setAuditstatus("1");
				channelUser.setSecretkey(secret);
				channelUserService.updateChannelUser(channelUser);
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
	 * 审核不通过
	 * @return
	 */
	@RequestMapping("unapprove.do")
	@ResponseBody
	public Map<String, Object> unapprove(Integer id,String reason){
		Map<String, Object> result = new HashMap<String, Object>();
		if(id==null || id==0){
			result.put("code", 0);
		}else{
			ChannelUser channelUser = channelUserService.getChannelUserById(id);
			channelUser.setAuditstatus("2");
			channelUserService.updateChannelUser(channelUser);
			//发送不通过原因
			sendEmail(channelUser.getEmail(),"",reason,"大通联盟区块链平台注册审核失败原因");
			result.put("code", 1);
		}
		return result;
	}
	

	    /**
	     * 发送邮件
	     * @param to 给谁发
	     * @param text 发送内容
	     */
	 @RequestMapping("sendEmail.do")
	 @ResponseBody
	 public  Map<String, Object> sendEmail(String mail,String url,String text,String subject) {
		 
		   Map<String, Object> result = new HashMap<String, Object>();
	    //	
	    	Properties prop = new Properties();
	    	try {
	    		//读取属性文件mailInfo.properties
	    		InputStream is = this.getClass().getResourceAsStream("/mailInfo.properties");
				prop.load(is);//加载资源文件
			} catch (IOException e1) {
				e1.printStackTrace();
				 result.put("code", "2");
			}
	    	if("".equals(subject)){
	    		subject="验证码";
	    	}
	        String msgText = subject +":" +text;
	        /*String smtpHost = "smtp.163.com";//SMTP服务器名
	        String from =prop.getProperty("mailName");//发信人地址
	        String pwd =prop.getProperty("pwd");//密码*/
	        String to = mail;//收信人地址
	        
	        Properties props = new Properties();
			props.put("username", prop.getProperty("mailName"));
			props.put("password", prop.getProperty("pwd"));
	 
			//网易的smtp服务器地址
			props.put("mail.smtp.host", prop.getProperty("smtpHost"));
			//SSLSocketFactory类的端口
			props.put("mail.smtp.socketFactory.port", prop.getProperty("port"));
			//SSLSocketFactory类
			props.put("mail.smtp.socketFactory.class",
					"javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			//网易提供的ssl加密端口,QQ邮箱也是该端口
			props.put("mail.smtp.port", prop.getProperty("port"));
			
			Session session = Session.getDefaultInstance(props);
	 
			try {
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress(prop.getProperty("mailName")));
				message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
				message.setSubject(subject);
				// 正文和响应头
				message.setContent(msgText, "text/html;charset=UTF-8");
				message.saveChanges();
				Transport transport = session.getTransport("smtp");
				transport.connect(props.getProperty("mail.smtp.host"),props.getProperty("username"),props.getProperty("password"));
				transport.sendMessage(message,message.getAllRecipients());
				transport.close();
				result.put("code", "1");
			}catch (MessagingException e) {
				result.put("code", "2");
				throw new RuntimeException(e);
			}
	        return result;
	    }
	 /**
	  * 查询版权信息
	  * @param pagenum
	  * @return
	  */
	    @RequestMapping("/listAll.do")
		@ResponseBody
		public Map<String, Object> addUser(Integer pagenum,HttpSession session){
			Map<String, Object> rs=new HashMap<String, Object>();
			float countmessage=channelUserService.selectDigitalcount();
			//总页数
			int countpage=(int) Math.ceil(countmessage/10);
			//所有信息
			if(pagenum<1){
				int pagenum1=0;
			    List<Files> devices=channelUserService.selectDigitalall(pagenum1);
			    List<String> time=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
			    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
			    	time.add(date1);
			    }
				List<String> time1=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
				    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
				    time1.add(date1);
				}
				rs.put("Path", time1);
				rs.put("Time", time);
			    rs.put("Data",devices);
			}else if(pagenum<=countpage){
				List<Files> devices=channelUserService.selectDigitalall((pagenum-1)*10);
			    List<String> time=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
			    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
			    	time.add(date1);
			    }
				List<String> time1=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
				    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
				    time1.add(date1);
				}
				rs.put("Path", time1);
				rs.put("Time", time);
			    rs.put("Data",devices);
			}else{
				if(countpage==0){
					int pagenum1=0;
					List<Files> devices=channelUserService.selectDigitalall(pagenum1);
				    List<String> time=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
				    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
				    	time.add(date1);
				    }
					List<String> time1=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
					    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
					    time1.add(date1);
					}
					rs.put("Path", time1);
					rs.put("Time", time);
				    rs.put("Data",devices);
				}else{
					int pagenum1=(countpage-1)*10;
					List<Files> devices=channelUserService.selectDigitalall(pagenum1);
				    List<String> time=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
				    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
				    	time.add(date1);
				    }
					List<String> time1=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
					    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
					    time1.add(date1);
					}
					rs.put("Path", time1);
					rs.put("Time", time);
				    rs.put("Data",devices);
					}						
			}
			rs.put("flag","success");
			rs.put("countpage",countpage);
			rs.put("countmessage",countmessage);	
			return rs;
		}
		
	 @RequestMapping(value="/ListAllFiles.do")
		@ResponseBody
		public Map<String, Object> ListAllFiles(Integer pagenum,Integer dif){
			Map<String, Object> rs=new HashMap<String, Object>();
			float countmessage=channelUserService.selectfilecount(dif);
			//总页数
			int countpage=(int) Math.ceil(countmessage/10);
			//所有信息
			if(pagenum<1){
				int pagenum1=0;
			    List<Files> devices=channelUserService.selectallfile(pagenum1,dif);
			    List<String> time=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
			    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
			    	time.add(date1);
			    }
				List<String> time1=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
				    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
				    time1.add(date1);
				}		
				rs.put("Path", time1);
				rs.put("Time", time);
			    rs.put("Data",devices);
			}else if(pagenum<=countpage){
				List<Files> devices=channelUserService.selectallfile((pagenum-1)*10,dif);
			    List<String> time=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
			    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
			    	time.add(date1);
			    }
				List<String> time1=new ArrayList<String>();
				for(int i=0;i<devices.size();i++){
				    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
				    time1.add(date1);
				}
				rs.put("Path", time1);
				rs.put("Time", time);
			    rs.put("Data",devices);
			}else{
				if(countpage==0){
					int pagenum1=0;
					List<Files> devices=channelUserService.selectallfile(pagenum1,dif);
				    List<String> time=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
				    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
				    	time.add(date1);
				    }
					List<String> time1=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
					    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
					    time1.add(date1);
					}
					rs.put("Path", time1);
					rs.put("Time", time);
				    rs.put("Data",devices);
				}else{
					int pagenum1=(countpage-1)*10;
					List<Files> devices=channelUserService.selectallfile(pagenum1,dif);
				    List<String> time=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
				    	String date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ").format(devices.get(i).getCreatetime());		    	
				    	time.add(date1);
				    }
					List<String> time1=new ArrayList<String>();
					for(int i=0;i<devices.size();i++){
					    String date1=devices.get(i).getPath().replace("/2/", "/1/");		    	
					    time1.add(date1);
					}
					rs.put("Path", time1);
					rs.put("Time", time);
				    rs.put("Data",devices);
					}						
			}
			rs.put("flag","success");
			rs.put("countpage",countpage);
			rs.put("countmessage",countmessage);	
			return rs;
		}
	
	 
	 
	 /*public static void main(String[] args) throws Exception {
			//sendMail(Constants.fromMail, "18630309807@163.com", Constants.fromUserName, Constants.fromPwd, "jhhh", "wwww");
		 sendEmail("m15201593416@163.com", "www.baidu.com", "haha", "heihei");
			System.out.println("发送成功");
			
		}*/

}
