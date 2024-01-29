package com.web.spring.vo;

import java.util.Date;

// board.vo.Board
public class Board {
	private int no;
	private int refno;
	private String title;
	private String content;
	private String writer;
	private Date regdte;
	private Date uptdte;
	private int readcnt;
	public Board() {
		// TODO Auto-generated constructor stub
	}
	public Board(int no, int refno, String title, String content, String writer, Date regdte, Date uptdte,
			int readcnt) {
		this.no = no;
		this.refno = refno;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.regdte = regdte;
		this.uptdte = uptdte;
		this.readcnt = readcnt;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdte() {
		return regdte;
	}
	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}
	public Date getUptdte() {
		return uptdte;
	}
	public void setUptdte(Date uptdte) {
		this.uptdte = uptdte;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	
}