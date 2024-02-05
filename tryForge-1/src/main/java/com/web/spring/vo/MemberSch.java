package com.web.spring.vo;
// m.member_name, m.member_email, tm.ROLE, p.title, p.start_date, p.end_date
// tryForge.vo.MemberSch
public class MemberSch {
	private String project_key;
	private String member_key;
	private String member_name;
	private String member_email;
	private String role;
	private String title;
	private String start_date;
	private String end_date;
	private int task_key;

	public MemberSch() {
		// TODO Auto-generated constructor stub
	}
	public MemberSch(String member_name, String member_email, String role, String title, String start_date,
			String end_date) {
		this.member_name = member_name;
		this.member_email = member_email;
		this.role = role;
		this.title = title;
		this.start_date = start_date;
		this.end_date = end_date;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getMember_key() {
		return member_key;
	}
	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}
	public String getProject_key() {
		return project_key;
	}
	public void setProject_key(String project_key) {
		this.project_key = project_key;
	}

	public int getTask_key() {
		return task_key;
	}

	public void setTask_key(int task_key) {
		this.task_key = task_key;
	}


}
