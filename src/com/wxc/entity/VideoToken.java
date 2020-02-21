package com.wxc.entity;

import java.util.Date;

public class VideoToken implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private int id;
	
	private String licencesId;
	
	private Date validDate;
	
	private int token;
	
	private int userId;
	
	private String userName;
	
	private String validDateBak;
	
	
	
	

	public String getValidDateBak() {
		return validDateBak;
	}

	public void setValidDateBak(String validDateBak) {
		this.validDateBak = validDateBak;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getLicencesId() {
		return licencesId;
	}

	public void setLicencesId(String licencesId) {
		this.licencesId = licencesId;
	}

	public Date getValidDate() {
		return validDate;
	}

	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}

	public int getToken() {
		return token;
	}

	public void setToken(int token) {
		this.token = token;
	}

	
}
