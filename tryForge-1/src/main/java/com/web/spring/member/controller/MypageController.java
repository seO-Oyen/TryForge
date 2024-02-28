package com.web.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.member.service.MemberService;
import com.web.spring.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {
	@Autowired(required = false) 
	private MemberService memService;
	
	//마이페이지 출력
	@GetMapping("myPage")
	public String myPage(HttpSession session, Model d) {
		if (session.getAttribute("loginMem") != null) {
			Member member = (Member)session.getAttribute("loginMem");
			session.setAttribute("profile", memService.getProfile(member.getMember_key()));
		}
		
	    return "user/myPage";
	}
	
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
				@RequestParam("memKey") int memKey,
				HttpSession session
			) {
		boolean result = memService.changeUserInfo(memName, memId, Integer.toString(memKey));
		if (result) {
			Member loginMember = memService.getMember(memKey);
			session.setAttribute("loginMem", loginMember);
		}
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("changePwd")
	public ResponseEntity<Boolean> changePwd(
				@RequestParam("memKey") String memKey,
				@RequestParam("pwd") String pwd
			) {
		boolean result = memService.changePwd(memKey, pwd);
		/*if (result) {
			Member loginMember = memService.getMember(memKey);
			session.setAttribute("loginMem", loginMember);
		}*/
		
		return ResponseEntity.ok(result);
	}

}
