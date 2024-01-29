package com.web.spring.vo;

public class Member {
	private int member_key;
	private String member_name;
	private String member_id;
	private String member_pwd;
	private String member_email;
	private String member_role;
	
	public Member() {
		
	}
	
	public Member(int member_key, String member_name, String member_id, String member_pwd, String member_email,
			String member_role) {
		this.member_key = member_key;
		this.member_name = member_name;
		this.member_id = member_id;
		this.member_pwd = member_pwd;
		this.member_email = member_email;
		this.member_role = member_role;
	}
	
	public Member(int member_key, String member_email) {
		this.member_key = member_key;
		this.member_email = member_email;
	}
	
	public int getMember_key() {
		return member_key;
	}
	public void setMember_key(int member_key) {
		this.member_key = member_key;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_role() {
		return member_role;
	}
	public void setMember_role(String member_role) {
		this.member_role = member_role;
	}

}