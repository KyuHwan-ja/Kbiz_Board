package com.mnet.exam.member.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mnet.exam.member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	@Override
	// 로그인 처리
	public boolean loginCheck(HttpSession session, Map<String, Object> map){

		boolean result = dao.loginCheck(map);

		return result;
	}
	
	@Override
	//로그아웃처리
	public void logout(HttpSession session){
//		invalidate()메서드는 객체를 메모리에서 삭제할수는 없지만 객체를 무효화 시켜버린다!!
//		따라서 참조당할 수 없으며, getId() 메서드이외에는 메서드호출 또한 불가하다.
		session.invalidate();
	}
	
	@Override
	//아이디 중복체크 처리
	public int idCheck(Map<String, Object> map){
		return dao.idCheck(map);
	}
	
	@Override
	//회원가입처리 아이디 비밀번호 성명 db에 저장 
	public void join(Map<String, Object> map){
		 dao.join(map);
	}
	
	@Override
	// 회원 가입 상세 페이지 처리 
	public void joinDetail(Map<String, Object> map){
		 dao.joinDetail(map);
	}
	

}
