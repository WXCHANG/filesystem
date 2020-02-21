package com.wxc.util;

import java.util.HashMap;
import java.util.Map;

public class Constants {
	
	//搜索附近的车位，范围的经纬度+�?某个�?
	public static final String RANGE = "range";
	
	//车位的状�?
	public static final String PACKINGLOTOPEN = "packinglotopen";
	public static final String PACKINGLOTCLOSE = "packinglotclose";
	//车位预定信息状�?
	public static final String RESERVEPACKINGLOT = "reservepackinglot";
	public static final String REMOVERESERVEPACKINGLOT = "removereservepackinglot";
	//停车记录；车俩进入车位，�?��停车
	public static final String STARTRECORD = "startrecord";
	//车辆节费完成，结束停�?
	public static final String STOPRECORD = "stopRecord";
	//惩罚倍数
	public static final String PUNISH = "punish";
	
	//设定用户预定车位后多长时间强制取消预�?
	public static final String HOWLONGTIME = "howlongtime";
	//车位消费者预定车位的key   
	public static final String CONSUMEUSER_RESERVEPARKINGLOT = "consumeUser_reserveParkingLot";
	//consumeUser(车位消费者进入search.jsp先根据openId去数据库查询的user放到session中的)
	public static final String CONSUMEUSER_LOGIN = "consumeUser_Login";
	public static Map<String, Object> ThreadMap = new HashMap<String, Object>();
	
	public static final String HQL_KEY = "hql_key";
	public static final String PARAM_KEY = "param_key";
	public static final String SERVER_PROPERTY_NAME = "server.properties";
	public static final String WECHAT_PROPERTY_NAME = "wechat.properties";

	public static final String RESERVETOTALCOST = "reservetotalcost";
	public static final String TOTALCOST = "totalcost";
	public static final String JSP = ".jsp";
	public static final String CODE = "code";
	public static final String EMPTY = "";
	public static final String DATA = "data";
	public static final String CODE_VALUE_FAILURE = "2";
	public static final String CODE_VALUE_SUCCESS = "1";
	public static final String CODE_VALUE_UNDEFINED = "3";
	public static final String CODE_VALUE_NOTFIND = "4";
	public static final String PDF = "pdf";
	public static final String VIDEO = "video";
	public static final String AUDIO = "audio";
	public static final String IMAGE = "image";
	public static final String ZIP = "zip";

	public static final String ROLE = "role";
	public static final String LOGIN_ADMIN = "admin";
	public static final String LOGIN_ROLE_KEY = "loginType";
	public static final String LOGIN_USER = "user";
	public static final String LOGIN_ROLE_USER = "user";
	public static final String LOGIN_ROLE_ADMIN = "admin";
	
	/**
	 * 订单类型
	 * 1 : 缴纳押金, 2 : �?��押金, 3 : 提取可用余额
	 */ 
	public static final int PAY_TYPE_DEPOSIT = 1;
	public static final int PAY_TYPE_REFUND = 2;
	public static final int PAY_TYPE_BALANCE = 3;
	
	/**
	 * 可用状�?
	 * 1 : 可用, 2 : 不可�?
	 */
	public static final int PAY_STATUS_ENABLE = 1;
	public static final int PAY_STATUS_DISABLE = 2;
	/**
	 * 常量用户
	 */
	public static final String SIGN_CUSTOMER = "customer";
}
