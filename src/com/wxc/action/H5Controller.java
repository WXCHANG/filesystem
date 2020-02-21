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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wxc.entity.ApplicationData;
import com.wxc.entity.Block;
import com.wxc.entity.ChannelUser;
import com.wxc.entity.Origin;
import com.wxc.entity.Transaction;
import com.wxc.httputil.NewApiUtil;
import com.wxc.service.ApplicationDataService;
import com.wxc.service.ChannelUserService;
import com.wxc.util.CryptoUtil;
import com.wxc.util.Layui;
import com.wxc.util.MD5Util;
import com.wxc.util.YmConfiguration;
import com.wxc.util.ZXingCode;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class H5Controller {
	@Resource
	private ChannelUserService channelUserService;
	@Resource
	private ApplicationDataService applicationDataService;
	/**
	 * 用户登录
	 * @param name
	 * @param password
	 * @return
	 */
	@RequestMapping("/userLogin.do")
	@ResponseBody
	public Map<String, Object> userLogin(String name,String password,HttpSession session,HttpServletRequest request){
		Map<String, Object> result = new HashMap<String, Object>();
		//通道管理员
		ChannelUser channeluser = channelUserService.channelUserLogin(name,password);
		if(channeluser != null){
			if("0".equals(channeluser.getAuditstatus())){
				result.put("tip", "用户信息未审核");
			}else if("2".equals(channeluser.getAuditstatus())) {
				result.put("tip", "用户信息审核中");
			}else if("1".equals(channeluser.getAuditstatus())) {
				result.put("tip", "用户信息已审核");
			}
			session.setAttribute("channelUser", channeluser);
			
			result.put("code", 0);//通道管理员成功跳转
			result.put("userName", name);
			result.put("msg", "用户登录成功！");
		}else {
			result.put("code", 1);//用户名或密码错误
			result.put("msg", "用户名或密码错误！");
		}
		return result;
	}
	/**
	 * 保存数据信息
	 * @param id
	 * @param value1
	 * @param value1Encrypt
	 * @param value2
	 * @param value2Encrypt
	 * @param value3
	 * @param value3Encrypt
	 * @param value4
	 * @param value4Encrypt
	 * @param value6
	 * @param value5
	 * @param request
	 * @return
	 */
	@RequestMapping("/addOrUpdateData.do")
	@ResponseBody
	public Map<String, Object> addOrUpdateData(Integer id,String value1,String value1Encrypt,String value2,String value2Encrypt,String value3,
			String value3Encrypt,String value4,String value4Encrypt,String value6,
			@RequestParam(value = "value5", required = false) MultipartFile value5,HttpServletRequest request){
		Map<String, Object> result = new HashMap<String, Object>();
		if(id!=null){
			ApplicationData applicationData = applicationDataService.queryById(id);
			applicationData.setValue1(value1);
			applicationData.setValue2(value2);
			applicationData.setValue3(value3);
			applicationData.setValue4(value4);
			applicationData.setValue6(value6);
			applicationDataService.updateData(applicationData);
			result.put("code", 0);
			result.put("msg", "数据修改成功！");
		}else{
			HttpSession session = request.getSession();
			ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser"); 
			if (channelUser!=null) {
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String storageTime = sdf.format(date);
				String value5Hash = "";
				ApplicationData applicationData = new ApplicationData();
				if (value5!=null && !value5.isEmpty()) {
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
					//文件Hash
					value5Hash = MD5Util.getFileMD5(targetFile);
					applicationData.setValue5("upload/" + newName);
					applicationData.setValue5hash(value5Hash);
				}
				applicationData.setValue1(value1);
				applicationData.setValue1encrypt(value1Encrypt);
				applicationData.setValue2(value2);
				applicationData.setValue2encrypt(value2Encrypt);
				applicationData.setValue3(value3);
				applicationData.setValue3encrypt(value3Encrypt);
				applicationData.setValue4(value4);
				applicationData.setValue4encrypt(value4Encrypt);
				applicationData.setValue6(value6);
				applicationData.setUserid(channelUser.getId());
				applicationData.setStoragetime(storageTime);
				applicationData.setStatus(1);//未存入区块链
				//业务数据Hash值
				String hash = computeHash(value1, value1Encrypt, value2, value2Encrypt, value3, value3Encrypt, value4, value4Encrypt, value5Hash, value6);
				applicationData.setHash(hash);
				applicationData.setChannelname(channelUser.getChannelidentifier());
				//信息存储到数据库
				applicationDataService.insertData(applicationData);
				result.put("code", 0);
				result.put("msg", "数据添加成功！");
			}else{
				result.put("code", 1);
				result.put("msg", "超时请重新登录！");
			}
		}
		return result;
	}
	public String computeHash(String value1,String value1Encrypt,String value2,String value2Encrypt,String value3,String value3Encrypt,
			String value4,String value4Encrypt,String value5Hash,String value6){
		JSONObject jsonData = new JSONObject();
		if (value1Encrypt == null || value1Encrypt.equals("")) {
			jsonData.put("value1", value1);
		}else{
			jsonData.put("value1", value1Encrypt);
		}
		if (value2Encrypt == null || value2Encrypt.equals("")) {
			jsonData.put("value2", value2);
		}else{
			jsonData.put("value2", value2Encrypt);
		}
		if (value3Encrypt == null || value3Encrypt.equals("")) {
			jsonData.put("value3", value3);
		}else{
			jsonData.put("value3", value3Encrypt);
		}
		if (value4Encrypt == null || value4Encrypt.equals("")) {
			jsonData.put("value4", value4);
		}else{
			jsonData.put("value4",value4Encrypt);
		}
		jsonData.put("value5Hash", value5Hash);
		jsonData.put("value6", value6);
		String hash = CryptoUtil.getSHA256(jsonData.toString());
		return hash;
	}
	/**
	 * 保存数据到区块
	 * @param id
	 * @return
	 */
	@RequestMapping("/saveToBlock.do")
	@ResponseBody
	public Map<String, Object> saveToBlock(int id,HttpServletRequest request,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if (channelUser!=null) {
			ApplicationData applicationData = applicationDataService.queryById(id);
			JSONObject jsonData = new JSONObject();
			if (applicationData.getValue1encrypt()==null || applicationData.getValue1encrypt().equals("")) {
				jsonData.put("value1", applicationData.getValue1());
			}else{
				jsonData.put("value1", applicationData.getValue1encrypt());
			}
			if (applicationData.getValue2encrypt()==null || applicationData.getValue2encrypt().equals("")) {
				jsonData.put("value2", applicationData.getValue2());
			}else{
				jsonData.put("value2", applicationData.getValue2encrypt());
			}
			if (applicationData.getValue3encrypt()==null || applicationData.getValue3encrypt().equals("")) {
				jsonData.put("value3", applicationData.getValue3());
			}else{
				jsonData.put("value3", applicationData.getValue3encrypt());
			}
			if (applicationData.getValue4encrypt()==null || applicationData.getValue4encrypt().equals("")) {
				jsonData.put("value4", applicationData.getValue4());
			}else{
				jsonData.put("value4", applicationData.getValue4encrypt());
			}
			jsonData.put("value5Hash", applicationData.getValue5hash());
			jsonData.put("value6", applicationData.getValue6());
			jsonData.put("hash", applicationData.getHash());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sessionKey", channelUser.getSecretkey());
			map.put("jsonData", jsonData);
			map.put("key", "CPSec"+id);
			
			String responseStr = NewApiUtil.createBlockDataEx(map);
			JSONObject jsonObject = JSONObject.fromObject(responseStr);
			String codeStr = jsonObject.getString("Code");
			if (codeStr.equals("success")) {
				try {
					JSONObject json = JSONObject.fromObject(jsonObject.getString("data"));
					String txid= json.getString("txid");
					applicationData.setTxid(txid);
					long fileName = System.currentTimeMillis();
					String path = request.getSession().getServletContext()
							.getRealPath("upload/qrcode");
					File logoFile = new File(request.getSession().getServletContext().getRealPath("images")+"/bupt.png");
					File QrCodeFile = new File(path+"/"+fileName+".png");
					ZXingCode.drawLogoQRCode(logoFile, QrCodeFile, YmConfiguration.server+YmConfiguration.projectName+"/queryQrcodeContent.do?id="+id, "");
					applicationData.setQrcode("upload/qrcode/"+fileName+".png");
					applicationData.setStatus(0);
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					applicationData.setSavetime(dateFormat.format(new Date()));
					applicationDataService.updateData(applicationData);
					result.put("code",0);//上链成功
					result.put("msg", "数据上链成功！");
				} catch (Exception e) {
					//保存失败
					applicationData.setStatus(0);
					applicationDataService.updateData(applicationData);
					result.put("code",1);
					result.put("msg", "数据上链失败！");
				}
			}else{
				result.put("code",1);
				result.put("msg", "数据上链失败！");
			}
		}else{
			result.put("code",1);
			result.put("msg", "超时请重新登录！");
		}
		
		return result;
	}
	/**
	 * 查询未上链数据
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryNoSavedData.do")
	@ResponseBody
	public Layui queryNoSavedData(Integer page,Integer limit,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if (channelUser==null) {
			Layui layui = new Layui();
			layui.put("code", 1);
			layui.put("msg", "超时请重新登录！");
			return layui;
		}
		List<Origin> list = applicationDataService.queryNoSavedData(page,limit,channelUser.getId());
		int count = applicationDataService.queryNoSavedCount(channelUser.getId());
		return  Layui.data(count, list);
	}
	/**
	 * 查询已上链数据
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/querySavedData.do")
	@ResponseBody
	public Layui querySavedData(Integer page,Integer limit,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if (channelUser==null) {
			Layui layui = new Layui();
			layui.put("code", 1);
			layui.put("msg", "超时请重新登录！");
			return layui;
		}
		List<Origin> list = applicationDataService.querySavedData(page,limit,channelUser.getId());
		int count = applicationDataService.querySavedCount(channelUser.getId());
		return  Layui.data(count, list);
	}
	/**
	 * 查询全部数据
	 * @param page
	 * @param limit
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryAllData.do")
	@ResponseBody
	public Layui queryAllData(Integer page,Integer limit,HttpSession session){
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if (channelUser==null) {
			Layui layui = new Layui();
			layui.put("code", 1);
			layui.put("msg", "超时请重新登录！");
			return layui;
		}
		List<Origin> list = applicationDataService.queryAllData(page,limit,channelUser.getId());
		int count = applicationDataService.queryAllCount(channelUser.getId());
		return  Layui.data(count, list);
	}
	/**
	 * 二维码内容
	 * @param dataId
	 * @return
	 */
	@RequestMapping("/queryQrcodeContent.do")
	@ResponseBody
	public Map<String, Object> queryQrcodeContent(int dataId){
		Map<String, Object> result = new HashMap<String, Object>();
		ApplicationData applicationData = applicationDataService.queryById(dataId);
		List<ChannelUser> channelUsers = channelUserService.getChannelUser("admin");
		if (channelUsers!=null && channelUsers.size()>0) {
			ChannelUser channelUser = channelUsers.get(0);
			Block block = queryByTxId(applicationData.getTxid(), channelUser.getSecretkey());
			result.put("block", block);
		}
		result.put("applicationData", applicationData);
		result.put("code", 0);
		result.put("msg", "查询成功！");
		return result;
	}
	//根据交易ID查询区块链信息
	public Block queryByTxId(String txId, String sessionKey){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionKey", sessionKey);
		map.put("txID", txId);
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
	/**
	 * 查询区块列表
	 * @return
	 */
	@RequestMapping("/queryBlockList.do")
	@ResponseBody
	public Layui queryBlockList(HttpSession session,String totalCount){
			Map<String, Object> newMap = new HashMap<String, Object>();
			ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
			if (channelUser==null) {
				Layui layui = new Layui();
				layui.put("code", 1);
				layui.put("msg", "超时请重新登录！");
				return layui;
			}
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
	}
	/**
	 * 根据编号或Hash查询区块
	 * @param searchContent
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryBlockByNumOrHash.do")
	@ResponseBody
	public Map<String, Object> queryBlockByNumOrHash(String searchContent,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if (channelUser==null) {
			result.put("code", 1);
			result.put("msg", "超时请重新登录！");
			return result;
		}
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sessionKey", channelUser.getSecretkey());
			String blockStr="";
			if(searchContent.length()>11){
				map.put("blockHash", searchContent);
				String jsonData = NewApiUtil.queryBlockByHash(map);
				JSONObject jsonObject = JSONObject.fromObject(jsonData);
				if (jsonObject.getString("Code").equals("success")) {
					blockStr=jsonObject.getString("data");
				}
			}else{
				map.put("blockNumber", searchContent);
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
			result.put("code", 0);
			result.put("msg", "查询成功！");
			result.put("block", block);
		} catch (Exception e) {
			result.put("code", 1);
			result.put("msg", "查询失败！");
		}
		return result;
	}
	/**
	 *根据交易ID查询区块信息
	 * @param txId
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryBlockByTxId.do")
	@ResponseBody
	public Map<String, Object> queryBlockByTxId(String txId, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		ChannelUser channelUser = (ChannelUser) session.getAttribute("channelUser");
		if (channelUser==null) {
			result.put("code", 1);
			result.put("msg", "超时请重新登录！");
			return result;
		}
		if (txId!=null && !txId.equals("")) {
			Block block = queryByTxId(txId, channelUser.getSecretkey());
			result.put("code", 0);
			result.put("msg", "查询成功！");
			result.put("block", block);
		}else{
			result.put("code", 1);
			result.put("msg", "交易ID为空！");
		}
		return result;
	}
}
