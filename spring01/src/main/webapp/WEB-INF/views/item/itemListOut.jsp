<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ut" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="#">
<!-- 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<title>코드관리</title>
 <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style type="text/css">
#clickRow:hover tbody tr:hover td{
	background: #eee;
	cursor: pointer;
}
/* input[id="checkYN"]+label{ */
/* 	display: inline-block; */
/* 	width: 20px; */
/* 	height: 20px; */
/* 	border: 2px solid #bcbcbc; */
/* 	cursor: pointer; */
/* } */
/* input[id="checkYN"]:checked+label{ */
/* 	background-color: #666666; */
/* } */
/* input[id="checkYN"]{ */
/* 	display: none; */
/* } */
/* input[id="delivYN"]+label{ */
/* 	display: inline-block; */
/* 	width: 20px; */
/* 	height: 20px; */
/* 	border: 2px solid #bcbcbc; */
/* 	cursor: pointer; */
/* } */
/* input[id="delivYN"]:checked+label{ */
/* 	background-color: #666666; */
/* } */
/* input[id="delivYN"]{ */
/* 	display: none; */
/* } */
</style>
<script type="text/javascript">
$(document).ready(function(){
	//clickRow 아래 tbody 아래 tr 선택
	$("#clickRow").on("click","tbody tr",function(){
		var str ="";
		var tdArr=new Array();
		// 현재 클릭된 row
		var tr=$(this);
		var td=tr.children();
				
		//해당 필요한 컬럼값  가져오기
		var outItemListCdList = $(this).find("#outItemListCdList").val();
		var delivCorpCd = $(this).find("#delivCorpCd").val();
		//tr.text()는 클릭된 row 즉 tr에 있는 모든 값을 가져온다.
		console.log("outItemListCd :"+outItemListCd);
		console.log("클릭한 row의 모든 데이터 :"+tr.text());
		
		// 리스트에서 한줄 선택시 그 데이터 아래에 뿌려주기 
		fn_itemCdAjax(outItemListCdList);
		
		// 테이블 한줄 클릭시 ajax로 제조사 selectbox option 가져오기 
		fn_delivNmAjax(delivCorpCd);
		
		});
});

	// 리스트에서 한줄 선택시 그 데이터 아래에 뿌려주기 
	function fn_itemCdAjax(outItemListCdList){
		var param = {"outItemListCdList" : outItemListCdList};
		
		$.ajax({
			type : "POST",
			url : "/kyu/outView.do",
			data : JSON.stringify(param), // json을 string으로 변환 시켜주는 함수
			contentType : "application/json",  // 서버에 데이터 보낼 때
			success : function(outView){
// 				console.log(outView);
				$("#itemCd").val(outView.ITEMCD);
				$("#itemName").val(outView.ITEMNAME);
				$("#madeName").val(outView.MADENAME);
				$("#unitName").val(outView.UNITNAME);
				$("#delivAmt").val(outView.DELIVAMT);
				$("#id").val(outView.ID);
				$("#checkUser").val(outView.CHECKUSER);
				$("#relName").val(outView.RELNAME);
				$("#addrCd").val(outView.ADDRCD);
				$("#addrName").val(outView.ADDRNAME);
				$("#mobileTelNo").val(outView.MOBILETELNO);
				$("#homeTelNo").val(outView.HOMETELNO);
// 				$("#checkYN").val(outView.CHECKYN);
// 				$("#delivYN").val(outView.DELIVYN);
				$("#delivNo").val(outView.DELIVNO);
				if(outView.CHECKYN=='Y'){
					$("input:checkbox[name=checkYN]").attr("checked", true).parent().addClass('on');
				} else{
					$("input:checkbox[name=checkYN]").attr("checked", false).parent().addClass('off');
				}
				if(outView.DELIVYN=='Y'){
					$("input:checkbox[name=delivYN]").attr("checked", true).parent().addClass('on');
					$("#view_update").hide();
					$("#view_save").hide();
				} else{
					$("input:checkbox[name=delivYN]").attr("checked", false).parent().addClass('off');
					$("#view_update").show();
					$("#view_save").show();
				}
				$("#outItemListCd").val(outView.OUTITEMLISTCD);
				$("#userInfoDetailCd").val(outView.USERINFODETAILCD);
		
			},
			error : function(request,status,error){
				alert("리스트에서 한줄 선택시 아래에 데이터 넣어주기"+"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
	 	});
	};
	
	// 테이블 한줄 클릭시 ajax로 제조사 selectbox option 가져오기 
	function fn_delivNmAjax(delivCorpCd){
		var delivNmPar = {"delivCorpCd" : delivCorpCd};
		$.ajax({
			type:"POST",
			url:"/kyu/delivNameCago.do",
			data:JSON.stringify(delivNmPar),
			contentType:"application/json",
			dataType:"json",
			success:function(result){
// 				alert("123213");
// 				console.log(JSON.stringify(result.madeNameCago));
				$("select#delivNameCago option").remove();
// 				$("#madeNameCago").append("<option value=''>"+'하위분류'+"</option>");
				for(var i=0; i<result.delivNameCago.length; i++){
					$("#delivNameCago").append("<option value='"+result.delivNameCago[i]["CDNO"]+"'>"+result.delivNameCago[i]["CDNAME"]+"</option>");
				}
			},
			error : function(request,status,error){
				alert("테이블 한줄 클릭시 select옵션 넣어주기 "+"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	};
	
// 	// 수정버튼 클릭시 데이터 사용여부 설정 
	function fn_update(){
		//$("#delivYN").prop('checked') 체크박스가 체크가 되어있는 상황이면, 조건은 true를 반환한다.
		if($("#delivYN").prop('checked')){
			$("input[name=checkYN]").attr("disabled", true);
			$("input[name=delivYN]").attr("disabled", true);
			$("select[name=delivNameCago]").attr("disabled", true);
			$("input[name=delivNo]").attr("disabled", true);
		}else{
			$("input[name=checkYN]").attr("disabled", false);
			$("input[name=delivYN]").attr("disabled", false);
			$("select[name=delivNameCago]").attr("disabled", false);
			$("input[name=delivNo]").attr("disabled", false);
			
		}
	}
// 	// 데이터 수정 후 저장 버튼 클릭시 업데이트 과정
	function db_update(){
		var delivNo = document.outForm.delivNo;
		var langSelect = document.getElementById("delivNameCago");
		var delivName = langSelect.options[langSelect.selectedIndex].value;
		
		if(delivNo.value==''){
			alert("송장번호를 입력하세요");
			document.cForm.cdLvl.focus();
			return false;
		}
		
		$("input[name=delivName]").attr('value', delivName);
		$("input[name=itemCd]").attr("disabled", false);
		$("input[name=delivAmt]").attr("disabled", false);
		$("input[name=checkUser]").attr("disabled", false);
		document.outForm.action="outUpdate.do";
		document.outForm.submit();
// 		alert("마지막 서밋");
	}

</script>  
</head>
<body>
<h2>금일 출고 리스트</h2>
<div class="container" >
<div class="row">
<table class="table" id="clickRow">
	<colgroup>
<%-- 		<col width="20%" /> --%>
<%-- 		<col width="20%" /> --%>
<%-- 		<col width="20%" /> --%>
<%-- 		<col width="20%" /> --%>
<%-- 		<col width="20%" /> --%>
	</colgroup>
    <thead>
        <tr >
            <th >상품코드</th>
            <th >상품명</th>
            <th >제조사코드</th>
            <th >제조사명</th>
            <th >단위명</th>
            <th >출고수량</th>
            <th >회원아이디</th>
            <th >이름</th>
            <th >관계</th>
            <th >우편번호</th>
            <th >주소</th>
            <th >휴대전화</th>
            <th >집전화</th>
            <th >검수여부</th>
            <th >배송여부</th>
        </tr>
    </thead>
<!--                         fn -> 접두어 (prefix) 위에 prefix="fn" -->
<!--                                                var ->  for문 내부에서 사용할 변수 -->
    <tbody>
        <c:choose>
            <c:when test="${fn:length(outItemList) > 0}">
                <c:forEach items="${outItemList }" var="row">
                
                    <tr>
                        <td><span class="itemCd">${row.ITEMCD }</span></td>
                        <td>${row.ITEMNAME }</td>
                        <td>${row.MADENMCD }</td>
                        <td>${row.MADENAME }</td>
                        <td>${row.UNITNAME }</td>
                        <td>${row.DELIVAMT }</td>
                        <td>${row.ID }</td>
                        <td>${row.CHECKUSER }</td>
                        <td>${row.CDNAME }</td>
                        <td>${row.ADDRCD }</td>
                        <td>${row.ADDRNAME }</td>
                        <td>${row.MOBILETELNO }</td>
                        <td>${row.HOMETELNO }</td>
                        <td>
                        <c:if test="${row.CHECKYN eq 'Y'}">
                        <input type="checkbox" name="checkYNlist" id="checkYNlist" checked="checked">
<!--                         <label for="checkYN"></label> -->
                        </c:if>
                        <c:if test="${row.CHECKYN eq 'N'}">
                        <input type="checkbox" name="checkYNlist" id="checkYNlist" >
<!--                         <label for="checkYN"></label> -->
                        </c:if>
                        </td>
                        <td>
                        <c:if test="${row.DELIVYN eq 'Y'}">
                        <input type="checkbox" name="delivYNlist" id="delivYNlist" checked="checked">
<!--                         <label for="delivYN"></label> -->
                        </c:if>
                        <c:if test="${row.DELIVYN eq 'N'}">
                        <input type="checkbox" name="delivYNlist" id="delivYNlist" >
<!--                         <label for="delivYN"></label> -->
                        </c:if>
                        </td>
                        <td>
                        <input type="hidden" name="outItemListCdList" id="outItemListCdList" value="${row.OUTITEMLISTCD }">
                        </td>
                        <td>
                        <input type="hidden" name="delivCorpCd" id="delivCorpCd" value="${row.DELIVCORPCD }">
                        </td>
                    </tr>
               
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4">조회된 결과가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
</div> 
</div>


<div align="center">
		<!-- 페이지 네이션 부분 -->
		<ut:makePagenation endPage="${pageObject.endPage }" 
		totalPage="${pageObject.totalPage }"
		startPage="${pageObject.startPage }" page="${pageObject.page }"/>
</div>
<script>
		//alert(${pageObject.page });
</script>

<div class="container">
<div id="changeDiv">
<form id="outForm" name="outForm" method="post"  >
<table class="table" id="myTable">
	<tr>
		<th>
		</th>
		<td>
		</td>
		<th>
		</th>
		<td>
		</td>
		<td>
			<button type="button" id="view_update" onclick="fn_update();">수정</button>
		</td>
		<td>
			<button type="button" id="view_save" onclick="db_update();">저장</button>
		</td>
		
	</tr>
	<tr>
		<th>
			상품코드:
		</th>
		<td>
			<input type="text" name="itemCd" id="itemCd" disabled="disabled">
		</td>
		<th>
			상품명:
		</th>
		<td>
			<input type="text" name="itemName" id="itemName" disabled="disabled">
		</td>
		<th>
			제조사:
		</th>
		<td>
			<input type="text" name="madeName" id="madeName" disabled="disabled">	
		</td>
	</tr>
	<tr>
		<th>
			단위:
		</th>
		<td>
			<input type="text" name="unitName" id="unitName" disabled="disabled">
		</td>
		<th>
			출고수량:
		</th>
		<td>
			<input type="text" name="delivAmt" id="delivAmt" disabled="disabled">
		</td>
	</tr>
	<tr>
		<th>
			회원아이디:
		</th>
		<td>
			<input type="text" name="id" id="id" disabled="disabled">
		</td>
		<th>
			회원이름:
		</th>
		<td>
			<input type="text" name="checkUser" id="checkUser" disabled="disabled">
		</td>
		<th>
			관계:
		</th>
		<td>
			<input type="text" name="relName" id="relName" disabled="disabled">	
		</td>
	</tr>
	<tr>
		<th>
			우편번호:
		</th>
		<td>
			<input type="text" name="addrCd" id="addrCd" disabled="disabled">
		</td>
		<th>
			주소:
		</th>
		<td>
			<input type="text" name="addrName" id="addrName" disabled="disabled">
		</td>
		<th>
			휴대전화:
		</th>
		<td>
			<input type="text" name="mobileTelNo" id="mobileTelNo" disabled="disabled">	
		</td>
	</tr>
	<tr>
		<th>
			집전화:
		</th>
		<td>
			<input type="text" name="homeTelNo" id="homeTelNo" disabled="disabled">
		</td>
		<th>
			검수여부:
		</th>
		<td>
			<input type="checkbox" name="checkYN" id="checkYN" disabled="disabled">
<!-- 			<label for="checkYN"></label> -->
		</td>
		<th>
			배송여부:
		</th>
		<td>
			<input type="checkbox" name="delivYN" id="delivYN" disabled="disabled">
<!-- 			<label for="delivYN"></label>	 -->
		</td>
	</tr>
	<tr>
		<th>
			배송회사:
		</th>
		<td>
			<select id="delivNameCago" name="delivNameCago" disabled="disabled" >
				<option value="">테스트제조사</option>
			</select>
			<input type="hidden" id="delivName" name="delivName" >
		</td>
		<th>
			송장번호:
		</th>
		<td>
			<input type="text" name="delivNo" id="delivNo" disabled="disabled" maxlength="10" required="required" title="최대 10자리로 입력해주세요">
		</td>
		<td>
			<input type="hidden" name="outItemListCd" id="outItemListCd" >
		</td>
		<td>
			<input type="hidden" name="userInfoDetailCd" id="userInfoDetailCd" >
		</td>
	</tr>
</table>
</form>
</div>
</div>

</body>
</html>
