package org.sist.web.controllers;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.sist.web.service.ChatRoomService;
import org.sist.web.vo.ChatRoomVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/c")
public class ChatController {
	
	@Inject
	private ChatWebSocketHandler chatHandler;
	
	@Inject
	private ChatRoomService service;
	
	@RequestMapping("/main")
	public ModelAndView main() throws Exception {
		
		String theme = null;
		List<Object>list = service.getRoomList(theme);
		ModelAndView mv = new ModelAndView("main");
		mv.addObject("list",list);
		
		return mv;
	}

	@RequestMapping("/chat")
	public ModelAndView enterChatRoom(Principal principal, String roomnumber, HttpServletRequest request) {
		
		chatHandler.setUserId(principal.getName());
		chatHandler.setroomnumber(roomnumber);
		ModelAndView mv = new ModelAndView("chat/chat-sockjs");
		
		return mv;
	}
	
	@RequestMapping("/create")
	public String createRoom(ChatRoomVO vo) throws Exception {
		
		String no = service.createRoom(vo);
		
		return "redirect:/c/chat?roomnumber=room"+no;
	}
	
	
	
	
}
