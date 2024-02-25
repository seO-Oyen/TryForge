package com.web.spring.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Memo {
	private int memo_key;
	private int member_key;
	private String memo_detail;
	private String create_time;
	private String update_time;

	public Memo(int member_key, String memo_detail) {
		this.member_key = member_key;
		this.memo_detail = memo_detail;
	}
}
