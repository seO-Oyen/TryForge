package com.web.spring.vo;

public class InviteMember {
	private int invite_key;
	private int invited_member;
	private String invitee_email;
	private boolean joined;
	
	public InviteMember() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public InviteMember(int invite_key, int invited_member, String invitee_email, boolean joined) {
		super();
		this.invite_key = invite_key;
		this.invited_member = invited_member;
		this.invitee_email = invitee_email;
		this.joined = joined;
	}
	
	public int getInvite_key() {
		return invite_key;
	}
	public void setInvite_key(int invite_key) {
		this.invite_key = invite_key;
	}
	public int getInvited_member() {
		return invited_member;
	}
	public void setInvited_member(int invited_member) {
		this.invited_member = invited_member;
	}
	public String getInvitee_email() {
		return invitee_email;
	}
	public void setInvitee_email(String invitee_email) {
		this.invitee_email = invitee_email;
	}
	public boolean isJoined() {
		return joined;
	}
	public void setJoined(boolean joined) {
		this.joined = joined;
	}
	

}
