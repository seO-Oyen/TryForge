package com.web.spring.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class FileStorage {
	private String file_key;
	private String fname;
	private String path;
	private String ftype;
	private String fsize;
	private Date upload_time;
	private String iconPath;
	private MultipartFile[] files;
	private int member_key;
	private String project_key;

	public String getFile_key() {
		return file_key;
	}

	public void setFile_key(String file_key) {
		this.file_key = file_key;
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

	public FileStorage() {
		// TODO Auto-generated constructor stub
	}

	public FileStorage(String file_key, String fname, String path, String ftype, String fsize, Date upload_time, String iconPath, MultipartFile[] files, int member_key, String project_key) {
		this.file_key = file_key;
		this.fname = fname;
		this.path = path;
		this.ftype = ftype;
		this.fsize = fsize;
		this.upload_time = upload_time;
		this.iconPath = iconPath;
		this.files = files;
		this.member_key = member_key;
		this.project_key = project_key;
	}

	public FileStorage(String file_key, String fname, String path, String ftype, String fsize, String project_key, int member_key) {
		this.file_key = file_key;
		this.fname = fname;
		this.path = path;
		this.ftype = ftype;
		this.fsize = fsize;
		this.member_key = member_key;
		this.project_key = project_key;
	}

	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getFtype() {
		return ftype;
	}

	public void setFtype(String ftype) {
		this.ftype = ftype;
	}

	public String getFsize() {
		return fsize;
	}

	public void setFsize(String fsize) {
		this.fsize = fsize;
	}

	public Date getUpload_time() {
		return upload_time;
	}

	public void setUpload_time(Date upload_time) {
		this.upload_time = upload_time;
	}

	public MultipartFile[] getFiles() {
		return files;
	}

	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}

}
