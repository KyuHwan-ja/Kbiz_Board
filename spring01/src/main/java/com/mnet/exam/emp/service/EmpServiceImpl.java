package com.mnet.exam.emp.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mnet.exam.emp.dao.EmpDAO;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDAO dao;
	
	@Autowired
	// SqlSessionTemplate은 마이바티스 스프링 연동모듈의 핵심이다. SqlSessionTemplate은 SqlSession을 구현하고 코드에서 SqlSession를 대체하는 역할을 한다. 
	// SqlSessionTemplate 은 쓰레드에 안전하고 여러개의 DAO나 매퍼에서 공유할수 있다.
	SqlSessionTemplate session;
	
	@Override
	// 사원 목록 페이지 리스트 뿌리기
	public List<Map<String, Object>> empList() {
		// TODO Auto-generated method stub
//		System.out.println("EmpServiceImpl.empList()"+dao.empList(session));
		return dao.empList(session);
	}
	
	@Override
	// 사원 목록 페이지 리스트 뿌리기 / 여기선 사원번호와 부서번호를 입력 받는다.
	public List<Map<String, Object>> empListParam(Map<String, Object> map){
//		System.out.println("EmpServiceImpl.empListParam()"+map);
//		System.out.println("EmpServiceImpl.empListParam()"+dao.empListParam(session, map));
		return dao.empListParam(session, map);
	}

}
