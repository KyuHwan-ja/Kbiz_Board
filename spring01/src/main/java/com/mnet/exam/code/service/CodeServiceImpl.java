package com.mnet.exam.code.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mnet.exam.code.dao.CodeDAO;
import com.mnet.util.page.PageObject;

@Service
public class CodeServiceImpl implements CodeService {
	
	@Autowired
	private CodeDAO dao;
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	// 코드 리스트 페이지 리스트 뿌리기
	public List<Map<String, Object>> codeList(PageObject pageObject) {
		// TODO Auto-generated method stub
		return dao.codeList(session, pageObject);
	}
	
	@Override
	//코드 리스트에서 하나 선택시 그 내용 아래에 뿌려주기
	public Map<String, Object> view(Map map){
		return dao.view(session, map);
	}
	
	@Override
	// 코드 수정 처리
	public void codeUpdate(Map<String, Object> map){
		dao.codeUpdate(session, map);
	}
	
	@Override
	//코드 추가 처리
	public void codeInsert(Map<String, Object> map){
		dao.codeInsert(session, map);
	}

}
