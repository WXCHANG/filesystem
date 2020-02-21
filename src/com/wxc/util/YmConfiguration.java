package com.wxc.util;

import java.util.ResourceBundle;

public class YmConfiguration {
private static ResourceBundle configure = ResourceBundle.getBundle("configure");
	
	public static String server;
	public static String url;
	public static String userName;
	public static String password;
	public static String APIServer;
	public static String projectName;
	
	
	static {
		server = configure.getString("server");
		url = configure.getString("url");
		userName = configure.getString("userName");
		password = configure.getString("password");
		APIServer = configure.getString("APIServer");
		projectName = configure.getString("projectName");
	}
	public static void main(String[] args) {
		System.out.println(YmConfiguration.url);
	}
}
