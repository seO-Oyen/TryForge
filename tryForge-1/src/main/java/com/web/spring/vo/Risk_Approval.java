package com.web.spring.vo;

import java.util.Date;

public class Risk_Approval {
	private int risk_approval_key;
	private String reporter;
	private String report_detail;
	private Date report_date;
	private int risk_key;
	private int risk_response_key;
	private String file_key;
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
	
}
