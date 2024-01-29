package com.web.spring.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Project {
	private String project_key;
	private String title;
	private String detail;
	private String status;
	private String start_date;
	private String end_date;
	public Project() {
		// TODO Auto-generated constructor stub
	}
	public Project(String project_key, String title, String detail, String status, String start_date, String end_date) {
		this.project_key = project_key;
		this.title = title;
		this.detail = detail;
		this.status = status;
		this.start_date = start_date;
		this.end_date = end_date;
	}
	public String getProject_key() {
		return project_key;
	}
	public void setProject_key(String project_key) {
		this.project_key = project_key;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	
}
