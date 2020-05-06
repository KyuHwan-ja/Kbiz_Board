package com.mnet.exam.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.mnet.util.page.PageObject;

public interface ItemDAO {
	
	//-------------------------------------------------------
	//상품관리 리스트 관련 서비스
	//itemList 페이지 보여줄시 다보여주고 ajax를 이욯해서 카테고리 데이터 넣어주기
	List<Map<String, Object>> itemCago(SqlSessionTemplate session);
	
	// 카테고리 값 선택시 1차 분류 데이터 넣어주기
	List<Map<String, Object>> underCago(SqlSessionTemplate session, Map<String, Object> map);
	
	// 조회 버튼 시 리스트 넣어주기
	List<Map<String, Object>> cagoList(SqlSessionTemplate session, Map<String, Object> map);

	List<Map<String, Object>> noAjaxItemList(SqlSessionTemplate session, Map<String, Object> map);
	
	// ajax로 뿌린 리스트 한줄 클릭시 itemCd 받아서 필요한 데이터 보내주기
	public Map<String, Object> itemView(SqlSessionTemplate session, Map<String, Object> map);
	
	// ajax로 뿌린 리스트 한줄 클릭시 제조사 셀렉트 박스 옵션 가져오기
	List<Map<String, Object>> madeNameCago(SqlSessionTemplate session, Map<String, Object> map);
	
	// ajax로 뿌린 리스트 한줄 클릭시 단위명 옵션 박스 가져오기
	List<Map<String, Object>> unitNameCago(SqlSessionTemplate session, Map<String, Object> map);
	
	//아이템 리스트 데이터 수정하기
	public void itemViewUpdate(SqlSessionTemplate session, Map<String, Object> map);
	
	//아이템 리스트 데이터 추가하기
	public void itemViewInsert(SqlSessionTemplate session, Map<String, Object> map);
	
	//-------------------------------------------------------
	//입고리스트 관련 dao
	List<Map<String, Object>> wareHouseList(SqlSessionTemplate session, Map<String, Object> map);
	
	//금일 입고 리스트에 데이터 넣을때에 db에서  기존 값이 있는지 체크
	int db_check(SqlSessionTemplate session, String itemCd);
	
	//ajax로 뿌린  금일 입고 리스트 한줄 클릭시 itemCd 받아서 필요한 데이터 보내주기
	public Map<String, Object> wareView(SqlSessionTemplate session, Map<String, Object> map);
	
	// 입고db(inItemList)에  수량을 넣는다 .금일 입고 리스트
	public void db_wareInsert(SqlSessionTemplate session, HashMap<String, Object> map);
	
	// 입고 db에 넣은후 itemList 테이블에 stockAmt 수정
	public void db_FirstItemListUpdate(SqlSessionTemplate session, HashMap<String, Object> map);
	
	// 입고db(inItemList)에 금일 입고 값이 이미 값이 있는 경우 / itemList 에서 initemList 의 기존에 있던 수량을 빼주고, 바뀐 수량을 더해준다
	public void db_itemListUpdate(SqlSessionTemplate session, HashMap<String, Object> map);
	
	// inItemList 테이블에 금일 입고 값이 들어있는 경우 / initemList 안 기존의 데이터, 수량을 수정한다.
	public void db_wareUpdate(SqlSessionTemplate session, HashMap<String, Object> map);
	
	//-------------------------------------------------------
	//출고관리 리스트 관련 
	// 금일 출고 관리 리스트 뿌리기
	List<Map<String, Object>> outItemList(SqlSessionTemplate session);
	
	// 금일 출고리스트  한줄 클릭시 그 내용 보여주기
	Map<String, Object> outView(SqlSessionTemplate session, HashMap<String, Object> map);

	// 금일 출고 리스트 에서 한줄 선택시 , 배송회사 셀렉트 박스 값 넣어주기
	List<Map<String, Object>> delivNameCago(SqlSessionTemplate session, HashMap<String, Object> map);

	// 금일 출고에서 수정값이 배송여부가 N 일때 금일 출고리스트에 값을 수정한다.
	public void outItemUpdate(SqlSessionTemplate session, Map<String, Object> map);

	// 금일 출고에서 수정값이 배송여부가 Y 일때 금일 출고리스트에 값을 추가한다.
	public void outItemInsert(SqlSessionTemplate session, Map<String, Object> map);

	// 금일 출고에서 수정값이 배송여부가 Y 일때 상품리스트의 재고 숫자에서 값을 빼준다.
	public void outItemAmt(SqlSessionTemplate session, Map<String, Object> map);

	//itemList 테이블에서 상품코드에 대한 수량을 가져온다.
	public int chek_outWare(SqlSessionTemplate session, Map<String, Object> map);

	// itemList 테이블에 재고 숫자 값 추가
	public void outItemAmtAdd(SqlSessionTemplate session, Map<String, Object> map);
}
