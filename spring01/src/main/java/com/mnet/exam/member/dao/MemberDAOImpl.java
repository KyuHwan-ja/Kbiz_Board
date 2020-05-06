package com.mnet.exam.member.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mnet.exam.member.controller.MemberController;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger =LoggerFactory.getLogger(MemberDAOImpl.class);

	@Inject
	SqlSessionTemplate sqlSession;
	
	@Override
	// 로그인 처리
	public boolean loginCheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String name=sqlSession.selectOne("member.loginCheck", map);
		System.out.println("MemberDAOImpl.loginCheck.name"+name);
		System.out.println("MemberDAOImpl.loginCheck.map"+map);
		
		return (name==null)?false:true;
	}
	
//	@Override
//	//로그아웃처리
//	public void logout(HttpSession session){
//		
//	}
	
	@Override
	//아이디 중복체크 처리
	public int idCheck(Map<String, Object> map){
		
//		Map<String, Object> resultMap=(Map<String, Object>)sqlSession.selectOne("member.selectUserID", map);
		Map<String, Object> resultMap=sqlSession.selectOne("member.selectUserID", map);
		
		int result = Integer.valueOf(String.valueOf(resultMap.get("RESULT")));
		String result2 = String.valueOf(result);
		logger.debug(result2+"--------------------------------");
		
		return result;
	}
	
	@Override
	//회원가입처리 아이디 비밀번호 성명 db에 저장
	public void join(Map<String, Object> map){
		sqlSession.insert("member.join", map);
	}
	
	@Override
	// 회원 가입 상세 페이지 처리 
	public void joinDetail(Map<String, Object> map){
		sqlSession.insert("member.joinDetail", map);
	}

	
}
