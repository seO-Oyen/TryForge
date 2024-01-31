package com.web.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.member.service.MemberService;

@Controller
public class MypageController {
	@Autowired(required = false) 
	private MemberService memService;
	
	@GetMapping("chkPwd")
	public ResponseEntity<Boolean> checkPwd(
				@RequestParam("memKey") String memKey,
				@RequestParam("pwd") String pwd
			) {
		
		return ResponseEntity.ok(memService.chkPwd(memKey, pwd));
	}
	
	@GetMapping("userInfo")
	public String changeInfo() {
		
		return "user/userInfoChange";
	}
	
	@PostMapping("userInfo") 
	public boolean changeMemInfo() {
		
		return false;
	}

}
