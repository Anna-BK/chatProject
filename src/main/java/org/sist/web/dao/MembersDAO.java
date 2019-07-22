package org.sist.web.dao;

import java.sql.SQLException;

import org.sist.web.vo.MembersVO;

public interface MembersDAO {
			
	//회원가입
	public int insert(MembersVO member) throws ClassNotFoundException, SQLException;
	 
	//회원정보
	public MembersVO getMember(String id) throws ClassNotFoundException, SQLException;

	//수정
	public int updateInfo(MembersVO member) throws ClassNotFoundException, SQLException;
	
	
}
