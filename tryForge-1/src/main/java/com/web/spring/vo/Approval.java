package com.web.spring.vo;
// com.web.spring.vo.Approval
import java.util.Date;

public class Approval {
	private int approval_key; // 결제 primary Key
	private int task_key; // 업무 키
	private String project_key; // 프로젝트 키
	private int member_key; // 요청보낸 맴버 키
	private Date request_date; // 요청일
	private Date completion_date; //  결재 완료일
	private String status; //  결재 상태
	private String text; // 결재 명
	private String detail; // 결재 상세
	private String task_detail;// 업무상세
	private Date start_date; // 업무 시작일
	private Date end_date; // 업무종료일
	private String member_name; // 보고자
	private String assignor; // 업무할당자
	private String reject_detail; // 재상신요청이유
	private Task task;
	private FileStorage file;
	private FileUse fileUse;

	public Approval() {
		// TODO Auto-generated constructor stub
	}

	public Approval(int approval_key, int task_key, String project_key, int member_key, Date request_date, Date completion_date, String status, String text, String detail, String task_detail, Date start_date, Date end_date, String member_name, String assignor, String reject_detail, Task task, FileStorage file, FileUse fileUse) {
		this.approval_key = approval_key;
		this.task_key = task_key;
		this.project_key = project_key;
		this.member_key = member_key;
		this.request_date = request_date;
		this.completion_date = completion_date;
		this.status = status;
		this.text = text;
		this.detail = detail;
		this.task_detail = task_detail;
		this.start_date = start_date;
		this.end_date = end_date;
		this.member_name = member_name;
		this.assignor = assignor;
		this.reject_detail = reject_detail;
		this.task = task;
		this.file = file;
		this.fileUse = fileUse;
	}

	public FileStorage getFile() {
		return file;
	}

	public void setFile(FileStorage file) {
		this.file = file;
	}

	public Task getTask() {
		return task;
	}
	public void setTask(Task task) {
		this.task = task;
	}


	public FileUse getFileUse() {
		return fileUse;
	}

	public void setFileUse(FileUse fileUse) {
		this.fileUse = fileUse;
	}

	public int getApproval_key() {
		return approval_key;
	}
	public void setApproval_key(int approval_key) {
		this.approval_key = approval_key;
	}
	public int getTask_key() {
		return task_key;
	}
	public void setTask_key(int task_key) {
		this.task_key = task_key;
	}
	public String getProject_key() {
		return project_key;
	}
	public void setProject_key(String project_key) {
		this.project_key = project_key;
	}
	public int getMember_key() {
		return member_key;
	}
	public void setMember_key(int member_key) {
		this.member_key = member_key;
	}
	public Date getRequest_date() {
		return request_date;
	}
	public void setRequest_date(Date request_date) {
		this.request_date = request_date;
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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getTask_detail() {
		return task_detail;
	}

	public void setTask_detail(String task_detail) {
		this.task_detail = task_detail;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getAssignor() {
		return assignor;
	}

	public void setAssignor(String assignor) {
		this.assignor = assignor;
	}

	public String getReject_detail() {
		return reject_detail;
	}

	public void setReject_detail(String reject_detail) {
		this.reject_detail = reject_detail;
	}
}