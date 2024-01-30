package com.web.spring.member.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MypageController {
	
	@GetMapping("chkPwd")
	public ResponseEntity<Boolean> checkPwd(
				@RequestParam("memKey") String memKey,
				@RequestParam("pwd") String pwd
			) {
		
		
		return ResponseEntity.ok(true);
	}

}
