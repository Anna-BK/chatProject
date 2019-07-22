package org.sist.web.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.sist.web.dao.ChatDAO;
import org.sist.web.vo.CalendarVO;
import org.sist.web.vo.ChatRoomVO;
import org.sist.web.vo.ChatVoteVO;
import org.sist.web.vo.VoteResultVO;
import org.sist.web.vo.VoteVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class NLChatRoomService implements ChatRoomService{

	@Inject
	private ChatDAO dao; 
	
	@Override
	@Transactional
	public String createRoom(ChatRoomVO vo) throws Exception {
		
		dao.createRoom(vo);
		String no = dao.createRoomno(vo);
		
		return no;
		
	}

	@Override
	public List<Object> getRoomList(String theme) throws Exception {

		List<Object>list = dao.getRoomList(theme);
		
		return list;
	}

	@Override
	public void createVote(ChatVoteVO vo) throws Exception {

		dao.createVote(vo);
		
	}

	@Override
	public List<Object> getVotes(String roomnumber) throws Exception {

		List<Object>list = dao.getVotes(roomnumber);
		
		return list;
	}

	@Override
	public void insertVote(VoteVO vo) throws Exception {

		dao.insertVote(vo);
		
	}

	@Override
	public VoteResultVO getVoteResult(ChatVoteVO vo) throws Exception {

		VoteResultVO vvo = dao.getVoteResult(vo);
		
		return vvo;
	}

	@Override
	public void createCal(CalendarVO vo) throws Exception {
		
		dao.createCal(vo);
		
	}

	@Override
	public List<Object> listCal(String roomnumber) throws Exception {
		
		return dao.listCal(roomnumber);
		
	}

	@Override
	public void delCal(String calno) {
		 dao.delCal(calno);
		
	}
	
	
}
