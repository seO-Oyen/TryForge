package com.web.spring.chat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.web.spring.vo.Member;

@Component
public class ChatHandler extends TextWebSocketHandler{
	// 접속한 채팅 소켓세션(접속자 저장)
	private static final ConcurrentHashMap<String, WebSocketSession> CLIENTS = new ConcurrentHashMap<String, WebSocketSession>();
	private List<String> messageSave = new ArrayList<>();
	
	// 채팅방 (보내는 메시지)나누기 위해 (테스트)
	private int chatListNum = 0;
	
	// 저장할때 쓸 messageList출력
	public List<String> getMessageSaveList() {
		return messageSave;
	}
	public void removeMessageSaveList() {
		messageSave.clear();
	}
	
	public int getChatListNum() {
		return chatListNum;
	}
	public void setChatListNum(int chatListNum) {
		this.chatListNum = chatListNum;
	}
	
	// 접속시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		
		// member 명으로 띄우게
		Map map = (Map)session.getAttributes();
		Member member = (Member)map.get("loginMem");
		
		// 접속시 접속자 정보에 아이디와 소켓세션 저장
		System.out.println(member.getMember_id()+"님 소켓 서버에 접속했습니다.");
		
		// 세션에 채팅방 리스트도 저장
		CLIENTS.put(chatListNum + "/" + member.getMember_id(), session);
		
		// 테스트
		System.out.println("현재 접속자");
		for(String key : CLIENTS.keySet()){
        	System.out.println(key);
        }
	}
	
	// 메시지보낼 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		super.handleTextMessage(session, message);
		
		// 날짜 설정
		LocalDateTime now = LocalDateTime.now();
		
		String parsedLocalDateTimeNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		// 주고 받은 메세지 저장
		messageSave.add(message.getPayload() + "/" + parsedLocalDateTimeNow);
		
		// 같은 방에 있는 멤버에게만 채팅 보여줌
		for(String key : CLIENTS.keySet()){
        	String[] keySplit = key.split("/");
        	String[] messageSplit = message.getPayload().split("/");
        	
        	if (keySplit[0].equals(messageSplit[0])) {
        		WebSocketSession ws = CLIENTS.get(key);
        		
        		Map map = (Map)ws.getAttributes();
    			Member member = (Member)map.get("loginMem");
    			
        		System.out.println(member.getMember_id()+"에게 메시지 발송");
        		ws.sendMessage(message);
        	}
        }
			
	}
	// 접속종료 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
		Map map = (Map)session.getAttributes();
		Member member = (Member)map.get("loginMem");
		
		for(String key : CLIENTS.keySet()){
			String[] keySplit = key.split("/");
			if (keySplit[1].equals(member.getMember_id())) {
				CLIENTS.remove(key);
				System.out.println(member.getMember_name() + "님 접속 종료!!");
			}
		}
		
		System.out.println("남은 접속자");
		for(String key : CLIENTS.keySet()){
        	System.out.println(key);
        }
		
	}
	
	// 에러발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// TODO Auto-generated method stub
		super.handleTransportError(session, exception);
		/*
		 * System.out.println(session.getId()+"님 에러 발생! "+ exception.getMessage());
		 */
	}
	

}
