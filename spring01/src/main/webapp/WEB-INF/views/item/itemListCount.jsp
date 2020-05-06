<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ut" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="#">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>상품관리</title>
<style type="text/css">
#allList:hover tbody tr:hover td{
	background: #eee;
	cursor: pointer;
}
#wareHouse:hover tbody tr:hover td{
	background: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		// 페이지가 열리고 난 후 ajax를 이용해 카테고리(#cago)에 데이터 받기
		$.ajax({
			type:"POST", 
			url:"/kyu/itemCago.do",
			dataType : "json",  //서버에서 보내는 데이터 타입
			success: function(result){
// 				alert("12341234");
// 				console.log(JSON.stringify(result.itemCago));
				for(var i=0; i<result.itemCago.length; i++){
					$("#cago").append("<option value='"+result.itemCago[i]["CDNO"]+"'>"+result.itemCago[i]["CDNAME"]+"</option>");
				}
				
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		$("#cago").on('change',function(){
			if(this.value != ""){
				var cdNo = $(this).find(":selected").val();
// 				alert("카테고리 옵션 선택"+cdNo);
				fn_cago1(cdNo);
			}
		});
	});
	
	// 카테고리에서 데이터 선택시 1차분류 데이터 넣어주기
	function fn_cago1(cdNo){
		var param = {"cdNo":cdNo};
		$.ajax({
			type:"POST",
			url:"/kyu/underCago.do",
			data:JSON.stringify(param),
			contentType:"application/json",
			dataType:"json",
			success:function(result){
// 				alert("123213");
// 				console.log(JSON.stringify(result.underCago));
				$("select#cago1 option").remove();
				$("#cago1").append("<option value=''>"+'하위분류'+"</option>");
				for(var i=0; i<result.underCago.length; i++){
					$("#cago1").append("<option value='"+result.underCago[i]["CDNO"]+"'>"+result.underCago[i]["CDNAME"]+"</option>");
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});		
	}
	
		// 조회 버튼 시 리스트 가져오기  전체리스트 테이블 쪽을 리셋하고 다시 컬럼명과 데이터를 넣어주는 방식
	function db_cagoList(cdNo){
		var langSelect = document.getElementById("cago1");
		var cdNo = langSelect.options[langSelect.selectedIndex].value;
		var underparam={"cdNo":cdNo};
		//  1차분류의 값  cdno를  itemClsCd 값을 넣어준다. 
// 		$("input[name=itemClsCd]").attr('value', cdNo);
// 		console.log(JSON.stringify(underparam));
		$.ajax({
			type:"POST",
			url:"/kyu/cagoList.do",
			data:JSON.stringify(underparam),
			contentType:"application/json",
			dataType:"json",
			success:function(result){
// 				console.log("성공리설트"+result);
// 				console.log("리스트호출"+JSON.stringify(result.cagoList));
// 				console.log("그냥 result호출"+result.cagoList);
				$("#newTbody td").remove();
				$newTbody = $("<tbody id='newTbody'></tbody>");
				$("#allList").append($newTbody);
				var arr = new Array();
				var arr=result.cagoList;
// 				console.log("arr"+arr);
				for(i=0, j=0; i<arr.length,j<arr.length; i++,j++){
					     str =  '<tr>'+'<td id="itemCdAjax">' + arr[i].ITEMCD + '</td>'+
						        '<td>' + arr[i].ITEMNAME + '</td>'+
						  		'<td id="madeNmCdAjax">' + arr[i].MADENMCD + '</td>'+
						  		'<td id="madeNmAjax">' + arr[i].MADENAME + '</td>'+
						  		'<td id="unitNmCdAjax">' + arr[i].ITEMUNITCD + '</td>'+
						  		'<td id="unitNmAjax">' + arr[i].UNITNAME + '</td>'+
						  		'<td>' + arr[i].STOCKAMT + '</td>';
						  		//여기서 위에 끊고 ;  다시 시작 해서 맞는걸 str에 넣어준다 // 조건에 맞는게 들어갔으면 또 끊고 ;
						 			if(arr[i].STOCKYN == 'Y'){
		 				  				str = str + "<td>"+"<input type='checkbox' checked='checked'>"+"</td>";
									} else {
										str = str + "<td>"+"<input type='checkbox' >"+"</td>";
									};
									if(arr[i].USEYN == 'Y'){
										str = str + "<td>"+"<input type='checkbox' checked='checked'>"+"</td>";
									} else {
										str = str + "<td>"+"<input type='checkbox' >"+"</td>"+"</tr>";
									};
									$("#newTbody").append(str);	
				 				};
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		
	// 조회 버튼 시 금일 입고 리스트 가져오기  금일 입고 리스트 테이블 쪽을 리셋하고 다시 컬럼명과 데이터를 넣어주는 방식
	function db_wareList(cdNo){
		var langSelect = document.getElementById("cago1");
		var cdNo = langSelect.options[langSelect.selectedIndex].value;
		var underparam={"cdNo":cdNo};
		$.ajax({
			type:"POST",
			url:"/kyu/wareList.do",
			data:JSON.stringify(underparam),
			contentType:"application/json",
			dataType:"json",
			success:function(result){
// 				console.log("성공리설트"+result);
// 				console.log("리스트호출"+JSON.stringify(result.cagoList));
// 				console.log("그냥 result호출"+result.cagoList);
				$("#wareTbody td").remove();
				$wareTbody = $("<tbody id='wareTbody'></tbody>");
				$("#wareHouse").append($wareTbody);
				var arr = new Array();
				var arr=result.wareHouseList;
// 				console.log("arr"+arr);
				for(i=0, j=0; i<arr.length,j<arr.length; i++,j++){
					     str =  '<tr>'+'<td id="itemCdWare">' + arr[i].ITEMCD + '</td>'+
						        '<td>' + arr[i].ITEMNAME + '</td>'+
						  		'<td id="madeNmCdWare">' + arr[i].MADENMCD + '</td>'+
						  		'<td id="madeNmWare">' + arr[i].MADENAME + '</td>'+
						  		'<td id="unitNmCdWare">' + arr[i].ITEMUNITCD + '</td>'+
						  		'<td id="unitNmWare">' + arr[i].UNITNAME + '</td>'+
						  		'<td>' + arr[i].INSAMT + '</td>'+'</tr>';
						  		
									$("#wareTbody").append(str);	
				 				};
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	
	//ajax로 뿌려준 테이블을 한줄 선택하는 방법 ajax로 새로 생긴 테이블이라 .on을 사용한다.
	 	$(document).on('click', '#newTbody tr', function(){
		 	var tr = $(this);
		 	console.log("클릭한 줄 "+tr.text());
		 	var itemCd = $(this).find('#itemCdAjax').text();
// 		 	console.log("클릭한 줄 상품코드 "+itemCd);
// 		 	console.log("클릭한 줄 제조사 코드 "+madeNmCd);
			// input 아래 값 초기화
			fn_inputRemove();
			// input에 값 넣어주기 
		 	fn_itemView(itemCd);
		 	});
	
	//  itemCd 를 ajax로 값 넘겨서 데이터값 가져와서 뿌리기
	function fn_itemView(itemCd){
			var itemPar = {"itemCd" : itemCd};
			$.ajax({
					type : "POST",
					url : "/kyu/itemView.do",
					data : JSON.stringify(itemPar),
					contentType : "application/json",
					success : function(itemView){
// 							console.log("ajax를 통해서 한줄의 데이터를 가져온다"+itemView);
							$("input[name=itemCd]").attr("disabled", true);
							console.log("itemCd "+itemView.ITEMCD);
							$("#itemCd").val(itemView.ITEMCD);
							$("#itemName").val(itemView.ITEMNAME);
							$("#madeName").val(itemView.MADENAME);
							$("#unitName").val(itemView.UNITNAME);
							$("#wareCount").val(itemView.STOCKAMT);
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				
				});
		};
		
// 		// 수정버튼 클릭시 데이터 사용여부 설정 
		function fn_update(){
// 			$("input[name=itemName]").attr("disabled", false);
// 			$("input[name=madeName]").attr("disabled", false);
// 			$("input[name=unitName]").attr("disabled", false);
			$("input[name=wareCount]").attr("disabled", false);
		};
		
		// 데이터 수정 후 저장 버튼 클릭시 금일 입고 리스트에 데이터 넣기 업데이트 과정
		function db_save(){
			var itemName = document.iForm.itemName;
			var madeName = document.iForm.madeName;
			const patt=/^(['개']|['벌'])$/;
			var unitName = document.iForm.unitName.value;
			var wareCount = document.iForm.wareCount;
			
			if(itemName.value==''){
				alert("상품명을 입력하세요");
				document.iForm.itemName.focus();
				return false;
			}
			else if(madeName.value==''){
				alert("제조사 이름을 입력해주세요");
				document.iForm.madeName.focus();
				return false;
			}
			else if((unitName.match(patt))==null){
				alert("단위명을 형태(개 또는 벌)에 맞게 입력해주세요");
				document.iForm.unitName.focus();
				return false;
			}
			else if(wareCount.value==''){
				alert("입고 수량을 입력해주세요");
				document.iForm.wareCount.focus();
				return false;
			}
			$("input[name=itemCd]").attr("disabled", false);
			
			fn_insertWare();
// 			document.iForm.action="itemUpdate.do";
// 			document.iForm.submit();
//	 		alert("마지막 서밋");
		};
		
		// 금일 입고 리스트 수량 수정후 데이터 넣기 ajax로 
		function fn_insertWare(){
			var itemCd = document.iForm.itemCd.value;
// 			console.log("ㅁㄴㅇㄹ"+itemCd);
			var insAmt = document.iForm.wareCount.value;
			var insItemListCd = document.iForm.insItemListCd.value;
			var wareParam = {"itemCd" : itemCd, "insAmt" : insAmt, "insItemListCd" : insItemListCd };
			console.log("asdf"+wareParam.itemCd+"asdf"+wareParam.insAmt);
			$.ajax({
				type : "POST",
				url : "/kyu/insertWare.do",
				data : JSON.stringify(wareParam),
				contentType : "application/json",
				success : function(result){
						alert("금일 입고 리스트 데이터 넣기");
						// 조회 버튼 시 금일 입고 리스트 가져오기  금일 입고 리스트 테이블 쪽을 리셋하고 다시 컬럼명과 데이터를 넣어주는 방식
						db_wareList();
						
						// 조회 버튼 시 리스트 가져오기  전체리스트 테이블 쪽을 리셋하고 다시 컬럼명과 데이터를 넣어주는 방식
						db_cagoList();
						
						// 아래 input 데이터 초기화 하기
						fn_inputRemove();
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			
			});
		};
		
		// 아래 input 데이터 초기화 하기
		function fn_inputRemove(){
			$("#inputTable td").remove();
			$inputTd = $("<td id='itemCdTd'></td>");
			$("#itemCdTr").append($inputTd);
			 str =  '<input type="text" id="itemCd" name="itemCd"  disabled="disabled" >'
					$("#itemCdTd").append(str);
			 
			 $inputTd = $("<td id='itemNameTd'></td>");
				$("#itemNameTr").append($inputTd);
				 str =  '<input type="text" id="itemName" name="itemName"  disabled="disabled" >'
						$("#itemNameTd").append(str);
				 
				 $inputTd = $("<td id='madeNameTd'></td>");
					$("#madeNameTh").after($inputTd);
					 str =  '<input type="text" id="madeName" name="madeName"  disabled="disabled" >'
							$("#madeNameTd").append(str);
					 
					 $inputTd = $("<td id='unitNameTd'></td>");
						$("#unitNameTh").after($inputTd);
						 str =  '<input type="text" id="unitName" name="unitName"  disabled="disabled" >'
								$("#unitNameTd").append(str);
						 
						 $inputTd = $("<td id='wareCountTd'></td>");
							$("#wareCountTh").after($inputTd);
							 str =  '<input type="text" id="wareCount" name="wareCount"  disabled="disabled" >'
									$("#wareCountTd").append(str);

							 $inputTd = $("<td id='insItemListCdTd'></td>");
								$("#insItemListCdTr").append($inputTd);
								 str =  '<input type="hidden" id="insItemListCd" name="insItemListCd" disabled="disabled" >'
										$("#insItemListCdTd").append(str);
							 
							 $inputTd = $("<td id='updateBtnTd'></td>");
								$("#buttonTr").append($inputTd);
								 str =  '<button type="button" id="view_update" onclick="fn_update();" >'+'수정'+
								 			'</button>'
										$("#updateBtnTd").append(str);
								 			
								 $inputTd = $("<td id='saveBtnTd'></td>");
									$("#buttonTr").append($inputTd);
									 str =  '<button type="button" id="baseBtn" onclick="db_save();" >'+'저장b'+
									 			'</button>'
											$("#saveBtnTd").append(str);
		};
		
		//ajax로 뿌려준  금일 입고 리스트 테이블을 한줄 선택하는 방법 ajax로 새로 생긴 테이블이라 .on을 사용한다.
	 	$(document).on('click', '#wareTbody tr', function(){
		 	var tr = $(this);
		 	console.log("클릭한 줄 "+tr.text());
		 	var itemCd = $(this).find('#itemCdWare').text();
// 		 	console.log("클릭한 줄 상품코드 "+itemCd);
// 		 	console.log("클릭한 줄 제조사 코드 "+madeNmCd);
			
			// input 아래 값 초기화
			fn_inputRemove();
			
		//  itemCd 를 ajax로 값 넘겨서 데이터값 가져와서 뿌리기
		 	fn_wareView(itemCd);
		 	});
		
	//  itemCd 를 ajax로 값 넘겨서 데이터값 가져와서 뿌리기
	function fn_wareView(itemCd){
			var itemPar = {"itemCd" : itemCd};
			$.ajax({
					type : "POST",
					url : "/kyu/wareView.do",
					data : JSON.stringify(itemPar),
					contentType : "application/json",
					success : function(wareView){
// 							console.log("ajax를 통해서 한줄의 데이터를 가져온다"+itemView);
							$("input[name=itemCd]").attr("disabled", true);
							console.log("itemCd "+wareView.ITEMCD);
							$("#itemCd").val(wareView.ITEMCD);
							$("#itemName").val(wareView.ITEMNAME);
							$("#madeName").val(wareView.MADENAME);
							$("#unitName").val(wareView.UNITNAME);
							$("#wareCount").val(wareView.INSAMT);
							$("#insItemListCd").val(wareView.INSITEMLISTCD);
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				
				});
		};
</script>
</head>
<body>
<h2>전체리스트</h2>
<form id="cagoForm" name="cagoForm" method="post" >
	<label>카테고리:</label>
	<select id="cago">
		<option value="">전자제품</option>
	</select>
	<label>1차분류:</label>
	<select id="cago1">
		<option value="">하위분류</option>
	</select>
	<input type="hidden" id="inpuCago" name="inpuCago" >
	<input type="button" id="cagoCheck" onclick="db_cagoList(); db_wareList();" value="조회" >
</form>

<!-- <div class="container" id="ajaxDiv"> -->
<!-- <div id="con"> -->
<c:if test="${not empty msg}">
	<p>${msg}</p>
</c:if>
<table class="table" id="allList">
	<colgroup>
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
	</colgroup>
    <thead>
        <tr>
            <th >상품코드</th>
            <th >상품명</th>
            <th >제조사코드</th>
            <th >제조사명</th>
            <th >단위코드</th>
            <th >단위명</th>
            <th >재고수량</th>
            <th >재고여부</th>
            <th >사용여부</th>
        </tr>
    </thead>
<!--                         fn -> 접두어 (prefix) 위에 prefix="fn" -->
<!--                                                var ->  for문 내부에서 사용할 변수 -->
    <tbody id="ajaxList">
        <c:choose>
            <c:when test="${fn:length(itemList) > 0}">
                <c:forEach items="${itemList }" var="row">
                
                    <tr >
                   
                        <td id="tdItemCd"><span class="itemCd">${row.ITEMCD }</span></td>
                        <td>${row.ITEMNAME }</td>
                        <td>${row.MADENMCD }</td>
                        <td>${row.MADENAME }</td>
                        <td>${row.ITEMUNITCD }</td>
                        <td>${row.UNITNAME }</td>
                        <td>${row.STOCKAMT }</td>
                        <td>
                        <c:if test="${row.STOCKYN eq 'Y' }">
                        <input type="checkbox" name="stockAmt" id="stockAmt" checked="checked">
                        </c:if>
                        <c:if test="${row.STOCKYN eq 'N' }">
                        <input type="checkbox" name="stockAmt" id="stockAmt" >
                        </c:if>
                        </td>
                        <td>
                        <c:if test="${row.USEYN eq 'Y' }">
                        <input type="checkbox" name="useYn" id="useYn" checked="checked">
                        </c:if>
                        <c:if test="${row.USEYN eq 'N' }">
                        <input type="checkbox" name="useYn" id="useYn" >
                        </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
<!--                     <td colspan="4">조회된 결과가 없습니다.</td> -->
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

<h2>금일 입고리스트</h2>
<table class="table" id="wareHouse">
	<colgroup>
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
	</colgroup>
    <thead>
        <tr>
            <th >상품코드</th>
            <th >상품명</th>
            <th >제조사코드</th>
            <th >제조사명</th>
            <th >단위코드</th>
            <th >단위명</th>
            <th >입고수량</th>
        </tr>
    </thead>
<!--                         fn -> 접두어 (prefix) 위에 prefix="fn" -->
<!--                                                var ->  for문 내부에서 사용할 변수 -->
    <tbody id="ajaxList">
        <c:choose>
            <c:when test="${fn:length(itemList) > 0}">
                <c:forEach items="${itemList }" var="row">
                
                    <tr >
                   
                        <td id="tdItemCd"><span class="itemCd">${row.ITEMCD }</span></td>
                        <td>${row.ITEMNAME }</td>
                        <td>${row.MADENMCD }</td>
                        <td>${row.MADENAME }</td>
                        <td>${row.ITEMUNITCD }</td>
                        <td>${row.UNITNAME }</td>
                        <td>${row.STOCKAMT }</td>
                        <td>
                        <c:if test="${row.STOCKYN eq 'Y' }">
                        <input type="checkbox" name="stockAmt" id="stockAmt" checked="checked">
                        </c:if>
                        <c:if test="${row.STOCKYN eq 'N' }">
                        <input type="checkbox" name="stockAmt" id="stockAmt" >
                        </c:if>
                        </td>
                        <td>
                        <c:if test="${row.USEYN eq 'Y' }">
                        <input type="checkbox" name="useYn" id="useYn" checked="checked">
                        </c:if>
                        <c:if test="${row.USEYN eq 'N' }">
                        <input type="checkbox" name="useYn" id="useYn" >
                        </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
<!--                     <td colspan="4">조회된 결과가 없습니다.</td> -->
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
<!-- </div>  -->
<!-- </div> -->

<!-- <div class="container"> -->
<!-- <div id="changeDiv"> -->
<form id="iForm" name="iForm" method="post"  >
<table class="table" id="inputTable">
	<tr>
		<th>입고내용</th>
	</tr>
	<tr id="itemCdTr">
		<th>상품코드:</th>
		<td>
			<input type="text" id="itemCd" name="itemCd"  disabled="disabled" >
		</td>
	</tr>
	<tr id="itemNameTr">
		<th>상품명:</th>
		<td>
			<input type="text" id="itemName" name="itemName" disabled="disabled"  >
		</td>
	</tr>
	<tr >
		<th id="madeNameTh">제조사:</th>
		<td>
			<input type="text" id="madeName" name="madeName" disabled="disabled">
		</td>
		<th id="unitNameTh">단위명:</th>
		<td>
			<input type="text" id="unitName" name="unitName" disabled="disabled">
		</td>
	</tr>
	<tr>
		<th id="wareCountTh">
		 	입고수량 : 
		</th>
		<td>
			<input type="text" name="wareCount" id="wareCount" disabled="disabled">
		</td>
	</tr>
	<tr id="insItemListCdTr">
		<td>
			<input type="hidden" id="insItemListCd" name="insItemListCd"  disabled="disabled">
		</td>
	</tr>	
	<tr id="buttonTr">
		<td>
			<button type="button" id="view_update" onclick="fn_update();">수정</button>
		</td>
		<td>
			<button type="button" id="baseBtn" onclick="db_save();">저장b</button>
		</td>
	</tr>
</table>
</form>
<!-- </div> -->
<!-- </div> -->

</body>
</html>