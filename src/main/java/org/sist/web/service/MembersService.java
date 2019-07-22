package org.sist.web.service;

import org.sist.web.vo.MembersVO;

public interface MembersService {

	//회원가입
	public void regist(MembersVO member)throws Exception;
	
	//회원정보
	public MembersVO getMember(String id) throws Exception;
	
	//수정
	public MembersVO updateInfo(MembersVO member) throws Exception;
	
	
}
