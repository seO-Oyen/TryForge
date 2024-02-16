package com.web.spring.vo;

import java.util.Date;

public class Risk {
	//RESPONSE_METHOD|STRATEGY
	private int risk_key; // 리스크 키
	private String project_key; // 프로젝트 키
	private int task_key; // 업무 키
	private String registrant; // 리스크 등록자
	private String type; // 리스크 종류
	private String possibility; // 리스크 가능성 상,중,하
	private int priority; // 리스크 우선순위 1,2,3
	private int confirm; // 관리자용 리스크 확인여부
	private String detail; // 리스크 상세설명
	private String text; // 업무 이름
	private String title; // 프로젝트 이름
	private Date reg_date; //  업무 등록일
	private String status; // 상태(발생전, 발생, 처리중, 완료)
	private String contact; // 리스크 담당자
	private int risk_response_key; // 리스크 대응 키
	private String response_method; // 대응방법상세
	private String strategy; // 대응전략
	public Risk() {
		super();
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

	public int getConfirm() {
		return confirm;
	}

	public void setConfirm(int confirm) {
		this.confirm = confirm;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public int getRisk_response_key() {
		return risk_response_key;
	}

	public void setRisk_response_key(int risk_response_key) {
		this.risk_response_key = risk_response_key;
	}

	public String getResponse_method() {
		return response_method;
	}

	public void setResponse_method(String response_method) {
		this.response_method = response_method;
	}

	public String getStrategy() {
		return strategy;
	}

	public void setStrategy(String strategy) {
		this.strategy = strategy;
	}
	
	
}
