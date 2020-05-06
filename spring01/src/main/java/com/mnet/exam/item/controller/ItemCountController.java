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
public class ItemCountController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemCountController.class);
	
	@Autowired
	private ItemService service;
	
	@RequestMapping("itemCount.do")
	public ModelAndView itemCountList(ModelAndView mv){
		
		mv.setViewName("item/itemListCount");
		
		return mv;
	}
//	// 조회 버튼 시 리스트 넣어주기
	@RequestMapping("wareList.do")
	@ResponseBody
	public Map<String, Object> wareHouseList(@RequestBody HashMap<String, Object> map) throws Exception{
		
		List<Map<String, Object>> wareHouseList = service.wareHouseList(map);
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		hashmap.put("wareHouseList", wareHouseList);
		
		return hashmap;
	}
	// ajax로 뿌린  금일 입고 리스트 한줄 클릭시 itemCd 받아서 필요한 데이터 보내주기
	@RequestMapping("wareView.do")
	@ResponseBody
	public Map<String, Object> wareView(@RequestBody Map<String, Object> map){
		
		Map<String, Object> wareView = service.wareView(map);
		
		return wareView;
	}
	
//	//아이템 리스트 데이터 추가하기
	@RequestMapping("insertWare.do")
	@ResponseBody
	public Map<String, Object> insertWare(@RequestBody HashMap<String, Object> map) throws Exception {
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
						
			int insAmt;
			insAmt=Integer.parseInt((String) map.get("insAmt"));
//			System.out.println("##########  "+insAmt);
			String itemCd;
			itemCd =(String)map.get("itemCd");
//			System.out.println("##########  "+itemCd);
			String insItemListCd;
			insItemListCd =(String)map.get("insItemListCd");
//			// 입고db(inItemList)에  수량을 넣는다 .금일 입고 리스트
//			service.db_wareInsert(map);
//			service.db_itemListUpdate(map);
			
			// 금일 날짜로 inItemList 에 값이 있는지 체크해서 값이 없으면 inItemList 테이블에 insert 추가 하고 // 있으면 inItemList 테이블에 있는 값을 수정한다.
			int db_check=service.db_check(itemCd);
			System.out.println("##########  "+db_check);
			if(db_check == 0 && insItemListCd != null ){
				// 입고db(inItemList)에  수량을 넣는다 .금일 입고 리스트
				service.db_wareInsert(map);
				// 입고 db에 넣은후 itemList 테이블에 stockAmt 수정
				service.db_FirstItemListUpdate(map);
			} else {
				// 입고db(inItemList)에 금일 입고 값이 이미 값이 있는 경우 / itemList 에서 initemList 의 기존에 있던 수량을 빼주고, 바뀐 수량을 더해준다
				service.db_itemListUpdate(map);	
				// inItemList 테이블에 금일 입고 값이 들어있는 경우 / initemList 안 기존의 데이터, 수량을 수정한다.
				service.db_wareUpdate(map);
			}
//			service.itemViewInsert(map);
			return map;
	}
	
