package com.mnet.exam.code.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.mnet.util.page.PageObject;

public interface CodeDAO {
	
	// 코드 리스트 페이지 리스트 뿌리기
	List<Map<String, Object>> codeList(SqlSessionTemplate session, PageObject pageObject);

	//코드 리스트에서 하나 선택시 그 내용 아래에 뿌려주기
	Map<String, Object> view(SqlSessionTemplate session, Map map);
	
	// 코드 수정 처리
	public void codeUpdate(SqlSessionTemplate session, Map<String, Object> map);
	
	//코드 추가 처리
	public void codeInsert(SqlSessionTemplate session, Map<String, Object> map);

}
