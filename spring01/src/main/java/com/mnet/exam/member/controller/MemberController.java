package com.mnet.exam.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mnet.exam.member.service.MemberService;

@Controller
public class MemberController {
	
	private static final Logger logger =LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	// 로그인 페이지
	@RequestMapping("login.do")
	public String loginForm(){
		
		return "member/loginForm";
	}
	
	// 로그인 처리
	@RequestMapping("loginCheck.do")
	public ModelAndView loginCheck(ModelAndView mv, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException{
		// id 아이디
		String id = request.getParameter("id");
		//pass 패스워드
		String pass = request.getParameter("pass");
		
		@SuppressWarnings("rawtypes")
		Map<String, Object> map = new HashMap();
		map.put("id", id);
		map.put("pass", pass);
		
		boolean result = memberService.loginCheck(session, map);
		
		if(result){
//			세션 속성명이 name인 속성에 속성값으로 value를 할당한다. 
			session.setAttribute("id", ((Map<String, Object>)map).get("id"));
			System.out.println("MemberServiceImpl.loginCheck().session:"+session.getAttribute("id"));
		}
		
		if(result == true){
			mv.setViewName("main");
			mv.addObject("msg", "success");
		} else {
			mv.setViewName("member/loginForm");
			mv.addObject("msg", "failure");
		}
		return mv;
	}
	
	//로그아웃처리
	@RequestMapping("logout.do")
	public ModelAndView logout(ModelAndView mv, HttpSession session){
		memberService.logout(session);
		mv.setViewName("member/loginForm");
		mv.addObject("msg", "logout");
		return mv;
	}
	
	//회원가입 폼 
	@RequestMapping("joinForm.do")
	public ModelAndView memberJoin(ModelAndView mv, HttpServletRequest request){
		mv.setViewName("member/join");
		return mv;
	}
	
	//회원가입처리 아이디 비밀번호 성명 db에 저장 
	@RequestMapping("join.do")
	public void join(HttpServletResponse response, HttpServletRequest request, ModelAndView mv, HttpSession session) throws Exception{
		
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String name = request.getParameter("name");
		session.setAttribute("id", id);
		System.out.println("MemberController.join.session:"+session.getAttribute("id"));
		
		Map<String, Object> map =new HashMap();
		map.put("id", id);
		map.put("pass", pass);
		map.put("name", name);
		
		memberService.join(map);
		
		response.sendRedirect("joinDetailForm.do");
	}
	
	//아이디 중복체크 처리
	@RequestMapping("idCheck.do")
	
	 //@ResponseBody가 붙은 메서드에서 Map을 반환하면 자동으로 Map 정보가 JSON 객체로 변환되어 전송됩니다.
	@ResponseBody
	
	 //@RequestBody를 붙여주면 컨트롤러로 전송된 JSON 정보가 자동으로 Map으로 변환되어 해당 변수에 저장됩니다.
	public int idCheck(@RequestBody HashMap<String, Object> map) throws Exception{
		
		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
		Entry<String,Object> entry = null;
		logger.debug("------------Map--------------------");
		while(iterator.hasNext()){
			entry=iterator.next();
			logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
		}
		logger.debug("");
		logger.debug("-------------------------------------\n");
		
		
		int checkResult = memberService.idCheck(map);
		
		return checkResult;
	}
	
	// 회원 가입 상세페이지폼
	@RequestMapping("joinDetailForm.do")
	public ModelAndView memberJoinDetail(ModelAndView mv, HttpServletRequest request){
		mv.setViewName("member/detail");
		return mv;
	}
	
	// 회원 가입 상세 페이지 처리 
	@RequestMapping("joinDetail.do")
	public ModelAndView joinDetail(HttpServletResponse response, HttpServletRequest request, HttpSession session, ModelAndView mv) throws Exception{
//		session.setAttribute("id", ((Map<String, Object>)map).get("id"));
		// id 아이디
		String id = (String) session.getAttribute("id");
		System.out.println("MemberController.joinDetail().session id:"+id);
		
		// relCd 관계
		String relCd = request.getParameter("relCd");
		
		//addrCd 우편번호
		String addrCd = request.getParameter("addrCd");
		int addrCdInt = Integer.parseInt(addrCd);
		
		// addrName 주소
		String addrName = request.getParameter("addrName");
		
		// delivName 성명
		String delivName = request.getParameter("delivName");
		
		// mobileTelNo 휴대전화번호
		String mobileTelNo = request.getParameter("mobileTelNo");
		System.out.println("@@@@@@@@@@"+mobileTelNo.length());
		if(mobileTelNo.length()==0){
			mobileTelNo = null;
		}
		
		// homeTelNo 집전화번호
		String homeTelNo = request.getParameter("homeTelNo");
		if(homeTelNo.length()==0){
			homeTelNo = null;
		}
		
		// useYN 사용여부
		String useYN = request.getParameter("useYN");
		String useYNchek = "on";
		if(useYNchek.equals(useYN)){
			useYN = "Y";
		}else{
			useYN = "N";
		}
		
		Map<String, Object> map = new HashMap();
		map.put("id", id);
		map.put("relCd", relCd);
		map.put("addrCd", addrCdInt);
		map.put("addrName", addrName);
		map.put("delivName", delivName);
		map.put("mobileTelNo", mobileTelNo);
		map.put("homeTelNo", homeTelNo);
		map.put("useYN", useYN);
		
		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
		Entry<String,Object> entry = null;
		logger.debug("------------Map--------------------");
		while(iterator.hasNext()){
			entry=iterator.next();
			logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
		}
		logger.debug("");
		logger.debug("-------------------------------------\n");
		
		
		memberService.joinDetail(map);
		
		
//		response.sendRedirect("joinDetailForm.do");
		mv.setViewName("main");
		return mv;
		
	}
	
	
//	//@@@@@   리 스 트 로 받아서 session 에 다양한 값 넘기고 로그인 처리 
//	// @@@@@@@@@@@@@@@@@@@@@@@@@
//	@RequestMapping(value="/login/loginSession.do")
//
//	 public ModelAndView loginSession(Map<String,Object> commandMap, HttpSession session,String USER_ID, String USER_PW) throws Exception{
//
// 	ModelAndView mv = new ModelAndView();
//
// 	System.out.print("###############################################");
//	System.out.print("###############################################");  
//
// 	 Map<String,String> map = new HashMap<String,String>();
//
// 	 map.put("USER_ID", USER_ID);
//
// 	 map.put("USER_PW", USER_PW);
//
// 	List<Map<String, Object>> list = loginService.userList(map);
//
// 	if(list.isEmpty()){
//
// 		mv.setViewName("/login/loginView");
//
// 	}else{
//
// 		session.setAttribute("id", USER_ID);
//
//		session.setAttribute("pw", USER_PW);
//
//		session.setMaxInactiveInterval(60*60);
//
//		session.getAttribute("id");
//
// 		mv.setViewName("/login/menu");  
// 	}
	
//	return mv;
// }

}
