package com.wxc.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wxc.entity.Admin;
import com.wxc.entity.Block;
import com.wxc.entity.ChannelUser;
import com.wxc.entity.GroupUser;
import com.wxc.entity.Licence;
import com.wxc.entity.Origin;
import com.wxc.entity.Transaction;
import com.wxc.entity.VideoToken;
import com.wxc.httputil.HttpUtil;
import com.wxc.httputil.NewApiUtil;
import com.wxc.httputil.Response;
import com.wxc.service.ChannelUserService;
import com.wxc.service.OriginService;
import com.wxc.util.CryptoUtil;
import com.wxc.util.Layui;
import com.wxc.util.YmConfiguration;
import com.wxc.util.ZXingCode;
import com.wxc.util.encryptionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class OriginController {
	@Resource
	private OriginService originService;
	@Resource
	private ChannelUserService channelUserService;
	
	
	/**
	 * 登录
	 * @param name
	 * @param password
	 * @return
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, Object> login(String level,String name,String password,HttpSession session,HttpServletRequest request){
		Map<String, Object> result = new HashMap<String, Object>();
		//此处我做 level等级的判断
		//空 没有选 不让过
		//0 超级管理员 AdminMapper
		//1组织管理员 GroupUserMapper
		//2通道用户ChannelUserMapper
		
		//0 没选择权限
		//1 用户名或密码错误
		//2 超级管理员成功跳转
		//3 组织管理员成功跳转
		//4 通道管理员成功跳转
		if(level==null || level.trim().equals("")){
			//没有选择
			result.put("code", 0);//code赋值 0 请选择管理权限
			return result;//返回
		}
		
		
		//超级管理员
		if(level.trim().equals("0")){
			//超级管理员
			Admin admin = originService.login(name,password);
			if(name!=null && !name.equals("") && name.equals("admin")){
				if(admin != null){
						//登录获取Token
						//Map<String, Object> map = new HashMap<String, Object>();
						/*map.put("username", name);
						map.put("password", password);*/
						/*String jsonData = NewApiUtil.getAdminSessionKey(map);
						JSONObject jsonObject = JSONObject.fromObject(jsonData);*/
						/*if (jsonObject.getString("Code").equals("success")) {
							JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
							String token = json.getString("sessionKey");
							admin.setToken(token);
							originService.updateAdmin(admin);
							session.setAttribute("admin", admin);
							result.put("code", 2);//超级管理员成功跳转	
						}else{
							result.put("code", 5);//获取密钥失败
						}*/
						/*try {
							String data = ApiUtil.login(map);
							JSONObject json = JSONObject.fromObject(data);
							String token = json.getString("secret");
							admin.setToken(token);
							originService.updateAdmin(admin);
							session.setAttribute("admin", admin);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							result.put("code", 1);//用户名或密码错误
						}*/
						session.setAttribute("admin", admin);
						result.put("code", 2);//超级管理员成功跳转
						result.put("msg", "管理员登录成功！");
				
				}else {
					result.put("code", 1);//用户名或密码错误
					result.put("msg", "用户名或密码错误！");
				}
			}else{
				if(admin != null){
					session.setAttribute("admin", admin);
					result.put("code", 2);//超级管理员成功跳转
					result.put("msg", "管理员登录成功！");
				}else {
					result.put("code", 1);//用户名或密码错误
					result.put("msg", "用户名或密码错误！");
				}
			}
			
		}
		
		
		
		
		
		//组织管理员
		if(level.trim().equals("1")){
			//组织管理员
			GroupUser groupuser = channelUserService.groupUserLogin(name,password);
			if(groupuser != null){
				session.setAttribute("admin", groupuser);
				
				result.put("code", 3);//组织管理员成功跳转
			}else {
				result.put("code", 1);//用户名或密码错误
				result.put("msg", "用户名或密码错误！");
			}
		}
		
		
		
		
		
		//通道管理员
		if(level.trim().equals("2")){
			//通道管理员
			ChannelUser channeluser = channelUserService.channelUserLogin(name,password);
			if(channeluser != null){
//				Channel channel = channelUserService.queryChannelByIdentifier(channeluser.getChannelidentifier());
//				if (!mapQueue.containsKey(channel.getChaincode())) {
//					mapQueue.put(channel.getChaincode(), new LinkedBlockingQueue<OriginalData>());
//					String path = request.getSession().getServletContext()
//							.getRealPath("upload");
//					File logoFile = new File(request.getSession().getServletContext().getRealPath("images")+"/logo.png");
//					startSaveBlock(channeluser.getSecretkey(), channel.getChaincode(),path,logoFile);
//				}
				if("0".equals(channeluser.getAuditstatus())){
					session.setAttribute("auditstatus", "未审核");
				}else if("2".equals(channeluser.getAuditstatus())) {
					session.setAttribute("auditstatus", "审核中");
				}else if("1".equals(channeluser.getAuditstatus())) {
					session.setAttribute("auditstatus", "");
				}
				session.setAttribute("channelUser", channeluser);
				session.setAttribute("userId", channeluser.getId());
				result.put("code", 4);//通道管理员成功跳转
				result.put("msg", "用户登录成功！");
			}else {
				result.put("code", 1);//用户名或密码错误
				result.put("msg", "用户名或密码错误！");
			}
		}
		
		
		
		return result;
	}
	
	/**
	 * 跳转登录页面
	 * @return
	 */
	@RequestMapping("/skipLogin.do")
	public String skipLogin(){
		return "login";
	}
	/**
	 * 退出登录-超级管理员
	 * @return
	 */
	@RequestMapping("/loginOut.do")
	public String loginOut(HttpSession session){
		session.removeAttribute("admin");
		return "login";
	}
	
	/**
	 * 退出登录-用户
	 * @return
	 */
	@RequestMapping("/userLoginOut.do")
	public String userLoginOut(HttpSession session){
		session.removeAttribute("channelUser");
		return "userLogin";
	}
	/**
	 * 添加或修改溯源个人信息
	 * @param name
	 * @param type
	 * @param origin
	 * @param capacity
	 * @param weigth
	 * @param birth
	 * @param shelflife
	 * @return
	 */
	@RequestMapping("/addOrigin.do")
	@ResponseBody
	public Map<String, Object> addOrigin(Integer id,String value1,String value1Encrypt,String value2,String value2Encrypt,String value3,
			String value3Encrypt,String value4,String value4Encrypt,String value6,String value7, String value8, String value9, String value9Encrypt,String type,String total,
			@RequestParam(value = "value5", required = false) MultipartFile value5,HttpServletRequest request){
		Map<String, Object> result = new HashMap<String, Object>();
		if(id!=null){
			Origin origin = originService.queryById(id);
			origin.setName(value1);
			origin.setArea(value2);
			origin.setIdentifier(value3);
			origin.setQuality(value4);
			origin.setExamine(value6);
			origin.setValue7(value7);
			origin.setValue8(value8);
			originService.updateOrigin(origin);
		}else{
			HttpSession session = request.getSession();
			ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser"); 
			if (channelUser!=null) {
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String storageTime = sdf.format(date);
				Origin origin  = new Origin();
				origin.setName(value1);
				origin.setEncryptname(value1Encrypt);
				origin.setArea(value2);
				origin.setEncryptarea(value2Encrypt);
				origin.setIdentifier(value3);
				origin.setEncryptidentifier(value3Encrypt);
				origin.setQuality(value4);
				origin.setEncryptquality(value4Encrypt);
				origin.setExamine(value6);
				origin.setValue7(value7);
				origin.setValue8(value8);
				origin.setValue9(value9);
				origin.setValue9encrypt(value9Encrypt);
				origin.setStoragetime(storageTime);
				origin.setUserid(channelUser.getId());
				
				String hash = CryptoUtil.getSHA256(JSONObject.fromObject(origin).toString());
				origin.setHash(hash);
				String fileType =null;//保存视频和图片的文件夹名称
				if (value5!=null && !value5.isEmpty()) {
					
					if("1".equals(type)){
						fileType="images";
					}else if("2".equals(type)){
						fileType = "videos";
					}else{
						fileType = "errorFile";
					}
//					String path = System.getProperty("catalina.home")+File.separator+"webapps"+File.separator+fileType;
					String path = request.getSession().getServletContext()
							.getRealPath("upload");
					String fileName = value5.getOriginalFilename();
					String newName = System.currentTimeMillis()
							+ fileName.substring(fileName.lastIndexOf("."));
					File targetFile = new File(path, newName);
					if (!targetFile.exists()) {
						targetFile.mkdirs();
					}
					// 保存
					try {
						value5.transferTo(targetFile);
					} catch (Exception e) {
						e.printStackTrace();
					}
//					origin.setFile("/"+fileType+"/" + newName);
					origin.setFile("/upload/" + newName);

				}
				origin.setType(type);
				if(total!=null&& !("".equals(total))){
					origin.setNum(Integer.parseInt(total));
					origin.setTotal(Integer.parseInt(total));
				}
				
				origin.setChannelname(channelUser.getChannelidentifier());
				//信息存储到数据库 用户每上传一个视频，token值加10
				int idCount = originService.insertOrigin(origin);
				if (value5!=null && !value5.isEmpty() && "2".equals(type)) {
					VideoToken videoToken = new VideoToken();
					videoToken.setUserId(channelUser.getId());
					VideoToken v = originService.selectVideoTokenByUserId(videoToken);
					if(v!=null ){
						v.setToken(v.getToken()+10);
						originService.updateVideoTokenById(v);
					}else{
						v.setToken(v.getToken()+10);
						originService.addVideoToken(v);
					}
				}
				//如果value5不为null且type=2(视频)，则在数据库添加播放次数
				/*if (value5!=null && !value5.isEmpty() && "2".equals(type)) {
					Licence licences = new Licence();
					licences.setFileid(origin.getId());
					licences.setMkey("1234567890DYEEEK");
					licences.setTarget("CPSecDRM-VIDEO-00001");
					licences.setVersion("1.0.0");
					licences.setLicenceid("CPSecDRM-LICENSE-00010");
					licences.setNum(70);
					licences.setType("MP4");
					licences.setTotal(70);
					originService.insertLicences(licences);
				}*/
				result.put("code", 1);
			}else{
				result.put("code", 0);
				result.put("userCode", 0);
			}
			
		}
		return result;
	}
	/**
	 * 保存数据到区块
	 * @param id
	 * @return
	 */
	@RequestMapping("/saveDataToBlock.do")
	@ResponseBody
	public Map<String, Object> saveDataToBlock(int id,HttpServletRequest request,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		Origin origin = originService.queryById(id);
		JSONObject jsonData = new JSONObject();
		if (origin.getEncryptname()==null || origin.getEncryptname().equals("")) {
			jsonData.put("value1", origin.getName());
		}else{
			jsonData.put("value1", origin.getEncryptname());
		}
		if (origin.getEncryptarea()==null || origin.getEncryptarea().equals("")) {
			jsonData.put("value2", origin.getArea());
		}else{
			jsonData.put("value2", origin.getEncryptarea());
		}
		if (origin.getEncryptidentifier()==null || origin.getEncryptidentifier().equals("")) {
			jsonData.put("value3", origin.getIdentifier());
		}else{
			jsonData.put("value3", origin.getEncryptidentifier());
		}
		if (origin.getEncryptquality()==null || origin.getEncryptquality().equals("")) {
			jsonData.put("value4", origin.getQuality());
		}else{
			jsonData.put("value4", origin.getEncryptquality());
		}
		if (origin.getValue9encrypt()==null || origin.getValue9encrypt().equals("")) {
			jsonData.put("value9", origin.getValue9());
		}else{
			jsonData.put("value9", origin.getValue9encrypt());
		}
		jsonData.put("value5", origin.getExamine());
		jsonData.put("value6", origin.getStoragetime());
		jsonData.put("value7", origin.getValue7());
		jsonData.put("value8", origin.getValue8());
		jsonData.put("hash", origin.getHash());
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionKey", channelUser.getSecretkey());
		map.put("jsonData", jsonData);
		map.put("key", "CPSec"+id);
		
		String responseStr = NewApiUtil.createBlockDataEx(map); //调用API数据上链操作
		JSONObject jsonObject = JSONObject.fromObject(responseStr);
		String codeStr = jsonObject.getString("Code");
		if (codeStr.equals("success")) {
			try {
				JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
				String txid= json.getString("txid");
				origin.setTxid(txid);
				long fileName = System.currentTimeMillis();
				String path = request.getSession().getServletContext()
						.getRealPath("upload");
				File logoFile = new File(request.getSession().getServletContext().getRealPath("images")+"/bupt.png");
				File QrCodeFile = new File(path+"/"+fileName+".png");
				ZXingCode.drawLogoQRCode(logoFile, QrCodeFile, YmConfiguration.server+YmConfiguration.projectName+"/qrcodeContent.do?id="+id, "");
				origin.setQrcode("upload/"+fileName+".png");
				origin.setStatus(1);
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				origin.setSavetime(dateFormat.format(new Date()));
				originService.updateOrigin(origin);
				result.put("result","success");
			} catch (Exception e) {
				//保存失败
				origin.setStatus(0);
				originService.updateOrigin(origin);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		result.put("result","success");
		return result;
	}
	
	public Block queryBlockTxIDForUse(String txID,String secret){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionKey", secret);
		map.put("txID", txID);
		String jsonStr = NewApiUtil.queryBlockByTxID(map);
		JSONObject jsonObject = JSONObject.fromObject(jsonStr);
		String codeStr = jsonObject.getString("Code");
		Block block = new Block();
		if(codeStr.equals("success")){
			JSONObject blockjson = JSONObject.fromObject(jsonObject.getString("data"));
			String number = blockjson.getString("number");
			String currentHash = blockjson.getString("current_hash");
			String previousHash = blockjson.getString("previous_hash");
			String dataHash = blockjson.getString("data_hash");
			String transactions = blockjson.getString("transactions");
			JSONArray array = JSONArray.fromObject(transactions);
			Iterator<Object> it = array.iterator();
			List<Transaction> transactionList=new ArrayList<Transaction>();
			while (it.hasNext()) {
				JSONObject ob = (JSONObject) it.next();
				Transaction transaction = null;
				if(ob.getString("tx_id")!=null){
					transaction=new Transaction();
					transaction.setTx_id(ob.getString("tx_id"));
				}
				if(ob.getString("proposal_hash")!=null){
					transaction.setProposal_hash(ob.getString("proposal_hash"));
				}
				if(ob.getString("payload")!=null){
					transaction.setPayload(ob.getString("payload"));
				}
				if(ob.getString("timestamp")!=null){
					transaction.setTimestamp(ob.getString("timestamp"));
				}
				if(transaction!=null){
					transactionList.add(transaction);
				}
			}
			block.setCurrentHash(currentHash);
			block.setPreviousHash(previousHash);
			block.setNumber(number);
			block.setDataHash(dataHash);
			block.setTransactions(transactionList);
		}
		return block;
	}
	/*public Block queryBlockNumber(int number){
		List<Admin> listAdmin = originService.queryAdmin();
		Admin admin = listAdmin.get(0);
		return queryBlockNumberForUse(number, admin.getToken());
		
	}*/
	/**
	 * 显示数据详情二维码
	 * @return
	 */
	@RequestMapping("/showQrcode.do")
	public String showQrcode(int id,Model model,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		Origin origin = originService.queryById(id);
		if(origin!=null){
			model.addAttribute("origin", origin);
			Block block = queryBlockTxIDForUse(origin.getTxid(),channelUser.getSecretkey());
			model.addAttribute("block", block);
		}
		return "management/showQrcode";
	}
	/**
	 * 跳转到table2.jsp
	 * @return
	 */
	@RequestMapping("skipPageTable2")
	public String skipPageTable2(){
		return "management/table2";
	}
	/**
	 * 二维码内容
	 * @return
	 */
	@RequestMapping("/qrcodeContent.do")
	public String qrcodeContent(int id,Model model){
		Origin origin = originService.queryById(id);
		List<Admin> listAdmin = originService.queryAdmin();
		Admin admin = listAdmin.get(0);
		Block block = queryBlockTxIDForUse(origin.getTxid(),admin.getToken());
		model.addAttribute("origin", origin);
		model.addAttribute("block", block);
		return "management/qrcodeContent";
	}
	/**
	 * 查询所有溯源信息
	 * @return
	 */
	@RequestMapping("/getAllOrigins.do")
	@ResponseBody
	public Layui getAllOrigins(Integer page,Integer limit,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		List<Origin> list = originService.getAllOrigins((page-1)*limit,limit,channelUser.getChannelidentifier());
		int count = originService.queryCount(channelUser.getChannelidentifier());
		return  Layui.data(count, list);
	}
	/**
	 * 查询未存入区块溯源信息
	 * @return
	 */
	@RequestMapping("/getNoBlockOrigins.do")
	@ResponseBody
	public Map<String, Object> getNoBlockOrigins(Integer page,Integer limit,HttpSession session){
		Map<String, Object> r = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if(channelUser!=null){
			List<Origin> list = originService.getNoBlockOrigins((page-1)*limit,limit,channelUser.getId());
			int count = originService.getNoCount(channelUser.getId());
			r.put("code", 0);
	        r.put("msg", "查询成功！");
	        r.put("count", count);
	        r.put("data", list);
	        r.put("limit", 10);
		}else{
			r.put("userCode", 0);
		}
	
		return  r;
	}

	/**
	 * 查询已存入区块溯源信息
	 * @return
	 */
	@RequestMapping("/getBlockOrigins.do")
	@ResponseBody
	public  Map<String, Object> getBlockOrigins(Integer page,Integer limit, HttpSession session){
		
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		List<Origin> list = originService.getBlockOrigins((page-1)*limit,limit,channelUser.getId());
		int count = originService.getYesCount(channelUser.getId());
		return  Layui.data(count, list);
	}
	/**
	 * 根据id查询溯源个人信息
	 * @param id
	 * @return
	 */
	@RequestMapping("/queryById.do")
	@ResponseBody
	public Layui queryById(Integer id){
		Origin origin = originService.queryById(id);
		List<Origin> list = new ArrayList<Origin>();
		list.add(origin);
		return Layui.data(list.size(), list);
	}
	/**
	 * 删除溯源个人信息
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteOrigin.do")
	@ResponseBody
	public Map<String, Object> deleteOrigin(Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		originService.deleteOrigin(id);
		result.put("result", result);
		return result;
	}
	/**
	 * 根据交易ID或数据hash查询信息
	 * @param searchContent
	 * @param model
	 * @return
	 */
	@RequestMapping("/queryByTxIDOrHash.do")
	public String queryByTxIDOrHash(String searchContent,Model model,HttpSession session){
		 ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		 Origin origin = originService.queryByTxIdOrHash(searchContent);
		 if(origin!=null){
			model.addAttribute("origin", origin);
			Block block = queryBlockTxIDForUse(origin.getTxid(),channelUser.getSecretkey());
			model.addAttribute("block", block);
		 }
		return "management/showQrcode";
	}
	/**
	 * 查询区块list
	 * @return
	 */
	@RequestMapping("/queryBlocks.do")
	@ResponseBody
	public Layui queryBlocks(String searchContent,HttpSession session,String totalCount){
		if(searchContent==null || searchContent.equals("")){
			Map<String, Object> newMap = new HashMap<String, Object>();
			ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
			if (totalCount==null || totalCount.equals("")) {
				totalCount="10";
			}
			newMap.put("totalCount", totalCount);
			newMap.put("sessionKey", channelUser.getSecretkey());
			String jsonData = NewApiUtil.queryDataFromChain(newMap);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			String codeStr = jsonObject.getString("Code");
			List<Block> list = new ArrayList<Block>();
			if (codeStr.equals("success")) {
				JSONArray jsonArray = jsonObject.getJSONArray("blockList");
				for(int i=0;i<jsonArray.size();i++){
					JSONObject blockjson = JSONObject.fromObject(JSONObject.fromObject(jsonArray.get(i)).get("data"));
					if (blockjson.getBoolean("success")==true) {
						String currentHash = blockjson.getString("current_hash");
						String previousHash = blockjson.getString("previous_hash");
						String dataHash = blockjson.getString("data_hash");
						String transactions = blockjson.getString("transactions");
						String blockNumber = blockjson.getString("number");
						JSONArray array = JSONArray.fromObject(transactions);
						Iterator<Object> it = array.iterator();
						List<Transaction> transactionList=new ArrayList<Transaction>();
						while (it.hasNext()) {
							JSONObject ob = (JSONObject) it.next();
							Transaction transaction = null;
							if(ob.getString("tx_id")!=null){
								transaction=new Transaction();
								transaction.setTx_id(ob.getString("tx_id"));
							}
							if(ob.getString("proposal_hash")!=null){
								transaction.setProposal_hash(ob.getString("proposal_hash"));
							}
							if(ob.getString("payload")!=null){
								transaction.setPayload(ob.getString("payload"));
							}
							if(ob.getString("timestamp")!=null){
								transaction.setTimestamp(ob.getString("timestamp"));
							}
							if(transaction!=null){
								transactionList.add(transaction);
							}
						}
						Block block = new Block();
						block.setCurrentHash(currentHash);
						block.setPreviousHash(previousHash);
						block.setNumber(blockNumber);
						block.setDataHash(dataHash);
						block.setTransactions(transactionList);
						list.add(block);
					}
				}
			}
			return Layui.data(list.size(), list);
		}else{
			return queryByNumberOrHash(searchContent,session);
		}
	}
	/**
	 * 根据交易ID区块信息
	 * @param number
	 * @return
	 */
	@RequestMapping("/queryBlockTxID.do")
	@ResponseBody
	public Layui queryBlockTxID(String txID,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		map.put("sessionKey", channelUser.getSecretkey());
		map.put("txID", txID);
		String jsonData = NewApiUtil.queryBlockByTxID(map);
		JSONObject jsonObject = JSONObject.fromObject(jsonData);
		List<Block> list = new ArrayList<Block>();
		if (jsonObject.getString("Code").equals("success")) {
			String blockStr=jsonObject.getString("data");
			JSONObject blockjson = JSONObject.fromObject(blockStr);
			String currentHash = blockjson.getString("current_hash");
			String previousHash = blockjson.getString("previous_hash");
			String dataHash = blockjson.getString("data_hash");
			String transactions = blockjson.getString("transactions");
			String blockNumber = blockjson.getString("number");
			JSONArray array = JSONArray.fromObject(transactions);
			Iterator<Object> it = array.iterator();
			List<Transaction> transactionList=new ArrayList<Transaction>();
			while (it.hasNext()) {
				JSONObject ob = (JSONObject) it.next();
				Transaction transaction = null;
				if(ob.getString("tx_id")!=null){
					transaction=new Transaction();
					transaction.setTx_id(ob.getString("tx_id"));
				}
				if(ob.getString("proposal_hash")!=null){
					transaction.setProposal_hash(ob.getString("proposal_hash"));
				}
				if(ob.getString("payload")!=null){
					transaction.setPayload(ob.getString("payload"));
				}
				if(ob.getString("timestamp")!=null){
					transaction.setTimestamp(ob.getString("timestamp"));
				}
				if(transaction!=null){
					transactionList.add(transaction);
				}
			}
			Block block = new Block();
			block.setCurrentHash(currentHash);
			block.setPreviousHash(previousHash);
			block.setNumber(blockNumber);
			block.setDataHash(dataHash);
			block.setTransactions(transactionList);
			list.add(block);
		}
		
		return Layui.data(list.size(), list);
	}
	/**
	 * 根据区块编号或区块hash查询区块信息
	 * @param number
	 * @return
	 */
	@RequestMapping("/queryByNumberOrHash.do")
	@ResponseBody
	public Layui queryByNumberOrHash(String number,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		map.put("sessionKey", channelUser.getSecretkey());
		String blockStr="";
		if(number.length()>11){
			map.put("blockHash", number);
			String jsonData = NewApiUtil.queryBlockByHash(map);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			if (jsonObject.getString("Code").equals("success")) {
				blockStr=jsonObject.getString("data");
			}
		}else{
			map.put("blockNumber", number);
			String jsonData = NewApiUtil.queryBlockByNumber(map);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			if (jsonObject.getString("Code").equals("success")) {
				blockStr=jsonObject.getString("data");
			}
		}
		JSONObject blockjson = JSONObject.fromObject(blockStr);
		String currentHash = blockjson.getString("current_hash");
		String previousHash = blockjson.getString("previous_hash");
		String dataHash = blockjson.getString("data_hash");
		String transactions = blockjson.getString("transactions");
		String blockNumber = blockjson.getString("number");
		JSONArray array = JSONArray.fromObject(transactions);
		Iterator<Object> it = array.iterator();
		List<Transaction> transactionList=new ArrayList<Transaction>();
		while (it.hasNext()) {
			JSONObject ob = (JSONObject) it.next();
			Transaction transaction = null;
			if(ob.getString("tx_id")!=null){
				transaction=new Transaction();
				transaction.setTx_id(ob.getString("tx_id"));
			}
			if(ob.getString("proposal_hash")!=null){
				transaction.setProposal_hash(ob.getString("proposal_hash"));
			}
			if(ob.getString("payload")!=null){
				transaction.setPayload(ob.getString("payload"));
			}
			if(ob.getString("timestamp")!=null){
				transaction.setTimestamp(ob.getString("timestamp"));
			}
			if(transaction!=null){
				transactionList.add(transaction);
			}
		}
		Block block = new Block();
		block.setCurrentHash(currentHash);
		block.setPreviousHash(previousHash);
		block.setNumber(blockNumber);
		block.setDataHash(dataHash);
		block.setTransactions(transactionList);
		List<Block> list = new ArrayList<Block>();
		list.add(block);
		return Layui.data(list.size(), list);
	}
	/**
	 * 根据区块编号查询区块详情
	 * @param number
	 * @return
	 */
	@RequestMapping("/queryBlockByNumber.do")
	public String queryBlockByNumber(String number,Model model,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		map.put("sessionKey", channelUser.getSecretkey());
		map.put("blockNumber", number);
		String jsonData = NewApiUtil.queryBlockByNumber(map);
		JSONObject jsonObject = JSONObject.fromObject(jsonData);
		if (jsonObject.getString("Code").equals("success")) {
			String blockStr=jsonObject.getString("data");
			JSONObject blockjson = JSONObject.fromObject(blockStr);
			String currentHash = blockjson.getString("current_hash");
			String previousHash = blockjson.getString("previous_hash");
			String dataHash = blockjson.getString("data_hash");
			String transactions = blockjson.getString("transactions");
			JSONArray array = JSONArray.fromObject(transactions);
			Iterator<Object> it = array.iterator();
			List<Transaction> transactionList=new ArrayList<Transaction>();
			while (it.hasNext()) {
				JSONObject ob = (JSONObject) it.next();
				Transaction transaction = null;
				if(ob.getString("tx_id")!=null){
					transaction=new Transaction();
					transaction.setTx_id(ob.getString("tx_id"));
				}
				if(ob.getString("proposal_hash")!=null){
					transaction.setProposal_hash(ob.getString("proposal_hash"));
				}
				if(ob.getString("payload")!=null){
					transaction.setPayload(ob.getString("payload"));
				}
				if(ob.getString("timestamp")!=null){
					transaction.setTimestamp(ob.getString("timestamp"));
				}
				if(transaction!=null){
					transactionList.add(transaction);
				}
			}
			Block block = new Block();
			block.setCurrentHash(currentHash);
			block.setPreviousHash(previousHash);
			block.setNumber(number);
			block.setDataHash(dataHash);
			block.setTransactions(transactionList);
			model.addAttribute("block", block);
		}
		return "management/blockDetail";
	}
	/**
	 * 数据加密
	 * @param content
	 * @return
	 */
	@RequestMapping("/encryptData.do")
	@ResponseBody
	public Map<String, Object> encryptData(String content,String enCodeRules){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String aesEncode = encryptionUtil.AESEncode(enCodeRules, content);
			result.put("code", 1);
			result.put("data", aesEncode);
		} catch (Exception e) {
			result.put("code", 0);
		}
		return result;
	}
	/**
	 * 数据解密
	 * @param content
	 * @return
	 */
	@RequestMapping("/decryptData.do")
	@ResponseBody
	public Map<String, Object> decryptData(String content,String enCodeRules){
		Map<String, Object> result = new HashMap<String, Object>();
		JSONObject json =null;
		try {
			json = JSONObject.fromObject(content);
			String value1 = json.getString("value1");
			String aesDncode1 = encryptionUtil.AESDncode(enCodeRules, value1);
			if (aesDncode1==null) {
				json.put("value1", value1);
			}else{
				json.put("value1", aesDncode1);
			}

			String value2 = json.getString("value2");
			String aesDncode2 = encryptionUtil.AESDncode(enCodeRules, value2);
			if (aesDncode2==null) {
				json.put("value2", value2);
			}else{
				json.put("value2", aesDncode2);
			}
		
			String value3 = json.getString("value3");
			String aesDncode3 = encryptionUtil.AESDncode(enCodeRules, value3);
			if (aesDncode3==null) {
				json.put("value3", value3);
			}else{
				json.put("value3", aesDncode3);
			}
		
			
			String value4 = json.getString("value4");
			String aesDncode4 = encryptionUtil.AESDncode(enCodeRules, value4);
			if (aesDncode4==null) {
				json.put("value4", value4);
			}else{
				json.put("value4", aesDncode4);
			}
		
			
			result.put("code", 1);
			result.put("data", json.toString());
		} catch (Exception e) {
			result.put("code", 0);
		}
		return result;
	}
	public static void main(String[] args) {
		Map<String, Object> map = new OriginController().decryptData("{'value1': 'lrGCx7cCI83M0ZQCMgD/VQ==','value2': '视频','value3': '12s','value4': '794mQBe2BUDI5Guy/7T/ufdFTY/RZCDi287ASWWWVGs=','value5': '保护环境--北京邮电大学','value6': '2018-10-26 21:16:19','value7': '617b193b00480460fdc67a1eff2ae374319883b0fd94e0778bcff77c0abc65a1'}", "cpsec");
	}
	/**
	 * 连通性测试
	 * @param IPAddress
	 * @param userName
	 * @param password
	 * @return
	 */
	@RequestMapping("connectivityTest.do")
	@ResponseBody
	public Map<String, Object> connectivityTest(String IPAddress,String userName,String password,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		//0 用户名或密码不正确；  1 连通性测试成功；  2 连通性测试失败
		if(userName!=null && !userName.equals("") && password!=null && !password.equals("")){
			if (channelUser!=null ){
				if(channelUser.getUsername().equals(userName)&& channelUser.getPassword().equals(password)) {
					if(IPAddress!=null && !IPAddress.equals("")){
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("IPAddress", IPAddress);
						Response response = HttpUtil.postJson(YmConfiguration.APIServer+"connectivityTest.do", map);
						JSONObject jsonObject = JSONObject.fromObject(response.getBody());
						if(jsonObject.getString("Code").equals("success")){
							result.put("code", 1);
						}else{
							result.put("code", 2);
						}
					}
				}else{
					result.put("code", 0);
				}
			}else{
				result.put("code", 0);
			}
		}else{
			result.put("code", 0);
		}
		return result;
	}
	/**
	 * 修改数据
	 * @param name
	 * @param area
	 * @param identifier
	 * @param quality
	 * @param examine
	 * @param id
	 * @return
	 */
	@RequestMapping("/updateOrigin.do")
	@ResponseBody
	public Map<String, Object> updateOrigin(String name,String area,String identifier,String quality,String examine,Integer id){
		Map<String, Object> result = new HashMap<String, Object>();
		Origin origin = originService.queryById(id);
		if (origin!=null) {
			origin.setArea(area);
			origin.setName(name);
			origin.setIdentifier(identifier);
			origin.setQuality(quality);
			origin.setExamine(examine);
			originService.updateOrigin(origin);
			result.put("code", 1);
		}else{
			result.put("code", 0);
		}
		return result;
	}
	
	/**
	 *跳转到书画作品页面
	 * @return
	 */
	@RequestMapping("/showCalligraphy.do")
	public String showQrcode(String type,Model model,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		//List<Origin> list = originService.getShowCalligraphyBlockOrigins(type,channelUser.getId());
		//model.addAttribute("origins", list);
		return "home/homepage";
	}
	
	/**
	 *查询视频信息
	 * @return
	 *//*
	@RequestMapping("/showCalligraVideo.do")
	@ResponseBody
	public  Map<String, Object> showCalligraVideo(String type,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
			List<Origin> list = originService.getShowCalligraphyBlockOrigins(type,channelUser.getId());
			result.put("flag", "success");
			result.put("origins", list);
		}catch(Exception e){
			result.put("flag", "error");
			e.printStackTrace();
		}
		
		return result;
	}*/
	/**
	 *分页查询 图片、视频	信息
	 * @return
	 */
	@RequestMapping("/showCalligraVideo.do")
	@ResponseBody
	public Map<String, Object> showCalligraVideo(String type,Integer page,Integer limit, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		List<Origin> list = originService.getShowCalligraphyBlockOrigins(type,(page-1)*limit,limit,channelUser.getId());
		int count = originService.getShowCalligraphyBlockOriginsCount(channelUser.getId(),type);
		result.put("flag", "success");
		result.put("origins", list);
		result.put("code", 0);
		result.put("msg", "查询成功！");
		result.put("totalCount", count);
		result.put("page", page);
		result.put("limit", 10);
		return result;
	}
	
	
	
	
	
    @RequestMapping(value="/selectnum.do")
		@ResponseBody
		public Map<String, Object> selectnum(Integer id){
			Map<String, Object> rs=new HashMap<String, Object>();
			Licence licence=originService.selectlicence(id);
			if(licence!=null){
				
				rs.put("num",licence.getNum());
				rs.put("total", licence.getTotal());
				
				if(licence.getNum()!=0){
					channelUserService.numless(id);
				  }
			}else{
				rs.put("num",0);
				rs.put("msg", "该文件未添加许可证");
			}		
			return rs;
		}
    
    /**
     * 查询视频播放次数
     * @param id
     * @return
     */
    @RequestMapping(value="/selectVideonum.do")
	@ResponseBody
	public Map<String, Object> selectVideonum(Integer id){
		Map<String, Object> rs=new HashMap<String, Object>();
		//通过id查询版权信息
		Origin origin=originService.queryById(id);
		if(origin!=null){
			
			rs.put("num",origin.getNum());
			rs.put("total", origin.getTotal());
			
			if(origin.getNum()!=0){
				Origin o = new Origin();
				o.setId(id);
				o.setNum(origin.getNum()-1);
				originService.updateOrigin(o);
			  }
		}else{
			rs.put("num",0);
			rs.put("msg", "该文件未添加许可证");
		}		
		return rs;
	}
    
    /**
     * 添加用户视频播放token
     * @param id
     * @return
     */
    @RequestMapping(value="/addVideoToken.do")
	@ResponseBody
	public Map<String, Object> addVideoToken(VideoToken videoToken,HttpServletRequest request){
		Map<String, Object> rs=new HashMap<String, Object>();
		HttpSession session = request.getSession();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser"); 
		int count =0;
		try{
			if(channelUser!=null){
				
				videoToken.setUserId(channelUser.getId());
				videoToken.setUserName(channelUser.getUsername());
				VideoToken v = originService.selectVideoTokenByUserId(videoToken);
				if(v!=null){//判断用户视频许可是否已存在，如果存在，修改数据
					 videoToken.setId(v.getId());
					 count =originService.updateVideoTokenById(videoToken);
					 if(count>0){
						 rs.put("code", 1);
						 rs.put("msg", "修改成功");
					 }
				}else{//视频许可未添加
					count = originService.addVideoToken(videoToken);
					if(count>0){
						rs.put("code", 1);
						rs.put("msg", "添加成功");
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			if(count>0){
				rs.put("code", 0);
				rs.put("msg", "保存异常，请联系管理员");
			}
		}
		
		return rs;
	}
    
    /**
     * 通过用户tocken来限制视频播放
     * @param id
     * @return
     */
    @RequestMapping(value="/selectVideoToken.do")
	@ResponseBody
	public Map<String, Object> selectVideoToken(HttpServletRequest request){
		Map<String, Object> rs=new HashMap<String, Object>();
		HttpSession session = request.getSession();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser"); 
		VideoToken videoToken = new VideoToken();
		try{
			//通过用户id查询用户token，如果token值>10，则可以查看视频并播放
			if(channelUser!=null){
				//通过用户id查询视频token值
				videoToken.setUserId(channelUser.getId());
				VideoToken v = originService.selectVideoTokenByUserId(videoToken);
				if(v!=null && v.getToken()>=10){
					rs.put("code", "1");
					rs.put("total", v.getToken());
					rs.put("num", v.getToken()/10);
					v.setToken(v.getToken()-10);
					//修改用户token
					originService.updateVideoTokenById(v);
				}else{
					if(v!=null){
						rs.put("total", v.getToken());
						rs.put("num", v.getToken()/10);
					}else{
						rs.put("total", 0);
						rs.put("num", 0);
					}
					
					rs.put("code", "0");
					rs.put("msg", "该文件未添加许可证");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return rs;
	}
    
    /**
	 *跳转到视频权限管理
	 * @return
	 */
	@RequestMapping("/showLicensesJsp.do")
	public String showLicensesJsp(String type,Model model,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");//通过session获取用户信息
		VideoToken videoToken = new VideoToken();
		if(channelUser!=null){
			videoToken.setUserId(channelUser.getId());
			VideoToken v = originService.selectVideoTokenByUserId(videoToken);
	        model.addAttribute("videoToken", v);
	    }else{
	    	return "userLogin";
	    }
		return "SystemSet/licences";
	}
}

// 版本控制 test 第一次修改