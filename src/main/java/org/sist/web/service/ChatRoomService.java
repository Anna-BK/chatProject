package org.sist.web.service;

import java.util.List;

import org.sist.web.vo.CalendarVO;
import org.sist.web.vo.ChatRoomVO;
import org.sist.web.vo.ChatVoteVO;
import org.sist.web.vo.VoteResultVO;
import org.sist.web.vo.VoteVO;

public interface ChatRoomService {

	public String createRoom(ChatRoomVO vo) throws Exception;
	
	public List<Object> getRoomList(String theme)throws Exception;

	public void createVote(ChatVoteVO vo)throws Exception;

	public List<Object> getVotes(String roomnumber)throws Exception;

	public void insertVote(VoteVO vo)throws Exception;

	public VoteResultVO getVoteResult(ChatVoteVO vo)throws Exception;
	
	public void createCal(CalendarVO vo) throws Exception;
	
	public   List<Object>  listCal(String roomnumber) throws Exception;

	public void delCal(String calno);
	
	
}
