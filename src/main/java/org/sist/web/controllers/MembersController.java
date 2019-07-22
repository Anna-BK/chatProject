package org.sist.web.controllers;

import java.security.Principal;

import javax.inject.Inject;

import org.sist.web.service.MembersService;
import org.sist.web.vo.MembersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/members/*")
public class MembersController {
	
	@Inject
	private MembersService service;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	//회원가입
	@RequestMapping(value= {"join.do"}, method=RequestMethod.GET)
	public String join() {
		return "joinus/join";
	}	
	
	@RequestMapping(value= {"join.do"}, method=RequestMethod.POST)
	public String join(MembersVO member) throws Exception {
		
		String inputPass= member.getPswd();
		String pass=passwordEncoder.encode(inputPass);
		member.setPswd(pass);
		
		this.service.regist(member);
		
		return "joinus/login";
	}
	
	//로그인
	@RequestMapping( value={ "login.do"}, method=RequestMethod.GET )
    public String login() {
    	return "joinus/login";
    }
	
	//마이페이지
	@RequestMapping(value= {"mypage.do"},method=RequestMethod.GET)
	public ModelAndView myPage(Principal principal) throws Exception {
		
		String id = principal.getName();
		
		MembersVO vo =this.service.getMember(id);
		ModelAndView mv = new ModelAndView("member/myPage");
		mv.addObject("vo",vo);
		return mv;
	}

	//수정
	@RequestMapping(value= {"update.do"},method=RequestMethod.GET)
	public ModelAndView showEdit(MembersVO member) throws Exception {		
		ModelAndView mv = new ModelAndView("member/update");
		mv.addObject("vo",member);
		return mv;
	}
	
	@RequestMapping(value= {"updateProfile.do"},method=RequestMethod.POST)
	public ModelAndView myPageEdit(MembersVO member) throws Exception {		
				
		String inputPass= member.getPswd();
		String pass=passwordEncoder.encode(inputPass);
		member.setPswd(pass);
		
		MembersVO vo = this.service.updateInfo(member);
		
		ModelAndView mv = new ModelAndView("member/myPage");
		mv.addObject("vo",vo);
		
		return mv;
	}
	
	
	
}
