package com.web.spring.chat.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.chat.dao.ChatDao;
import com.web.spring.member.dao.MemberDao;
import com.web.spring.vo.Chat;
import com.web.spring.vo.ChatList;
import com.web.spring.vo.Member;

@Service
public class ChatService {
	@Autowired(required = false)
	private ChatDao dao;
	
	@Autowired(required = false)
	private MemberDao memDao;
	
	// 채팅 초기 화면
	public HashMap<List<String>, String> chatHome(int memKey) {
		List<ChatList> chatList = new ArrayList<>();
		
		chatList = dao.getChatList(memKey);
		
		HashMap<List<String>, String> chatMemMap = new LinkedHashMap();
		
		
		for (ChatList chat : chatList) {
			List<String> memberNameList = new ArrayList<>();
			for (int memberKey : dao.getChatMemList(memKey, chat.getChatlist_key())){
				 // memDao.getMeber(memberKey));
				memberNameList.add(memDao.getMeber(memberKey).getMember_name());
			}
			chatMemMap.put(memberNameList, chat.getLast_message());
		}
		
		return chatMemMap;
	}
	
	public List<ChatList> getChatList(int memKey) {
		List<ChatList> chatList = dao.getChatList(memKey);
		
		return chatList;
	}
	
	public List<Chat> getChat(int listKey) {
		List<Chat> chatList = dao.getChat(listKey);
		
		return chatList;
	}
	
	public String insertChats(List<Chat> chatList) {
		int num = 0;
		for (Chat chat : chatList) {
			num += dao.insertChat(chat);
		}
		
		return num + "건 db저장 완료";
	}

}
