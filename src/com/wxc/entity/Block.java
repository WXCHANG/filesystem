package com.wxc.entity;

import java.util.List;

public class Block {
	
	public Block() {
		super();
	}
	private String number;
	private String currentHash;
	private String previousHash;
	private String dataHash;
	private List<Transaction> transactions;
	private String peer;
	
	public List<Transaction> getTransactions() {
		return transactions;
	}
	public void setTransactions(List<Transaction> transactions) {
		this.transactions = transactions;
	}
	public String getDataHash() {
		return dataHash;
	}
	public void setDataHash(String dataHash) {
		this.dataHash = dataHash;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getCurrentHash() {
		return currentHash;
	}
	public void setCurrentHash(String currentHash) {
		this.currentHash = currentHash;
	}
	public String getPreviousHash() {
		return previousHash;
	}
	public void setPreviousHash(String previousHash) {
		this.previousHash = previousHash;
	}
	public String getPeer() {
		return peer;
	}
	public void setPeer(String peer) {
		this.peer = peer;
	}
	
}
