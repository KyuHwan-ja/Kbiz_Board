package com.mnet.exam.emp.service;

import java.util.List;
import java.util.Map;

public interface EmpService {
	
	// 사원 목록 페이지 리스트 뿌리기
	List<Map<String, Object>> empList();
	
	// 사원 목록 페이지 리스트 뿌리기 / 여기선 사원번호와 부서번호를 입력 받는다.
	List<Map<String, Object>> empListParam(Map<String, Object> map);
	

}
