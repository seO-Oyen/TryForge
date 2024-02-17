package com.web.spring.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.admin.dao.AcceptRoleDao;
import com.web.spring.vo.RoleRequest;

@Service
public class AcceptRoleService {
	@Autowired(required = false)
	private AcceptRoleDao dao;

	// 관리자 요청 리스트 띄우기
	public List<RoleRequest> getRoleRequestList() {
		return dao.getRoleRequestList();
	}
	
	public boolean requestAccept(RoleRequest request) {
		
		if (dao.updateRequest("approval", "", request.getRequest_key()) > 0) {
			// 권한이 변경되었을 경우
			dao.updateRole(request.getMember_key());
			
			return true;
		} else {
			return false;
		}
	}
	
	public boolean requestCancel(RoleRequest request) {
		if (dao.updateRequest("cancel", request.getAdmin_comment(), request.getRequest_key()) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
}
