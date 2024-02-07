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
// chatHandler
@Component
public class ChatHandler extends TextWebSocketHandler{
	// 접속한 채팅 소켙세션(접속자 저장)
//	private Map<String, WebSocketSession > CLIENTS = 
//			new ConcurrentHashMap<>();
	private static final ConcurrentHashMap<String, WebSocketSession> CLIENTS = new ConcurrentHashMap<String, WebSocketSession>();
	private List<String> messageSave = new ArrayList<>(); 
	
	// 저장할때 쓸 messageList출력
	public List<String> getMessageSaveList() {
		return messageSave;
	}
	public void removeMessageSaveList() {
		messageSave.clear();
	}
	
	// 접속시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		
		// session.getId() : 소켓서버에서 발급된 고유 id(0부터시작해서 16진수값으로 설정)
		// System.out.println(session.getId()+"님 소켓 서버에 접속했습니다.");
		// member 명으로 띄우게
		Map map = (Map)session.getAttributes();
		Member member = (Member)map.get("loginMem");
		
		// 접속시 접속자 정보에 아이디와 소켓세션 저장
		System.out.println(member.getMember_id()+"님 소켓 서버에 접속했습니다.");
		
		CLIENTS.put(member.getMember_id(), session);
		
		// 테스트
		System.out.println("현재 접속자");
		for(WebSocketSession ws: CLIENTS.values()) {
			Map map2 = (Map)ws.getAttributes();
			Member mem = (Member)map2.get("loginMem");
			
			System.out.println(mem.getMember_name());
		}
	}
	
	// 메시지보낼 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
		// 발송한 메시지
		// System.out.println(session.getId()+"님이 보낸 메시지:" + message.getPayload());
		LocalDateTime now = LocalDateTime.now();
		
		String parsedLocalDateTimeNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		// 주고 받은 메세지 저장
		messageSave.add(message.getPayload() + "/" + parsedLocalDateTimeNow);
		
		for(WebSocketSession ws: CLIENTS.values()) {
			Map map = (Map)ws.getAttributes();
			Member member = (Member)map.get("loginMem");
			if (member != null) {
				System.out.println(member.getMember_id()+"에게 메시지 발송");
				ws.sendMessage(message);
			} else {
				System.out.println(ws.getId()+"에게 메시지 발송");
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
		System.out.println(member.getMember_name() + "님 접속 종료!!");
		CLIENTS.remove(member.getMember_id());
	}
	
	// 에러발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// TODO Auto-generated method stub
		super.handleTransportError(session, exception);
		System.out.println(session.getId()+"님 에러 발생! "+
				exception.getMessage());
	}
	

}
