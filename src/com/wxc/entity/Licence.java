package com.wxc.entity;

import java.util.Date;

public class Licence implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String version;
	private String licenceid;
	private Date userfuldate;
	private String mkey;
	private Integer num;
	private String target;
	private Integer fileid;
	private String type;
	private int total;
	
   
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getLicenceid() {
		return licenceid;
	}
	public void setLicenceid(String licenceid) {
		this.licenceid = licenceid;
	}
	public Date getUserfuldate() {
		return userfuldate;
	}
	public void setUserfuldate(Date userfuldate) {
		this.userfuldate = userfuldate;
	}
	public String getMkey() {
		return mkey;
	}
	public void setMkey(String mkey) {
		this.mkey = mkey;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public Integer getFileid() {
		return fileid;
	}
	public void setFileid(Integer fileid) {
		this.fileid = fileid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	

}
