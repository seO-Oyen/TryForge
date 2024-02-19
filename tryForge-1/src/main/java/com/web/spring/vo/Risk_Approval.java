package com.web.spring.vo;

import java.util.Date;

public class Risk_Approval {
	// ra.*, t.text, r.TYPE, rr.contact, rr.STRATEGY, rr.RESPONSE_METHOD
	private int risk_approval_key; // primary key
	private String reporter; // 결재보고자
	private String report_detail; // 상세내용
	private Date report_date; // 결재보고일
	private int risk_key; // 리스크키
	private int risk_response_key; // 리스크대응키
	private String file_key; // 첨부파일 파일키
	private String fname; // 파일이름
	private String report_status; // 결재상태(결재요청, 결재완료, 재상신요청)
	private String title; // 보고명
	private String text; // 업무명
	private String registrant; // 리스크등록자
	private Date reg_date; // 리스크 등록일
	private String possibility; // 리스크 가능성(상중하)
	private int priority; // 리스크 우선순위
	private String contact; // 
	private String status; // 대응상태 리스크 상태(발생전,처리중,처리완료)
	private String type; // 리스크 타입
	private int r_risk_key; // 리스크테이블 리스크키
	private int rr_risk_response_key; // 리스크대응 테이블 리스크 키
	private String strategy; // 대응전략
	private String response_method; // 대응 상세
	
	
	public Risk_Approval() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Risk_Approval(int risk_approval_key, String reporter, String report_detail, Date report_date, int risk_key,
			int risk_response_key, String file_key) {
		super();
		this.risk_approval_key = risk_approval_key;
		this.reporter = reporter;
		this.report_detail = report_detail;
		this.report_date = report_date;
		this.risk_key = risk_key;
		this.risk_response_key = risk_response_key;
		this.file_key = file_key;
	}
	public int getRisk_approval_key() {
		return risk_approval_key;
	}
	public void setRisk_approval_key(int risk_approval_key) {
		this.risk_approval_key = risk_approval_key;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getReport_detail() {
		return report_detail;
	}
	public void setReport_detail(String report_detail) {
		this.report_detail = report_detail;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public int getRisk_key() {
		return risk_key;
	}
	public void setRisk_key(int risk_key) {
		this.risk_key = risk_key;
	}
	public int getRisk_response_key() {
		return risk_response_key;
	}
	public void setRisk_response_key(int risk_response_key) {
		this.risk_response_key = risk_response_key;
	}
	public String getFile_key() {
		return file_key;
	}
	public void setFile_key(String file_key) {
		this.file_key = file_key;
	}

	public String getReport_status() {
		return report_status;
	}

	public void setReport_status(String report_status) {
		this.report_status = report_status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getRegistrant() {
		return registrant;
	}

	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public int getR_risk_key() {
		return r_risk_key;
	}

	public void setR_risk_key(int r_risk_key) {
		this.r_risk_key = r_risk_key;
	}

	public int getRr_risk_response_key() {
		return rr_risk_response_key;
	}

	public void setRr_risk_response_key(int rr_risk_response_key) {
		this.rr_risk_response_key = rr_risk_response_key;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getStrategy() {
		return strategy;
	}
	public void setStrategy(String strategy) {
		this.strategy = strategy;
	}
	public String getResponse_method() {
		return response_method;
	}
	public void setResponse_method(String response_method) {
		this.response_method = response_method;
	}
	
}
