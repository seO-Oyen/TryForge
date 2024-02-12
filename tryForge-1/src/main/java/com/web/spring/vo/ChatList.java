package com.web.spring.vo;

import java.util.Date;

public class ChatList {
	private int chatlist_key;
	private String chat_category;
	private String last_message;
	private Date last_date;
	
	public ChatList() {
		super();
	}
	
	public ChatList(int chatlist_key, String chat_category, String last_message, Date last_date) {
		super();
		this.chatlist_key = chatlist_key;
		this.chat_category = chat_category;
		this.last_message = last_message;
		this.last_date = last_date;
	}
	
	public int getChatlist_key() {
		return chatlist_key;
	}
	public void setChatlist_key(int chatlist_key) {
		this.chatlist_key = chatlist_key;
	}
	public String getChat_category() {
		return chat_category;
	}
	public void setChat_category(String chat_category) {
		this.chat_category = chat_category;
	}
	public String getLast_message() {
		return last_message;
	}
	public void setLast_message(String last_message) {
		this.last_message = last_message;
	}
	public Date getLast_date() {
		return last_date;
	}
	public void setLast_date(Date last_date) {
		this.last_date = last_date;
	}

}