//	// ajax로 뿌린 리스트 한줄 클릭시 제조사 셀렉트 박스 옵션 가져오기
//	@RequestMapping("madeNameCago.do")
//	@ResponseBody
//	public Map<String, Object> madeNameCago(@RequestBody HashMap<String, Object> map) throws Exception{
//		
//		List<Map<String, Object>> madeNameCago = service.madeNameCago(map);
//		
//		HashMap<String, Object> hashmap = new HashMap<String, Object>();
//		
//		hashmap.put("madeNameCago", madeNameCago);
//		
//		return hashmap;
//	}
//	// ajax로 뿌린 리스트 한줄 클릭시 제조사 셀렉트 박스 옵션 가져오기
//	@RequestMapping("unitNameCago.do")
//	@ResponseBody
//	public Map<String, Object> unitNameCago(@RequestBody HashMap<String, Object> map) throws Exception{
//		
//		List<Map<String, Object>> unitNameCago = service.unitNameCago(map);
//		
//		HashMap<String, Object> hashmap = new HashMap<String, Object>();
//		
//		hashmap.put("unitNameCago", unitNameCago);
//		
//		return hashmap;
//	}
//	// ajax로 뿌린 리스트 한줄 클릭시 itemCd 받아서 필요한 데이터 보내주기
//	@RequestMapping("itemView.do")
//	@ResponseBody
//	public Map<String, Object> itemView(@RequestBody Map<String, Object> map){
//		
//		Map<String, Object> itemView = service.itemView(map);
//		
//		return itemView;
//	}
//	//아이템 리스트 데이터 수정하기
//	@RequestMapping("itemUpdate.do")
//	public void itemViewUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String itemCd = request.getParameter("itemCd");
//		String itemName = request.getParameter("itemName");
//		String madeNmCd = request.getParameter("madeNameInput");
//		String itemUnitCd = request.getParameter("unitNameInput");
//		String useYN = request.getParameter("useYN");
//		String useYNcheck = "on";
//		if(useYNcheck.equals(useYN)){
//			useYN="Y";
//		}else{
//			useYN="N";
//		}
//		Map<String, Object> map = new HashMap();
//			map.put("itemCd", itemCd);
//			map.put("itemName", itemName);
//			map.put("madeNmCd", madeNmCd);
//			map.put("itemUnitCd", itemUnitCd);
//			map.put("useYN", useYN);
//			
//			System.out.println("#####################################");
//			Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
//			Entry<String,Object> entry = null;
//			logger.debug("------------Map--------------------");
//			while(iterator.hasNext()){
//				entry=iterator.next();
//				logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
//			}
//			logger.debug("");
//			logger.debug("-------------------------------------\n");
//			
//			service.itemViewUpdate(map);
//			
//			response.sendRedirect("itemList.do");
//	}
//	//아이템 리스트 데이터 추가하기
//	@RequestMapping("itemInsert.do")
//	public void itemViewInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String itemName = request.getParameter("itemName");
//		String madeNmCd = request.getParameter("madeNameInput");
//		String itemUnitCd = request.getParameter("unitNameInput");
//		String itemClsCd = request.getParameter("itemClsCd");
//		String useYN = request.getParameter("useYN");
//		String useYNcheck = "on";
//		if(useYNcheck.equals(useYN)){
//			useYN="Y";
//		}else{
//			useYN="N";
//		}
//		Map<String, Object> map = new HashMap();
//			map.put("itemName", itemName);
//			map.put("madeNmCd", madeNmCd);
//			map.put("itemUnitCd", itemUnitCd);
//			map.put("useYN", useYN);
//			map.put("itemClsCd", itemClsCd);
//			
//			System.out.println("#####################################");
//			Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
//			Entry<String,Object> entry = null;
//			logger.debug("------------Map--------------------");
//			while(iterator.hasNext()){
//				entry=iterator.next();
//				logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
//			}
//			logger.debug("");
//			logger.debug("-------------------------------------\n");
//			
//			service.itemViewInsert(map);
//			
//			response.sendRedirect("itemList.do");
//	}
//	// ajax 안쓰고 그냥 서브밋 하기 input  hidden 값안에 cdNo 넣어서 서브밋
//	@RequestMapping("noAjaxItemList.do")
//	public ModelAndView noAjaxItemList(ModelAndView mv, HttpServletRequest request) throws Exception{
//		
//		String cdNo = request.getParameter("inpuCago");
//		Map<String, Object> map = new HashMap();
//		map.put("cdNo", cdNo);
//		
//		System.out.println("#####################################");
//		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
//		Entry<String,Object> entry = null;
//		logger.debug("------------Map--------------------");
//		while(iterator.hasNext()){
//			entry=iterator.next();
//			logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
//		}
//		logger.debug("");
//		logger.debug("-------------------------------------\n");
//		
//		if(cdNo != null && cdNo.length()>0){
//			List<Map<String, Object>> itemList = service.noAjaxItemList(map);
//			mv.addObject("itemList", itemList);
//		} else {
//			List<Map<String, Object>> itemList= null;
//			mv.addObject("itemList", itemList);
//			mv.addObject("msg", "카테고리와 1차분류 선택 후 조회해 주세요.");
//		}
//		mv.setViewName("item/itemList");
//		return mv;
//	}
//
//	
//	
	

}
