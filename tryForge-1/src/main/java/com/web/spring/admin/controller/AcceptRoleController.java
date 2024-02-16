package com.web.spring.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.admin.service.AcceptRoleService;
import com.web.spring.member.service.MemberService;
import com.web.spring.vo.Member;
import com.web.spring.vo.RoleRequest;

@Controller
public class AcceptRoleController {
	@Autowired(required = false)
	private AcceptRoleService service;
	@Autowired(required = false)
	private MemberService memService;
	
	@GetMapping("acceptRole")
	public String requestRole(Model d) {
		List<RoleRequest> requestList = service.getRoleRequestList();
		d.addAttribute("requestList", requestList);
		List<Member> memList = new ArrayList<>();
		for (RoleRequest request : requestList) {
			memList.add(memService.getMember(request.getMember_key()));
			
		}
		
		d.addAttribute("requestMem", memList);
		 
		return "user/acceptRole";
	}
	
	@PostMapping("roleAccept")
	public String requestAccept(
				@RequestParam("requestNum") int requestKey,
				Model d
			) {
		RoleRequest request = memService.getRequestRole(requestKey);
		
		d.addAttribute("result", service.requestAccept(request));
		
		return "pageJsonReport";
	}
}
