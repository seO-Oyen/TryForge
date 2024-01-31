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
	public ResponseEntity<Boolean> changeMemInfo(
				@RequestParam("name") String memName,
				@RequestParam("memberId") String memId,
				@RequestParam("memKey") String memKey
			) {
		System.out.println(memName);
		System.out.println(memId);
		System.out.println(memKey);
		
		return ResponseEntity.ok(true);
	}

}
