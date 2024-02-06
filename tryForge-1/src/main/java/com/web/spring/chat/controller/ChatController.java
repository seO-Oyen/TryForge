package com.web.spring.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.chat.service.ChatService;
import com.web.spring.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {
	@Autowired(required = false)
	private ChatService chatService;

	@GetMapping("chatHome")
	public String chatHome(HttpSession session, Model d) {
		if (session.getAttribute("loginMem") != null ) {
			Member member = (Member)session.getAttribute("loginMem");
			d.addAttribute("chatList", chatService.getChatList(member.getMember_key()));
		}
		
		return "chat/chattingHome";
	}
	
}
