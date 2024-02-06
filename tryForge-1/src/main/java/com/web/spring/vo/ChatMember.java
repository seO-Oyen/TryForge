package com.web.spring.vo;

public class ChatMember {
	private int chatmember_key;
	private int chatList_key;
	private int member_key;
	
	// 테스트
	private ChatList chatList;
	private Member member;
	
	public ChatMember() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ChatMember(int chatmember_key, int chatList_key, int member_key) {
		super();
		this.chatmember_key = chatmember_key;
		this.chatList_key = chatList_key;
		this.member_key = member_key;
	}
	
	public int getChatmember_key() {
		return chatmember_key;
	}
	public void setChatmember_key(int chatmember_key) {
		this.chatmember_key = chatmember_key;
	}
	public int getChatList_key() {
		return chatList_key;
	}
	public void setChatList_key(int chatList_key) {
		this.chatList_key = chatList_key;
	}
	public int getMember_key() {
		return member_key;
	}
	public void setMember_key(int member_key) {
		this.member_key = member_key;
	}
	
	// 될지도 안될지도 모르는 테스트
	public ChatList getChatList() {
		return chatList;
	}
	public void setChatList(ChatList chatList) {
		this.chatList = chatList;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	
}
