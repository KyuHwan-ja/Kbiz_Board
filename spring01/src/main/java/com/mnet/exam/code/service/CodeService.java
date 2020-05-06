package com.mnet.exam.code.service;

import java.util.List;
import java.util.Map;

import com.mnet.util.page.PageObject;

public interface CodeService {
	
	// 코드 리스트 페이지 리스트 뿌리기
	List<Map<String, Object>> codeList(PageObject pageObject);
	
	//코드 리스트에서 하나 선택시 그 내용 아래에 뿌려주기
	public Map<String, Object> view(Map map);
	
	// 코드 수정 처리
	public void codeUpdate(Map<String, Object> map);
	
	//코드 추가 처리
	public void codeInsert(Map<String, Object> map);
	
	

}
