package com.web.spring.chat;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
// chatHandler
@Component
public class ChatHandler extends TextWebSocketHandler{
	// 접속한 채팅 소켙세션(접속자 저장)
//	private Map<String, WebSocketSession > users = 
//			new ConcurrentHashMap<>();
	private static final ConcurrentHashMap<String, WebSocketSession> CLIENTS = new ConcurrentHashMap<String, WebSocketSession>();
	
	// 접속시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		// session.getId() : 소켓서버에서 발급된 고유 id(0부터시작해서 16진수값으로 설정)
		System.out.println(session.getId()+"님 소켓 서버에 접속했습니다.");
		// 접속시 접속자 정보에 아이디와 소켓세션 저장..
		CLIENTS.put(session.getId(),session);
	}
	// 메시지보낼 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
		// 발송한 메시지
		System.out.println(session.getId()+"님이 보낸 메시지:"+
			message.getPayload());
		// 소켓 서버에 접속한 사람들
		for(WebSocketSession ws: CLIENTS.values()) {
			System.out.println(ws.getId()+"에게 메시지 발송");
			ws.sendMessage(message);
			
		}
	}
	// 접속종료 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
		System.out.println(session.getId()+"님 접속 종료!!");
		CLIENTS.remove(session.getId());
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
