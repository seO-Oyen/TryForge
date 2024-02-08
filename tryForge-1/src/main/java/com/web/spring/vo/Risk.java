package com.web.spring.vo;

public class Risk {
	private int risk_key; // 리스크 키
	private String project_key; // 프로젝트 키
	private int task_key; // 업무 키
	private String registrant; // 리스크 등록자
	private String type; // 리스크 종류
	private String possibility; // 리스크 가능성 상,중,하
	private int priority; // 리스크 우선순위 1,2,3
	public Risk() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Risk(int risk_key, String project_key, int task_key, String registrant, String type, String possibility,
			int priority) {
		super();
		this.risk_key = risk_key;
		this.project_key = project_key;
		this.task_key = task_key;
		this.registrant = registrant;
		this.type = type;
		this.possibility = possibility;
		this.priority = priority;
	}

	public int getRisk_key() {
		return risk_key;
	}
	public void setRisk_key(int risk_key) {
		this.risk_key = risk_key;
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
	public String getRegistrant() {
		return registrant;
	}
	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getPossibility() {
		return possibility;
	}

	public void setPossibility(String possibility) {
		this.possibility = possibility;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}
	
}
