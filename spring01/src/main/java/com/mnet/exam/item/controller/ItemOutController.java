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
public class ItemOutController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemOutController.class);
	
	@Autowired
	private ItemService service;
	
	// 금일 출고 리스트 뿌리기 
	@RequestMapping("itemOut.do")
	public ModelAndView outItemList(ModelAndView mv){
		
		List<Map<String, Object>> outItemList=service.outItemlist();
		
		mv.addObject("outItemList", outItemList);
		
		mv.setViewName("item/itemListOut");
		
		return mv;
	}
	
	// 금일 출고 리스트 에서 한줄 선택시, 선택 내용 아래에 뿌리기
	@RequestMapping("outView.do")
	@ResponseBody
	public Map<String, Object> view(@RequestBody HashMap<String, Object> map) throws Exception{
		
//		Map<String, Object> outView = null;
//	
//		String outItLiCdCheck=(String) map.get("outItemListCdList");
//		System.out.println("$$$$$$$$"+outItLiCdCheck);
//		if(outItLiCdCheck != null){
//			 outView=service.outView(map);
//		}else{
//			
//		}
		Map<String, Object> outView=service.outView(map);
		
		return outView;
	}
	
	// 금일 출고 리스트 에서 한줄 선택시 , 배송회사 셀렉트 박스 값 넣어주기
	@RequestMapping("delivNameCago.do")
	@ResponseBody
	public Map<String, Object> delivNameCago(@RequestBody HashMap<String, Object> map) throws Exception{
		
		List<Map<String, Object>> delivNameCago = service.deliNameCago(map);
		
		HashMap<String, Object> hashmap= new HashMap<String, Object>();
		
		hashmap.put("delivNameCago", delivNameCago);
		
		return hashmap;
	}
	
	// 출고 관리 리스트에서 데이터 수정후 저장시 
	@RequestMapping("outUpdate.do")
	public void outUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String checkYN = request.getParameter("checkYN");
		String checkYNcheck = "on";
		if(checkYNcheck.equals(checkYN)){
			checkYN="Y";
		}else{
			checkYN="N";
		}
		String delivYN = request.getParameter("delivYN");
		String delivYNcheck = "on";
		if(delivYNcheck.equals(delivYN)){
			delivYN="Y";
		}else{
			delivYN="N";
		}
		String delivName = request.getParameter("delivName");
		String delivNo = request.getParameter("delivNo");
		String outItemListCd = request.getParameter("outItemListCd");
		String itemCd = request.getParameter("itemCd");
		String userInfoDetailCd = request.getParameter("userInfoDetailCd");
		String delivAmtStr = request.getParameter("delivAmt");
		int delivAmt = Integer.parseInt(delivAmtStr);
		String checkUser = request.getParameter("checkUser");
		
		Map<String, Object> map = new HashMap();
		map.put("checkYN", checkYN );
		map.put("delivYN", delivYN );
		map.put("delivName", delivName);
		map.put("delivNo", delivNo);
		map.put("outItemListCd", outItemListCd);
		map.put("itemCd", itemCd);
		map.put("userInfoDetailCd", userInfoDetailCd);
		map.put("delivAmt", delivAmt);
		map.put("checkUser", checkUser);
		
//		System.out.println("#####################################");
		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
		Entry<String,Object> entry = null;
		logger.debug("------------Map--------------------");
		while(iterator.hasNext()){
			entry=iterator.next();
			logger.debug("Key: "+entry.getKey()+",\t value:"+entry.getValue());
		}
		logger.debug("");
		logger.debug("-------------------------------------\n");
//		System.out.println("@@@@@@@@@@@@@@@@@ "+map.get("delivYN"));
		
		// 웹에서 금일출고 상품을 보냈을때, 오늘 날짜와 outItemListCd 값으로 금일 출고된 적이 있는지 찾는다
		int chek_outWare=service.chek_outWare(map);
//		System.out.println("###"+chek_outWare);
		
//		int chek_delivAmt=(int)map.get("delivAmt");
//		System.out.println("@@@"+chek_delivAmt);
		
		
		// 배송여부가 n 이고 출고된 적이 없으면 
		if(map.get("delivYN")=="N" 
				){
//			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			// 금일 출고에서 수정값이 배송여부가 N 일때 금일 출고리스트에 값을 수정한다.
			service.outItemUpdate(map);
			
		}
		else{
//			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			// 금일 출고에서 수정값이 배송여부가 Y 일때 금일 출고리스트에 값을 추가한다.
			service.outItemInsert(map);
			// 금일 출고에서 수정값이 배송여부가 Y 일때 상품리스트의 재고 숫자에서 값을 빼준다.
			service.outItemAmt(map);
		}
		
		response.sendRedirect("itemOut.do");
	}
	
	
	

	

}
