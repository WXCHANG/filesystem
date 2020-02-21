package com.wxc.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wxc.entity.Block;
import com.wxc.entity.Transaction;
import com.wxc.httputil.NewApiUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class PeerController {
	/**
	 * 查询所有节点区块信息
	 * @param channelname
	 * @param description
	 */
	@RequestMapping("/queryPeerDataInfo.do")
	@ResponseBody
	public Map<String, Object> queryPeerDataInfo(String hash,String identifier,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		//底层peer信息
		Map<String, Object> map = new HashMap<String, Object>();
		//底层peer节点
		Map<String, Object> mapPeer = new HashMap<String, Object>();
		List<Block> list = new ArrayList<Block>();
		try {
			if(hash==null||"".equals(hash)){
				result.put("msg", "条件不能为空，请输入hash值");
				result.put("code", 0);
			}
			//2.查询底层节点数据信息(底层接口路径还没改)
			String data = NewApiUtil.queryPeers(map);
			if(data!=null && data!=""){
				JSONObject json = JSONObject.fromObject(data);
				if("false".equals(json.getString("success"))){
					
					result.put("code", json.getString("code"));
					result.put("mag", "当前区块链数据异常，未查到匹配的数据");
					return result;
				}
				String nodes = json.getString("peers");
				if(nodes!=null && nodes!=""){//如果节点不为空
					JSONArray nodeArray = JSONArray.fromObject(nodes);
					//所有节点信息
					List<String> peers = (List) JSONArray.toCollection(nodeArray, String.class); 
					//通过hash,调用底层接口，得到区块信息和hash
					mapPeer.put("hash", hash);
					String bl = NewApiUtil.queryPeerBlock(mapPeer);	
					JSONObject jsonData = JSONObject.fromObject(bl);
					if (jsonData.getString("Code").equals("success")) {
						JSONObject bljson = JSONObject.fromObject(jsonData.get("data"));
						//得到通道信息
						String channel = bljson.getString("channel");
						mapPeer.put("channel", channel);
						
						//3.遍历底层数据信息，
						for(String peer: peers){//遍历底层节点
							mapPeer.put("peer", peer);
							String blockStr = NewApiUtil.queryPeerBlock(mapPeer);
							if("false".equals(json.getString("success"))){
								
								result.put("code", "0");
								result.put("mag", "无数据");
								return result;
							}
							if(blockStr==null || blockStr==""){
								result.put("data", list);
								result.put("count", 0);
								result.put("code", 0);
								result.put("mag", "");
								return result;
							}
							JSONObject jsonBlockData = JSONObject.fromObject(blockStr);
							if (jsonBlockData.getString("Code").equals("success")) {
								JSONObject blockjson = JSONObject.fromObject(jsonBlockData.get("data"));
								String currentHash = blockjson.getString("current_hash");
								String previousHash = blockjson.getString("previous_hash");
								String dataHash = blockjson.getString("data_hash");
								String transactions = blockjson.getString("transactions");
								String pr = blockjson.getString("peer");
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
								block.setPeer(pr);
								block.setTransactions(transactionList);
								
								list.add(block);
								
							}
							
						}
							//4，如果没有找到相同的节点名称，将其添加到list中，批量保存到数据库中
					}else{
						result.put("code", "0");
						result.put("mag", "当前区块链数据异常，未查到匹配的数据");
						return result;
					}
				}
				
			}
		
			result.put("data", list);
			result.put("count", list.size());
			result.put("code", 0);
			result.put("mag", "数据查询完成");
			return result;
		} catch (Exception e) {
			
			result.put("code", 2);
			result.put("mag", "数据异常，请联系管理员");
			e.printStackTrace();
			
			return result;
			
		}
	
	}
	/**
	 * 查询所有节点信息
	 * @param channelname
	 * @param description
	 */
	@RequestMapping("/queryDefaultPeerDataInfo.do")
	@ResponseBody
	public Map<String, Object> queryDefaultPeerDataInfo(String hash,String identifier, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		List<Block> list = new ArrayList<Block>();
		
		map.put("hash",hash);
		map.put("identifier", identifier);
		String blockStr = NewApiUtil.queryPeerBlock(map);
		
		JSONObject jsonObject = JSONObject.fromObject(blockStr);
		if("success".equals(jsonObject.getString("Code"))){
			JSONObject blockjson = JSONObject.fromObject(jsonObject.get("data"));
			String currentHash = blockjson.getString("current_hash");
			String previousHash = blockjson.getString("previous_hash");
			String dataHash = blockjson.getString("data_hash");
			String pr = blockjson.getString("peer");
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
			block.setPeer(pr);
			block.setTransactions(transactionList);
			
			list.add(block);
			result.put("data", list);
			result.put("count", list.size());
			result.put("code", 0);
			result.put("mag", "数据查询完成");
			return result;
		}
		result.put("code", "0");
		result.put("mag", "无数据");
		return result;
	}
}
