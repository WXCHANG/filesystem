package com.wxc.entity;

public class Peer {
	private String peerIP;
	private String containerName;
	private int status;
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getPeerIP() {
		return peerIP;
	}
	public void setPeerIP(String peerIP) {
		this.peerIP = peerIP;
	}
	public String getContainerName() {
		return containerName;
	}
	public void setContainerName(String containerName) {
		this.containerName = containerName;
	}
	
}
