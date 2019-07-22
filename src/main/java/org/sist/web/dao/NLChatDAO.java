package org.sist.web.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sist.web.vo.CalendarVO;
import org.sist.web.vo.ChatRoomVO;
import org.sist.web.vo.ChatVoteVO;
import org.sist.web.vo.VoteResultVO;
import org.sist.web.vo.VoteVO;
import org.springframework.stereotype.Repository;

@Repository
public class NLChatDAO implements ChatDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.sist.web.mappers.NLChatDAOMapper";
	
	@Override
	public void createRoom(ChatRoomVO vo) throws Exception {

		session.insert(namespace + ".createRoom", vo); 
		
	}

	@Override
	public String createRoomno(ChatRoomVO vo) throws Exception {
				
		String no = session.selectOne(namespace+".createRoomno", vo);
				
		return no;
	}

	@Override
	public List<Object> getRoomList(String roomtheme) throws Exception {

		List<Object>list = session.selectList(namespace+".getRoomList", roomtheme);
		
		return list;
	}

	@Override
	public void createVote(ChatVoteVO vo) throws Exception {

		session.insert(namespace+".createVote", vo);
		
	}

	@Override
	public List<Object> getVotes(String roomnumber) throws Exception {

		List<Object>list = session.selectList(namespace+".getVotes", roomnumber);
		
		return list;
	}

	@Override
	public void insertVote(VoteVO vo) throws Exception {

		session.insert(namespace+".insertVote", vo);
		
	}

	@Override
	public VoteResultVO getVoteResult(ChatVoteVO vo) throws Exception {

		VoteResultVO vvo = session.selectOne(namespace+".getVoteResult", vo);
		
		return vvo;
	}
	
	@Override
	public void createCal(CalendarVO vo) throws Exception {
		session.insert(namespace+".createCal", vo);
		
	}

	@Override
	public List<Object> listCal(String roomnumber) {
		
		List<Object>list = session.selectList(namespace+".getCalList", roomnumber);
		
		return list;
	
		
	}

	@Override
	public String delCal(String calno) {
		
		session.delete(namespace+".delCal",calno);
		
		return "success";
	}

}
