package com.mnet.util.page;

import java.util.Map;

public class PageObject {
	
	// page: 현재 페이지, perPageRow : 한 페이지에 표시할 글의 갯수
	private int page, perPageRow;
	// startRow: db에서 현재 페이지의 사용할 데이터의 첫번쨰 줄 값
	// endRow:   db에서 현재 페이지의 사용할 데이터의 마지막 줄 값
	private int startRow, endRow;
	// 화면 하단 부분 페이지 링크 걸리는 부분에 사용할 변수
	private int totalRow;  // db 에서 가져온다
	private int totalPage;
	private int pageGroup; // 화면 하단에 표시할 링크 페이지 갯수
	private int startPage, endPage; // endPage는 totalPage를 넘지 못한다.
//	//------------- 검색 처리에 필요한 데이터들 ------------------------//
//	private String searchKey;
//	private String searchWord;
//	
//	private int sideCheck;
//	// 검색키를 저장할 맵을 선언하고 생성한다.
//	private Map<String, String> map;
//	
//	// 댓글 처리를 위한 글번호 선언
//	private int no; 
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageRow() {
		return perPageRow;
	}

	public void setPerPageRow(int perPageRow) {
		this.perPageRow = perPageRow;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageGroup() {
		return pageGroup;
	}

	public void setPageGroup(int pageGroup) {
		this.pageGroup = pageGroup;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	@Override
	public String toString() {
		return "PageObject [page=" + page + ", perPageRow=" + perPageRow + ", startRow=" + startRow + ", endRow="
				+ endRow + ", totalRow=" + totalRow + ", totalPage=" + totalPage + ", pageGroup=" + pageGroup
				+ ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
	public PageObject(){
		//기본값 셋팅
		page = 1;
		perPageRow = 10;
		startRow = 1;
		endRow = 10;
		pageGroup = 10;
	}
	
	public void calcuDBData(){
		// 페이지 '첫쨰 줄 번호'는 '이전 페이지'의 '전체 줄번호'에 다음 번호가 된다
		startRow=(page-1)*perPageRow+1;
		// 끝나는 줄 번호는 '시작줄번호'에 '한페이지에 보여줄 줄번호'을 더한 후 앞에 번호를 선택하기 위해 -1 해준다.
		endRow=startRow+perPageRow-1;
	}
	
	// 화면에 링크된 페이지를 표시하기 위한 데이터 계산
	// 먼저 db에서 전체 줄수를 가져와서 셋팅한후 계산해야 한다.
	public void calcuDisplayData() {
		// 전체 페이지 = (전체 데이터의수 -1)/ 한페이지당 표시 줄수 +1
		totalPage=(totalRow-1)/perPageRow+1;
		//시작페이지 = (현재 페이지 -1)/하단부분 표시할 페이지수 * 하단부분 표시할 페이지수 +1
		startPage=(page-1)/pageGroup*pageGroup+1;
		//마지막 페이지 = 시작페이지 + 하단부분 표시할 페이지수 -1 
		endPage=startPage+pageGroup-1;
		//마지막 페이지는 전체 페이지 수를 넘지 못한다.
		if(endPage>totalPage) endPage=totalPage;
	}
	
	
	
	
	
	
	
	
	
	
}
