package com.web.spring.memo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.memo.service.MemoService;
import com.web.spring.vo.Member;
import com.web.spring.vo.Memo;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemoController {
	@Autowired(required = false)
	private MemoService memoService;
	
	@GetMapping("memo")
	public String memo(
			HttpSession session,
			Model d
		) {
		if (session.getAttribute("loginMem") != null ) {
			Member member = (Member)session.getAttribute("loginMem");
			d.addAttribute("memoList", memoService.getMemoList(member.getMember_key()));
		}
		
		return "user/memo";
	}
	
	@PostMapping("createMemo")
	public String createChat(
				@RequestParam("member_key") int member_key,
				@RequestParam("memo_detail") String memo_detail,
				Model d
			) {
		
		d.addAttribute("result", memoService.createMemo(new Memo(member_key, memo_detail)));
		
		return "pageJsonReport";
	}
	

}
