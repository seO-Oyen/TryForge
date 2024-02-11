package com.web.spring.vo;

import java.util.Date;

public class Risk_Response {
	private int risk_response_key; //  리스크 대응 키
	private int risk_key; // 리스크 키
	private String response_method; // 대응방법
	private String contact; // 리스크 대응 담당자
	private Date completion_date; // 리스크 발생 시, 처리 완료일
	private String status; // 발생 시, 처리중 / 완료 / 실패

	public Risk_Response() {
	}

	public Risk_Response(int risk_response_key, int risk_key, String response_method, String contact) {
		this.risk_response_key = risk_response_key;
		this.risk_key = risk_key;
		this.response_method = response_method;
		this.contact = contact;
	}

	public int getRisk_response_key() {
		return risk_response_key;
	}

	public void setRisk_response_key(int risk_response_key) {
		this.risk_response_key = risk_response_key;
	}

	public int getRisk_key() {
		return risk_key;
	}

	public void setRisk_key(int risk_key) {
		this.risk_key = risk_key;
	}

	public String getResponse_method() {
		return response_method;
	}

	public void setResponse_method(String response_method) {
		this.response_method = response_method;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public Date getCompletion_date() {
		return completion_date;
	}

	public void setCompletion_date(Date completion_date) {
		this.completion_date = completion_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
