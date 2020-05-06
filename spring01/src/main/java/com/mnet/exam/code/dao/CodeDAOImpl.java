package com.mnet.exam.code.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mnet.util.page.PageObject;

@Repository
public class CodeDAOImpl implements CodeDAO {

	@Override
	// 코드 리스트 페이지 리스트 뿌리기
	public List<Map<String, Object>> codeList(SqlSessionTemplate session, PageObject pageObject) {
		// TODO Auto-generated method stub
		// db에서 사용할 startRow 와 endRow 를 구한다.
		pageObject.calcuDBData();
		// 화면에 표시할 페이지 데이터에 대한 계산 (먼저 총 페이지 수를 db에서 가져온다.)
		pageObject.setTotalRow(session.selectOne("code.getTotalRow"));
		pageObject.calcuDisplayData();
		return session.selectList("code.codeList", pageObject);
	}
	
	@Override
	//코드 리스트에서 하나 선택시 그 내용 아래에 뿌려주기
	public Map<String, Object> view(SqlSessionTemplate session, Map map){
		return session.selectOne("code.view", map);
	}
	
	@Override
	// 코드 수정 처리
	public void codeUpdate(SqlSessionTemplate session, Map<String, Object> map){
		session.update("code.codeUpdate", map);
	}
	
	@Override
	//코드 추가 처리
	public void codeInsert(SqlSessionTemplate session, Map<String, Object> map){
		session.insert("code.codeInsert", map);
	}

}
