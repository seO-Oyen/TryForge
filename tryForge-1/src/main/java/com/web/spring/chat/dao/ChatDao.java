package com.web.spring.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.Chat;
import com.web.spring.vo.ChatList;
import com.web.spring.vo.Member;

@Mapper
public interface ChatDao {
	// 채팅 리스트 가져오기
	List<ChatList> getChatList(@Param("memKey") int memberKey);
	
	// 프로젝트키로 채팅방번호 가져오기
	Integer getChatListNum(String pjKey);
	
	List<Integer> getChatMemList(@Param("memKey") int memberKey, @Param("listKey") int listKey);

	List<Chat> getChat(@Param("listKey") int listKey);
	
	int insertChat(Chat chat);
	
	int updateLastMessage(Chat chat);
	
	// 프로젝트 생성시 채팅방 만드는것
	int createChatRoom();
	
	// 프로젝트 예약 후 생성시 채팅방 만들기
	int createChatRoomConvert(String projectKey);
	
	int createChatMem(int member_key);
	
	// 그냥 채팅방 생성
	int createChatRoomUser();
	
	List<Member> schMem(@Param("member_name")String member_name, @Param("member_key")int member_key);
}
