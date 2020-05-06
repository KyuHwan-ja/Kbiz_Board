package com.mnet.exam.item.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mnet.exam.item.service.ItemService;

@Controller
public class ItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	private ItemService service;
	
	@RequestMapping("itemList.do")
	public ModelAndView codeList(ModelAndView mv){
		
		mv.setViewName("item/itemList");
		
		return mv;
	}
	//itemList 페이지 보여줄시 다보여주고 ajax를 이욯해서 카테고리 데이터 넣어주기
	@RequestMapping("itemCago.do")
	@ResponseBody
	public Map<String, Object> itemCago() throws Exception{
		
		List<Map<String, Object>> itemCago = service.itemCago();
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		hashmap.put("itemCago", itemCago);
		
		return hashmap;
	}
	// 카테고리 값 선택시 1차 분류 데이터 넣어주기
	@RequestMapping("underCago.do")
	@ResponseBody
	public Map<String, Object> underCago(@RequestBody HashMap<String, Object> map) throws Exception{
		
		List<Map<String, Object>> underCago = service.underCago(map);
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		hashmap.put("underCago", underCago);
		
		return hashmap;
	}
	// 조회 버튼 시 리스트 넣어주기
	@RequestMapping("cagoList.do")
	@ResponseBody
	public Map<String, Object> cagoList(@RequestBody HashMap<String, Object> map) throws Exception{
		
		List<Map<String, Object>> cagoList = service.cagoList(map);
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		hashmap.put("cagoList",cagoList);
		
		return hashmap;
	}
	// ajax로 뿌린 리스트 한줄 클릭시 제조사 셀렉트 박스 옵션 가져오기
	@RequestMapping("madeNameCago.do")
	@ResponseBody
	public Map<String, Object> madeNameCago(@RequestBody HashMap<String, Object> map) throws Exception{
		
		List<Map<String, Object>> madeNameCago = service.madeNameCago(map);
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		hashmap.put("madeNameCago", madeNameCago);
		
		return hashmap;
	}
	// ajax로 뿌린 리스트 한줄 클릭시 단위명 옵션 박스 가져오기
	@RequestMapping("unitNameCago.do")
	@ResponseBody
	public Map<String, Object> unitNameCago(@RequestBody HashMap<String, Object> map) throws Exception{
		
		List<Map<String, Object>> unitNameCago = service.unitNameCago(map);
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		hashmap.put("unitNameCago", unitNameCago);
		
		return hashmap;
	}
	// ajax로 뿌린 리스트 한줄 클릭시 itemCd 받아서 필요한 데이터 보내주기
	@RequestMapping("itemView.do")
	@ResponseBody
	public Map<String, Object> itemView(@RequestBody Map<String, Object> map){
		
		Map<String, Object> itemView = service.itemView(map);
		
		return itemView;
	}
	//아이템 리스트 데이터 수정하기
	@RequestMapping("itemUpdate.do")
	public void itemViewUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemCd = request.getParameter("itemCd");
		String itemName = request.getParameter("itemName");
		String madeNmCd = request.getParameter("madeNameInput");
		String itemUnitCd = request.getParameter("unitNameInput");
		String useYN = request.getParameter("useYN");
		String useYNcheck = "on";
		if(useYNcheck.equals(useYN)){
			useYN="Y";
		}else{
			useYN="N";
		}
		Map<String, Object> map = new HashMap();
			map.put("itemCd", itemCd);
			map.put("itemName", itemName);
			map.put("madeNmCd", madeNmCd);
			map.put("itemUnitCd", itemUnitCd);
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
			
			service.itemViewUpdate(map);
			
			response.sendRedirect("itemList.do");
	}
	//아이템 리스트 데이터 추가하기
	@RequestMapping("itemInsert.do")
	public void itemViewInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemName = request.getParameter("itemName");
		String madeNmCd = request.getParameter("madeNameInput");
		String itemUnitCd = request.getParameter("unitNameInput");
		String itemClsCd = request.getParameter("itemClsCd");
		String useYN = request.getParameter("useYN");
		String useYNcheck = "on";
		if(useYNcheck.equals(useYN)){
			useYN="Y";
		}else{
			useYN="N";
		}
		Map<String, Object> map = new HashMap();
			map.put("itemName", itemName);
			map.put("madeNmCd", madeNmCd);
			map.put("itemUnitCd", itemUnitCd);
			map.put("useYN", useYN);
			map.put("itemClsCd", itemClsCd);
			
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
			
			service.itemViewInsert(map);
			
			response.sendRedirect("itemList.do");
	}
	// ajax 안쓰고 그냥 서브밋 하기 input  hidden 값안에 cdNo 넣어서 서브밋
	@RequestMapping("noAjaxItemList.do")
	public ModelAndView noAjaxItemList(ModelAndView mv, HttpServletRequest request) throws Exception{
		
		String cdNo = request.getParameter("inpuCago");
		Map<String, Object> map = new HashMap();
		map.put("cdNo", cdNo);
		
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
		
		if(cdNo != null && cdNo.length()>0){
			List<Map<String, Object>> itemList = service.noAjaxItemList(map);
			mv.addObject("itemList", itemList);
		} else {
			List<Map<String, Object>> itemList= null;
			mv.addObject("itemList", itemList);
			mv.addObject("msg", "카테고리와 1차분류 선택 후 조회해 주세요.");
		}
		mv.setViewName("item/itemList");
		return mv;
	}

	
	
	

}
