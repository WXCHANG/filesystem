package com.wxc.entity;

public class Transaction {
	private String tx_id;
	private String proposal_hash;
	private String payload;
	private String timestamp;
	public String getTx_id() {
		return tx_id;
	}
	public void setTx_id(String tx_id) {
		this.tx_id = tx_id;
	}
	public String getProposal_hash() {
		return proposal_hash;
	}
	public void setProposal_hash(String proposal_hash) {
		this.proposal_hash = proposal_hash;
	}
	public String getPayload() {
		return payload;
	}
	public void setPayload(String payload) {
		this.payload = payload;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
}
