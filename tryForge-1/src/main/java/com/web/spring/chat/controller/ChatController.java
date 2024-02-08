package com.web.spring.chat.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.web.spring.chat.ChatHandler;
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
	
	// 채팅핸들러에서 값 빼올거임
	@Autowired(required = false)
	private ChatHandler chatHandler;

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
		// 디비에 아직 저장 안된 값
		List<String> chatDetailList = chatHandler.getMessageSaveList();
		List<Chat> chatList = chatService.getChat(chatListKey);
		
		for (String chatDetail : chatDetailList) {
			String[] splitChat = chatDetail.split("/");
			Member chatMem = memService.getMemberToId(splitChat[0]);
			
			// 시간 변경
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime dateTime = LocalDateTime.parse(splitChat[3], formatter);
			
			chatList.add(new Chat(chatListKey, chatMem.getMember_key(), splitChat[2], Timestamp.valueOf(dateTime)));
		}
		
		d.addAttribute("chats", chatList);
		
		List<Member> memList = new ArrayList<>();
		for (Chat chat : chatList) {
			memList.add(memService.getMember(chat.getSender_key()));
		}
		d.addAttribute("memList", memList);
		
		return "chat/chat";
	}
	
	@PostMapping("chatSave")
	public ResponseEntity<String> chatSave() {
		List<String> chatDetailList = chatHandler.getMessageSaveList();
		
		for (String chat : chatDetailList) {
			System.out.println(chat);
		}
		chatHandler.removeMessageSaveList();
		
		return ResponseEntity.ok("성공일껄?");
	}
	
}
