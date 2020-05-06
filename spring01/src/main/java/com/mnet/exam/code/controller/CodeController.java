package com.mnet.exam.code.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mnet.exam.code.service.CodeService;
import com.mnet.util.page.PageObject;

@Controller
public class CodeController {
	
	private static final Logger logger = LoggerFactory.getLogger(CodeController.class);
	
	@Autowired
	private CodeService service;
	
	// 코드 리스트 페이지 리스트 뿌리기
	@RequestMapping("codeList.do")
	public ModelAndView codeList(ModelAndView mv, PageObject pageObject){
		
		List<Map<String, Object>> codeList=service.codeList(pageObject);
		
		mv.addObject("pageObject", pageObject);
		mv.addObject("codeList", codeList);
		
		mv.setViewName("code/codeList");
		return mv;
	}
	
	//코드 리스트에서 하나 선택시 그 내용 아래에 뿌려주기
	@RequestMapping("view.do")
	@ResponseBody
	public Map<String, Object> view(@RequestBody HashMap<String, Object> map) throws Exception{
//		Map<String, Object> map = new HashMap();
//		map.put("cdNo", cdNo);
		Map<String, Object> codeView = service.view(map);
		
		//codeView.put("page", map.get("page"));
		
		return codeView;
	}
	
	// 코드 수정 처리 
	@RequestMapping("codeUpdate.do")
	public void codeUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String cdNo = request.getParameter("cdNo");
		String cdLvl = request.getParameter("cdLvl");
		int cdLvlint = Integer.parseInt(cdLvl);
		String upCd = request.getParameter("upCd");
		String cdName = request.getParameter("cdName");
		String useYN = request.getParameter("useYN");
		String useYNcheck = "on";
		if(useYNcheck.equals(useYN)){
			useYN="Y";
		}else{
			useYN="N";
		}
		Map<String, Object> map = new HashMap();
		map.put("cdNo", cdNo);
		map.put("cdLvl", cdLvlint);
		map.put("upCd", upCd);
		map.put("cdName", cdName);
		map.put("useYN", useYN);
		
		System.out.println("#####################################");
		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
		Entry<String,Object> entry = null;
		logger.debug("------------Map--------------------");
		while(iterator.hasNext()){
			entry=iterator.next();
			logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
		}
		logger.debug("");
		logger.debug("-------------------------------------\n");
		
		service.codeUpdate(map);
		System.out.println("############2222222222222222################");
		
		response.sendRedirect("codeList.do");
		
	}
	
	//코드 추가 처리
	@RequestMapping("codeInsert.do")
	public void codeInsert(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String cdLvl = request.getParameter("cdLvl");
		int cdLvlint = Integer.parseInt(cdLvl);
		String upCd = request.getParameter("upCd");
		String cdName = request.getParameter("cdName");
		String useYN = request.getParameter("YN");
		System.out.println("useYn확인"+useYN);
		String useYNcheck = "on";
		if(useYNcheck.equals(useYN)){
			useYN="Y";
		}else{
			useYN="N";
		}
		Map<String, Object> map = new HashMap();
		map.put("cdLvl", cdLvlint);
		map.put("upCd", upCd);
		map.put("cdName", cdName);
		map.put("useYN", useYN);
		
		System.out.println("#####################################");
		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
		Entry<String,Object> entry = null;
		logger.debug("------------Map--------------------");
		while(iterator.hasNext()){
			entry=iterator.next();
			logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
		}
		logger.debug("");
		logger.debug("-------------------------------------\n");
		
		service.codeInsert(map);
		System.out.println("############2222222222222222################");
		
		response.sendRedirect("codeList.do");
		
	}
	
	
	

}
