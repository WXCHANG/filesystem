package com.wxc.httputil;

import java.util.HashMap;
import java.util.Map;

import com.wxc.util.YmConfiguration;


public class NewApiUtil {
	private static final String BASE_URL = YmConfiguration.url;
	private static final String GETADMINSESSIONKEY_URL = BASE_URL+"/api/user/getAdminSessionKey";
	private static final String CREATECHANNEL_URL = BASE_URL+"/api/chain/createChannel";
	private static final String CREATEUSERFORUSERSESSIONKEY_URL = BASE_URL+"/api/user/createUserForUserSessionKey";
	private static final String CREATEBLOCKDATA_URL = BASE_URL+"/api/chain/createBlockData";
	private static final String CREATEBLOCKDATAEX_URL = BASE_URL+"/api/chain/createBlockDataEx";
	private static final String QUERYBLOCKBYNUMBER_URL = BASE_URL+"/api/chain/queryBlockByNumber";
	private static final String QUERYBLOCKBYHASH_URL = BASE_URL+"/api/chain/queryBlockByHash";
	private static final String QUERYDATAFROMCHAIN_URL = BASE_URL+"/api/chain/queryDataFromChain";
	private static final String QUERYNEWESTBLOCK_URL = BASE_URL+"/api/chain/queryNewestBlock";
	private static final String QUERYBLOCKBYTXID_URL = BASE_URL+"/api/chain/queryBlockByTxID";
	private static final String QUERY_PEERS_URL = BASE_URL+"/api/chain/peers";
	private static final String QUERY_PEER_BLOCK_URL = BASE_URL+"/api/chain/peer/block/channels/blockhash";
	
	/**
	 * 获取底层管理员密钥
	 * @param map
	 * @return
	 */
	public static String getAdminSessionKey(Map<String, Object> map) {
		Response res = HttpUtil.postJson(GETADMINSESSIONKEY_URL, map);
		return res.getBody();
	}
	/**
	 * 创建通道
	 * @param map
	 * @return
	 */
	public static String createChannel(Map<String, Object> map) {
		Response res = HttpUtil.postJson(CREATECHANNEL_URL, map);
		return res.getBody();
	}
	/**
	 * 创建用户
	 * @param map
	 * @return
	 */
	public static String createUserForUserSessionKey(Map<String, Object> map) {
		Response res = HttpUtil.postJson(CREATEUSERFORUSERSESSIONKEY_URL, map);
		return res.getBody();
	}
	/**
	 * 数据上链
	 * @param map
	 * @return
	 */
	public static String createBlockData(Map<String, Object> map) {
		Response res = HttpUtil.postJson(CREATEBLOCKDATA_URL, map);
		return res.getBody();
	}
	/**
	 * 根据区块编号查询区块信息
	 * @param map
	 * @return
	 */
	public static String queryBlockByNumber(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERYBLOCKBYNUMBER_URL, map);
		return res.getBody();
	}
	/**
	 * 数据上链拓展
	 * @param map
	 * @return
	 */
	public static String createBlockDataEx(Map<String, Object> map) {
		Response res = HttpUtil.postJson(CREATEBLOCKDATAEX_URL, map);
		return res.getBody();
	}
	/**
	 * 根据区块Hash查询区块信息
	 * @param map
	 * @return
	 */
	public static String queryBlockByHash(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERYBLOCKBYHASH_URL, map);
		return res.getBody();
	}
	/**
	 * 根据区块概要信息列表
	 * @param map
	 * @return
	 */
	public static String queryDataFromChain(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERYDATAFROMCHAIN_URL, map);
		return res.getBody();
	}
	/**
	 * 根据最新区块信息
	 * @param map
	 * @return
	 */
	public static String queryNewestBlock(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERYNEWESTBLOCK_URL, map);
		return res.getBody();
	}
	/**
	 * 根据TX_ID查询区块信息
	 * @param map
	 * @return
	 */
	public static String queryBlockByTxID(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERYBLOCKBYTXID_URL, map);
		return res.getBody();
	}
	/**
	 * 查询所有Peer信息
	 * @param map
	 * @return
	 */
	public static String queryPeers(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERY_PEERS_URL, map);
		return res.getBody();
	}
	/**
	 * 查询Peer区块信息
	 * @param map
	 * @return
	 */
	public static String queryPeerBlock(Map<String, Object> map) {
		Response res = HttpUtil.postJson(QUERY_PEER_BLOCK_URL, map);
		return res.getBody();
	}
	
	
	
	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("number", 10);
//		map.put("txid", "02d03c6b0ff7dc50e5e8350ac4444feba7ef1071c830ea6bebca5e82f4dd5d22");
//		Response res = HttpUtil.postJson(TX_INFO_URL, map);
//		System.out.println(res.getBody());
//		Date date = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String applicationDate = sdf.format(date);
		//调用写入hyperledger区块接口
//		map.put("number", 4);
		//Response res = HttpUtil.postJson(INSERT_DATA, map);
//		String queryByNumber = queryByNumber(map);
//		System.out.println("block----"+queryByNumber);
		
	
	}

	
	
}
