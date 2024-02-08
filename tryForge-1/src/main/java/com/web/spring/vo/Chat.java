package com.web.spring.vo;

import java.util.Date;

public class Chat {
	private int chat_key;
	private int chatlist_key;
	private int sender_key;
	private String chat_detail;
	private String send_time;
	
	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Chat(int chatlist_key, int sender_key, String chat_detail, String send_time) {
		super();
		this.chatlist_key = chatlist_key;
		this.sender_key = sender_key;
		this.chat_detail = chat_detail;
		this.send_time = send_time;
	}

	public Chat(int chat_key, int chatlist_key, int sender_key, String chat_detail, String send_time) {
		super();
		this.chat_key = chat_key;
		this.chatlist_key = chatlist_key;
		this.sender_key = sender_key;
		this.chat_detail = chat_detail;
		this.send_time = send_time;
	}
	
	public int getChat_key() {
		return chat_key;
	}
	public void setChat_key(int chat_key) {
		this.chat_key = chat_key;
	}
	public int getChatlist_key() {
		return chatlist_key;
	}
	public void setChatlist_key(int chatlist_key) {
		this.chatlist_key = chatlist_key;
	}
	public int getSender_key() {
		return sender_key;
	}
	public void setSender_key(int sender_key) {
		this.sender_key = sender_key;
	}
	public String getChat_detail() {
		return chat_detail;
	}
	public void setChat_detail(String chat_detail) {
		this.chat_detail = chat_detail;
	}
	public String getSend_time() {
		return send_time;
	}
	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}
	

}
