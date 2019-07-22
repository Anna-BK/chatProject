package org.sist.web.service;

import javax.inject.Inject;

import org.sist.web.dao.MembersDAO;
import org.sist.web.vo.MembersVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MembersServiceImpl implements MembersService{

	@Inject
	private MembersDAO dao;
	

	@Override
	public void regist(MembersVO member) throws Exception {
		dao.insert(member);
	}
	
	@Override
	public MembersVO getMember(String id) throws Exception {
		MembersVO member= dao.getMember(id);
		return member;
	}

	
	@Override
	@Transactional
	public MembersVO updateInfo(MembersVO member) throws Exception {
		
		dao.updateInfo(member);
		MembersVO vo= dao.getMember(member.getId());
		return vo;
	}

	
}
