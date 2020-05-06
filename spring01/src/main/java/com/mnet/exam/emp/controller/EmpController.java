package com.mnet.exam.emp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mnet.exam.emp.service.EmpService;

@Controller
public class EmpController {

	private static final Logger logger = LoggerFactory.getLogger(EmpController.class);
	
	@Autowired
	private EmpService service;
	
	// 사원 목록 페이지 리스트 뿌리기
	@RequestMapping("empList.do")
	public ModelAndView empList(ModelAndView mv){
		
		// return 된 맵을 리스트 안에 넣어준다.
		List<Map<String, Object>> empList = service.empList();
		
		//java.util.ArrayList cannot be cast to java.util.Map 로 오류가 난다.
//		Map<String, Object> empList = (Map<String, Object>) service.empList();
		
//		System.out.println("EmpController.empList():"+empList);
		
		mv.addObject("empList", empList);
		mv.setViewName("emp/empList");
		
		return mv;
	}
	
	// 사원 목록 페이지 리스트 뿌리기 / 여기선 사원번호와 부서번호를 입력 받는다.
	//검증되지 않은 연산자 관련 경고 억제
	@SuppressWarnings("unchecked")
	@RequestMapping("empListParam.do")
	public ModelAndView empListParam(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException{
		// 사원번호 empNo
		String empNo = request.getParameter("empNo");
		// 부서번호 deptNo
		String deptNo = request.getParameter("deptNo");

//		rawtypes : 제네릭(데이터 형식에 의존하지 않고, 하나의 값이 여러 다른 데이터 타입들을 가질 수 있음)을 사용하는 클래스 매개 변수가 불특정일 때의 경고 억제
		@SuppressWarnings("rawtypes")
		Map<String, Object> map = new HashMap();
		map.put("empNo", empNo);
		map.put("deptNo", deptNo);
		
//		System.out.println("EmpController.empListParam()"+map);
		
		if((empNo != null && empNo.length() > 0) || (deptNo != null && deptNo.length() > 0)) {
			
			List<Map<String, Object>> empListParam=service.empListParam(map);
			
			mv.addObject("empListParam", empListParam);
			
//			우리는 utf-8 문자코드로 사용할거야. utf-8로 사용해줘'라는 메세지를 전달해야
			response.setContentType("text/html; charset=UTF-8");
			
//			이런 식으로 응답으로 내보낼 출력 스트림을 얻어낸 후
			PrintWriter out = response.getWriter();
			
//			이런 식으로 스트림에 텍스트를 기록하게 됩니다.
			out.println("<script>alert('조회가 완료되었습니다.');</script>");
			
			// flush()는 현재 버퍼에 저장되어 있는 내용을 클라이언트로 전송하고 버퍼를 비운다??
			out.flush();
			
			
		} else {
			List<Map<String, Object>> emptylist =  null;
			
			mv.addObject("empList",emptylist);
			
			mv.addObject("msg","검색어를 하나 이상 입력하고 조회를 해주세요.");
		}
		mv.setViewName("emp/empListParam");
		
		return mv;
	}
	
}
