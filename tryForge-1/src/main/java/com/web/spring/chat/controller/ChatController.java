package com.web.spring.chat.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.web.spring.chat.service.ChatService;
import com.web.spring.member.service.MemberService;
import com.web.spring.vo.Chat;
import com.web.spring.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {
	@Autowired(required = false)
	private ChatService chatService;
	@Autowired(required = false)
	private MemberService memService;

	@GetMapping("chatHome")
	public String chatHome(HttpSession session, Model d) {
		if (session.getAttribute("loginMem") != null ) {
			Member member = (Member)session.getAttribute("loginMem");
			d.addAttribute("chatList", chatService.getChatList(member.getMember_key()));
			d.addAttribute("chatMap", chatService.chatHome(member.getMember_key()));
		}
		
		return "chat/chattingHome";
	}
	
	// 채팅방으로 이동
	@GetMapping("chat/{listKey}")
 	public String chat(
 				@PathVariable("listKey") int chatListKey,
 				Model d
 			) {
		System.out.println(chatListKey);
		
		List<Chat> chatList = chatService.getChat(chatListKey);
		d.addAttribute("chats", chatList);
		
		List<Member> memList = new ArrayList<>();
		for (Chat chat : chatList) {
			memList.add(memService.getMember(chat.getSender_key()));
		}
		d.addAttribute("memList", memList);
		
		return "chat/chat";
	}
	
	
	
}
