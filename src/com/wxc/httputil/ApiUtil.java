package com.wxc.httputil;

import java.util.HashMap;
import java.util.Map;

import com.wxc.util.YmConfiguration;


public class ApiUtil {
	private static final String BASE_URL = YmConfiguration.url;
	private static final String BLOCK_INFO_URL = BASE_URL+"/api/block/getinfo";
	private static final String TX_INFO_URL = BASE_URL+"/api/tx/getinfo";
	private static final String INSERT_DATA = BASE_URL+"/api/v2.0/chain/block/transaction";
	private static final String NEW_BLOCK = BASE_URL+"/api/v2.0/chain/block/newestblock";
	private static final String QUERY_BLOCK = BASE_URL+"/api/v2.0/chain/block/number";
	private static final String QUERY_BLOCKBYHASH = BASE_URL+"/api/v2.0/chain/block/blockhash";
	private static final String ADD_USER_URL = BASE_URL+"/api/v2.0/user/account";
	private static final String DELETE_USER_URL = BASE_URL+"/api/v2.0/user/useless";
	private static final String GET_CONTAINERS_URL = BASE_URL+"/api/v2.0/monitor/containers";
	private static final String START_CONTAINER_URL = BASE_URL+"/api/v2.0/monitor/start/container";
	private static final String STOP_CONTAINER_URL = BASE_URL+"/api/v2.0/monitor/stop/container";
	private static final String LOGIN_URL = BASE_URL+"/login";
	private static final String CREATE_CHANNEL=BASE_URL+"/api/v2.0/chain/peer/newchannel";
	private static final String CONNECTIVITY_TEST = BASE_URL+"/test/chainnetwork";
	private static final String PEER_INFO = BASE_URL+"/api/v2.0/chain/peers";
	private static final String PEER_BLOCK_HASH = BASE_URL+"/api/v2.0/chain/peer/block/channels/blockhash";
	/**
	 * 链连通性测试
	 * @param map
	 * @return
	 */
	public static String connectivityTest(Map<String, Object> map) {
		Response res = HttpUtil.postJson(CONNECTIVITY_TEST, map);
		return res.getBody();
	}
	/**
	 * 创建通道
	 * @param map
	 * @return
	 */
	public static String createChannel(Map<String, Object> map) {
		Response res = HttpUtil.postJson(CREATE_CHANNEL, map);
		return res.getBody();
	}

	
	/**
	 * 获取容器名称
	 * @param map
	 * @return
	 */
	public static String getContainerName(Map<String, Object> map) {
		Response res = HttpUtil.postJson(GET_CONTAINERS_URL, map);
		return res.getBody();
	}
	
	/**
	 * 登录获取Token
	 * @param map
	 */
	public static String login(Map<String, Object> map) {
		Response res = HttpUtil.postJson(LOGIN_URL, map);
		return res.getBody();
	}
	/**
	 * 创建账户
	 * @param map
	 * @return
	 */
	public static String createAccount(Map<String, Object> map){
		Response res = HttpUtil.postJson(ADD_USER_URL, map);
		return res.getBody();
	}
	
	public static String deleteUser(Map<String, Object> map) {
		Response res = HttpUtil.postJson(DELETE_USER_URL, map);
		return res.getBody();
	}
	
	/**
	 * 开启节点容器
	 * @param map
	 * @return
	 */
	public static String startContainer(Map<String, Object> map){
		Response res = HttpUtil.postJson(START_CONTAINER_URL, map);
		return res.getBody();
	}
	
	/**
	 * 关闭节点容器
	 * @param map
	 * @return
	 */
	public static String stopContainer(Map<String, Object> map){
		Response res = HttpUtil.postJson(STOP_CONTAINER_URL, map);
		return res.getBody();
	}
	
	/**
	 * 查询区块信息
	 * @param map
	 * @return
	 */
	public static String getBlockInfo(Map<String, Object> map){
		Response res = HttpUtil.postJson(BLOCK_INFO_URL, map);
		return res.getBody();
	}
	/**
	 * 查询交易信息
	 * @param map
	 * @return
	 */
	public static String getTxInfo(Map<String, Object> map){
		Response res = HttpUtil.postJson(TX_INFO_URL, map);
		return res.getBody();
	}
	/**
	 * 向区块插入数据
	 * @param map
	 * @return
	 */
	public static String insertData(Map<String, Object> map){
		Response res = HttpUtil.postJson(INSERT_DATA, map);
		return res.getBody();
	}
	/**
	 * 获取最新区块数据
	 * @param map
	 * @return
	 */
	public static String getNewBlock(Map<String, Object> map){
		Response res = HttpUtil.postJson(NEW_BLOCK,map);
		return res.getBody();
	}
	/**
	 * 根据区块编号查询区块
	 * @param map
	 * @return
	 */
	public static String queryByNumber(Map<String, Object> map){
		Response res = HttpUtil.postJson(QUERY_BLOCK,map);
		return res.getBody();
	}
	/**
	 * 根据区块hash查询区块
	 * @param map
	 * @return
	 */
	public static String queryByHash(Map<String, Object> map){
		Response res = HttpUtil.postJson(QUERY_BLOCKBYHASH,map);
		return res.getBody();
	}
	/**
	 * 查询所有peer节点
	 * @param map
	 * @return
	 */
	public static String getAllPeerInfo(Map<String, Object> map) {
		Response res = HttpUtil.postJson(PEER_INFO, map);
		return res.getBody();
	}
	/**
	 * 通过hash查询区块信息
	 * @param map
	 * @return
	 */
	public static String getPeerBlockInfo(Map<String, Object> map) {
		Response res = HttpUtil.postJson(PEER_BLOCK_HASH, map);
		return res.getBody();
	}

	
	
	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("secret", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwib3JnbmFtZSI6Im9yZzEiLCJpYXQiOjE1MzAyNTc0OTV9.XJW8JH4P-l7fs14iF1Ev9MwdPqoDdGU9sxfiuqXoQnk");
		map.put("container_name", "peer1.org2.example.com");
		startContainer(map);
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
