package org.sist.web.dao;

import java.sql.SQLException;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.sist.web.vo.MembersVO;
import org.springframework.stereotype.Repository;

@Repository
public class MembersDAOImpl implements MembersDAO {

	@Inject
	private SqlSession session;
	
	private static final String namespace="org.sist.web.mappers.MemberMapper";

	@Override
	public int insert(MembersVO member) throws ClassNotFoundException, SQLException {
		return session.insert(namespace+".insert", member);
	}
	
	@Override
	public MembersVO getMember(String id) throws ClassNotFoundException, SQLException {
		return session.selectOne(namespace+".getMember",id);
	}

	@Override
	public int updateInfo(MembersVO member) throws ClassNotFoundException, SQLException {
		return session.update(namespace+".updateInfo", member);
	}

	
}
