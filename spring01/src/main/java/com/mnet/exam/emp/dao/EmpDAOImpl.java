package com.mnet.exam.emp.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmpDAOImpl implements EmpDAO {
	
	@Override
	// 사원 목록 페이지 리스트 뿌리기
	public List<Map<String, Object>> empList(SqlSessionTemplate session){
//		System.out.println("EmpDAOImpl.empList():"+session.selectList("emp.empList"));
		return session.selectList("emp.empList");
	}
	
	@Override
	// 사원 목록 페이지 리스트 뿌리기 / 여기선 사원번호와 부서번호를 입력 받는다.
	public List<Map<String, Object>> empListParam(SqlSessionTemplate session, Map<String, Object> map){
//		System.out.println("EmpDAOImpl.empListParam()"+map);
//		System.out.println("EmpDAOImpl.empListParam()"+session.selectList("emp.empList", map));
		return session.selectList("emp.empList", map);
		
	}

}
