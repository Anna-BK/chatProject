package org.sist.web.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatWebSocketHandler extends TextWebSocketHandler {

	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	private String roomnumber;
	private String userId;
	
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setroomnumber(String roomnumber) {
		this.roomnumber = roomnumber;
	}
	private Map<String, ArrayList<String>> roomMembers = new HashMap<String, ArrayList<String>>();
	private Map<String, String>userSession = new HashMap<String, String>();
	
	public Map<String, WebSocketSession> getUsers() {		return users;	}
	public String getroomnumber() {		return roomnumber;	}
	public Map<String, ArrayList<String>> getRoomMembers() {		return roomMembers;	}
	public Map<String, String> getUserSession() {		return userSession;	}
	
	
	
	@Override
	public void afterConnectionEstablished(	WebSocketSession session) throws Exception {
		
		ArrayList<String> list = null;
		if(roomMembers.containsKey(roomnumber)) {
			list = roomMembers.get(roomnumber);
		}else {
			list = new ArrayList<String>();
		}
		list.add(session.getId());
		log(session.getId() + " 연결 됨");
		users.put(session.getId(), session);
		roomMembers.put(roomnumber,list);
		userSession.put(session.getId(),userId );
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log(session.getId() + " 연결 종료됨");
		roomMembers.get(roomnumber).remove(session.getId());
		if(roomMembers.get(roomnumber).isEmpty())	roomMembers.remove(roomnumber);
		users.remove(session.getId());
		userSession.remove(session.getId());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log(session.getId() + "로부터 메시지 수신: " + message.getPayload());
		int num = message.getPayload().indexOf(")");
		String room = message.getPayload().substring(4, num);
		ArrayList<String> listm = roomMembers.get(room);
		
		Iterator<String> ir = listm.iterator();

		while (ir.hasNext()) {
			String user =  ir.next();
			users.get(user).sendMessage(message);
			log(users.get(user).getId() + "에 메시지 발송: " + message.getPayload());
		}
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());
	}

	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}

}
