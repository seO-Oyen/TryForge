package com.web.spring.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class RoleRequest {
	private int request_key;
	private int member_key;
	private String request_comment;
	private String admin_comment;
	private String request_state;
	private String request_date;

}
