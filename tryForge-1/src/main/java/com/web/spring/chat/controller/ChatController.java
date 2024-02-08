package com.web.spring.chat.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
		// 디비에 아직 저장 안된 값
		List<String> chatDetailList = chatHandler.getMessageSaveList();
		List<Chat> chatList = chatService.getChat(chatListKey);
		
		chatHandler.setChatListNum(chatListKey);
		
		for (String chatDetail : chatDetailList) {
			String[] splitChat = chatDetail.split("/");
			if (splitChat[0].equals(Integer.toString(chatListKey))) {
				Member chatMem = memService.getMemberToId(splitChat[1]);
				
				chatList.add(new Chat(chatListKey, chatMem.getMember_key(), splitChat[3], splitChat[4]));
			}
		}
		
		List<Member> memList = new ArrayList<>();
		for (Chat chat : chatList) {
			memList.add(memService.getMember(chat.getSender_key()));
		}
		d.addAttribute("memList", memList);
		
		// 만약 챗값이 없을경우 -> 챗리스트 값을 구분해주기 위해
		if (chatList.isEmpty()) {
			Chat chatnot = new Chat();
			chatnot.setChatlist_key(chatListKey);
			chatList.add(chatnot);
		}
		
		d.addAttribute("chats", chatList);
		
		return "chat/chat";
	}
	
	@PostMapping("chatSave")
	public ResponseEntity<String> chatSave() {
		List<String> chatDetailList = chatHandler.getMessageSaveList();
		List<Chat> chatList = new ArrayList<>();
		
		for (String chat : chatDetailList) {
			System.out.println(chat);
			String[] splitChat = chat.split("/");
			Member chatMem = memService.getMemberToId(splitChat[1]);
			
			// 시간 변경
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime dateTime = LocalDateTime.parse(splitChat[4], formatter);
			
			chatList.add(new Chat(Integer.parseInt(splitChat[0]), chatMem.getMember_key(), splitChat[3], splitChat[4]));
		
		}
		String msg = chatService.insertChats(chatList);
		
		chatHandler.removeMessageSaveList();
		
		return ResponseEntity.ok(msg);
	}
	
}
