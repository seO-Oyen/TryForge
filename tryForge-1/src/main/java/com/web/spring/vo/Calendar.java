package com.web.spring.vo;

public class Calendar {
	private int calendar_key;
	private String project_key;
	private String title;
	private String start;
	private String end;
	private String writer;
	private String detail;
	private String backgroundColor;
	private String textColor;
	private boolean allDay;
	private String urlLink;
	public Calendar() {
		// TODO Auto-generated constructor stub
	}
	public Calendar(int calendar_key, String project_key, String title, String start, String end, String writer,
			String detail, String backgroundColor, String textColor, boolean allDay, String urlLink) {
		this.calendar_key = calendar_key;
		this.project_key = project_key;
		this.title = title;
		this.start = start;
		this.end = end;
		this.writer = writer;
		this.detail = detail;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.urlLink = urlLink;
	}
	public int getCalendar_key() {
		return calendar_key;
	}
	public void setCalendar_key(int calendar_key) {
		this.calendar_key = calendar_key;
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
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
	public String getTextColor() {
		return textColor;
	}
	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}
	public boolean isAllDay() {
		return allDay;
	}
	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}
	public String getUrlLink() {
		return urlLink;
	}
	public void setUrlLink(String urlLink) {
		this.urlLink = urlLink;
	}
}
