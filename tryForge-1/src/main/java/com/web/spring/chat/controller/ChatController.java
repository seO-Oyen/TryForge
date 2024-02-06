package com.web.spring.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

	@GetMapping("chatHome")
	public String chatHome(HttpSession session) {
		
		return "chat/chattingHome";
	}
	
}
