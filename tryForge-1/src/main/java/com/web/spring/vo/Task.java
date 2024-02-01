package com.web.spring.vo;

public class Task {
	private int id; // 업무키
	private int member_key; // 업무할당자(member_key)
	private String project_key; // 프로젝트 키
	private String text; // 업무이름
	private String start_date; // 업무시작일
	private String end_date; // 업무종료일
	private int duration; // 진행기간
	private double progress; // 진행률
	private int parent; // 간트용
	private String type; // 프로젝트 or 업무
	private String status; // 진행상태 : 진행중 / 완료
	private boolean rollup; // 간트용
	private boolean hide_bar; // 간트용
	private boolean open; // 간트용
	private String detail; // 상세설명
	private String owner; // 업무 배정자
	private String assignor; // 업무할당자 이름
	private String confirm; // 확인여부
	public Task() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Task(int id, int member_key, String project_key, String text, String start_date, String end_date,
			int duration, double progress, int parent, String type, String status, boolean rollup, boolean hide_bar,
			boolean open, String detail, String owner) {
		super();
		this.id = id;
		this.member_key = member_key;
		this.project_key = project_key;
		this.text = text;
		this.start_date = start_date;
		this.end_date = end_date;
		this.duration = duration;
		this.progress = progress;
		this.parent = parent;
		this.type = type;
		this.status = status;
		this.rollup = rollup;
		this.hide_bar = hide_bar;
		this.open = open;
		this.detail = detail;
		this.owner = owner;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMember_key() {
		return member_key;
	}
	public void setMember_key(int member_key) {
		this.member_key = member_key;
	}
	public String getProject_key() {
		return project_key;
	}
	public void setProject_key(String project_key) {
		this.project_key = project_key;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
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
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public double getProgress() {
		return progress;
	}
	public void setProgress(double progress) {
		this.progress = progress;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public boolean isRollup() {
		return rollup;
	}
	public void setRollup(boolean rollup) {
		this.rollup = rollup;
	}
	public boolean isHide_bar() {
		return hide_bar;
	}
	public void setHide_bar(boolean hide_bar) {
		this.hide_bar = hide_bar;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getAssignor() {
		return assignor;
	}
	public void setAssignor(String assignor) {
		this.assignor = assignor;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	
	
}