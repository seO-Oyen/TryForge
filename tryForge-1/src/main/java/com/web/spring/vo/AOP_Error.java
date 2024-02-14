package com.web.spring.vo;

public class AOP_Error {
	private int error_key;
	private String incident_date;
	private String error_type;
	private String error_detail;
	private String error_path;
	private String error_level;
	private String error_confirm;
	public AOP_Error() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AOP_Error(String incident_date, String error_type, String error_detail, String error_path,
			String error_level, String error_confirm) {
		super();
		this.incident_date = incident_date;
		this.error_type = error_type;
		this.error_detail = error_detail;
		this.error_path = error_path;
		this.error_level = error_level;
		this.error_confirm = error_confirm;
	}

	public AOP_Error(String error_type, String error_detail, String error_path) {
		this.error_type = error_type;
		this.error_detail = error_detail;
		this.error_path = error_path;
	}

	public String getIncident_date() {
		return incident_date;
	}
	public void setIncident_date(String incident_date) {
		this.incident_date = incident_date;
	}
	public String getError_type() {
		return error_type;
	}
	public void setError_type(String error_type) {
		this.error_type = error_type;
	}
	public String getError_detail() {
		return error_detail;
	}
	public void setError_detail(String error_detail) {
		this.error_detail = error_detail;
	}
	public String getError_path() {
		return error_path;
	}
	public void setError_path(String error_path) {
		this.error_path = error_path;
	}
	public String getError_level() {
		return error_level;
	}
	public void setError_level(String error_level) {
		this.error_level = error_level;
	}
	public String getError_confirm() {
		return error_confirm;
	}
	public void setError_confirm(String error_confirm) {
		this.error_confirm = error_confirm;
	}

	public int getError_key() {
		return error_key;
	}

	public void setError_key(int error_key) {
		this.error_key = error_key;
	}
}
