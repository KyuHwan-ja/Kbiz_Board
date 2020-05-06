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
#clickRow:hover tbody tr:hover td{
	background: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#db_insert").hide();
		$("#db_update").hide();
		$("#view_update").hide();
		$("#view_insert").hide();
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
				console.log(JSON.stringify(result.underCago));
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
	
	// 조회 버튼 시 리스트 가져오기 
	// 그냥 폼으로 옵션 선택한 데이터 넘기고 싶으면 input hidden 을 하나 만들어서  옵션 선택된 값을 input hidden 에 넣고 form 을 서밋해 주면 값이 넘어간다.
// 	function db_cagoList(){
// 		var langSelect = document.getElementById("cago1");
// 		var cdNo = langSelect.options[langSelect.selectedIndex].value;
// // 		document.getElementById("inpuCago").valuecdNo;
// // 		console.log("AAAAAAA"+document.getElementById("inpuCago").value);
// 		$("input[name=inpuCago]").attr('value', cdNo);
// 		console.log("AAAAAAA"+$("#inpuCago").val());
// 		document.cagoForm.action="noAjaxItemList.do";
// 		document.cagoForm.submit();
// 	}
	
		// 조회 버튼 시 리스트 가져오기  테이블 쪽을 리셋하고 다시 컬럼명과 데이터를 넣어주는 방식
	function db_cagoList(cdNo){
		var langSelect = document.getElementById("cago1");
		var cdNo = langSelect.options[langSelect.selectedIndex].value;
		var underparam={"cdNo":cdNo};
		//  1차분류의 값  cdno를  itemClsCd 값을 넣어준다. 
		$("input[name=itemClsCd]").attr('value', cdNo);
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
				$("#clickRow").append($newTbody);
				
				var arr = new Array();
				var arr=result.cagoList;
// 				console.log("arr"+arr);
				for(i=0, j=0; i<arr.length,j<arr.length; i++,j++){
					     str =  '<tr>'+'<td id="itemCdAjax">' + arr[i].ITEMCD + '</td>'+
						        '<td>' + arr[i].ITEMNAME + '</td>'+
						  		'<td id="madeNmCdAjax">' + arr[i].MADENMCD + '</td>'+
						  		'<td>' + arr[i].MADENAME + '</td>'+
						  		'<td id="unitNmCdAjax">' + arr[i].ITEMUNITCD + '</td>'+
						  		'<td>' + arr[i].UNITNAME + '</td>'+
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

	//ajax로 뿌려준 테이블을 한줄 선택하는 방법 ajax로 새로 생긴 테이블이라 .on을 사용한다.
	 	$(document).on('click', '#newTbody tr', function(){
		 	var tr = $(this);
		 	console.log("클릭한 줄 "+tr.text());
		 	var itemCd = $(this).find('#itemCdAjax').text();
		 	var madeNmCd = $(this).find('#madeNmCdAjax').text();
		 	var unitNmCd = $(this).find('#unitNmCdAjax').text();
// 		 	console.log("클릭한 줄 상품코드 "+itemCd);
// 		 	console.log("클릭한 줄 제조사 코드 "+madeNmCd);

			//  itemCd 를 ajax로 값 넘겨서 데이터값 가져와서 뿌리기
		 	fn_itemView(itemCd);
			
		 	// 테이블 한줄 클릭시 ajax로 제조사 selectbox option 가져오기 
		 	fn_madeName(madeNmCd);
		 	
		 	// 테이블 한줄 클릭시 ajax로 제조사 selectbox option 가져오기 
		 	fn_unitName(unitNmCd);
		 	$("#view_update").show();
		 	$("#view_insert").show();
			$("#db_insert").hide();
		 	
	 		// 자바스크립트 바로  input 값에 넣기
// 			$("#test12").val(itemCd);
			
	 	});
	
	// 테이블 한줄 클릭시 ajax로 제조사 selectbox option 가져오기 
	function fn_madeName(madeNmCd){
		var madeNmPar = {"madeNmCd" : madeNmCd};
		$.ajax({
			type:"POST",
			url:"/kyu/madeNameCago.do",
			data:JSON.stringify(madeNmPar),
			contentType:"application/json",
			dataType:"json",
			success:function(result){
// 				alert("123213");
// 				console.log(JSON.stringify(result.madeNameCago));
				$("select#madeNameCago option").remove();
// 				$("#madeNameCago").append("<option value=''>"+'하위분류'+"</option>");
				for(var i=0; i<result.madeNameCago.length; i++){
					$("#madeNameCago").append("<option value='"+result.madeNameCago[i]["CDNO"]+"'>"+result.madeNameCago[i]["CDNAME"]+"</option>");
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	};
	
	// ajax로 뿌린 리스트 한줄 클릭시 단위명 옵션 박스 가져오기
	function fn_unitName(unitNmCd){
		var unitNmPar = {"unitNmCd" : unitNmCd};
		$.ajax({
			type:"POST",
			url:"/kyu/unitNameCago.do",
			data:JSON.stringify(unitNmPar),
			contentType:"application/json",
			dataType:"json",
			success:function(result){
// 				alert("123213");
				console.log(JSON.stringify(result.unitNameCago));
				$("select#unitNameCago option").remove();
// 				$("#madeNameCago").append("<option value=''>"+'하위분류'+"</option>");
				for(var i=0; i<result.unitNameCago.length; i++){
					$("#unitNameCago").append("<option value='"+result.unitNameCago[i]["CDNO"]+"'>"+result.unitNameCago[i]["CDNAME"]+"</option>");
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	};
	
	//  itemCd 를 ajax로 값 넘겨서 데이터값 가져와서 뿌리기
	function fn_itemView(itemCd){
			var itemPar = {"itemCd" : itemCd};

			$.ajax({
					type : "POST",
					url : "/kyu/itemView.do",
					data : JSON.stringify(itemPar),
					contentType : "application/json",
					success : function(itemView){
							console.log("ajax를 통해서 한줄의 데이터를 가져온다"+itemView);
							$("input[name=itemCd]").attr("disabled", true);
							$("input[name=itemName]").attr("disabled", true);
							$("input[name=madeName]").attr("disabled", true);
							$("input[name=unitName]").attr("disabled", true);
							$("input[name=useYN]").attr("disabled", true);
							console.log("itemCd "+itemView.ITEMCD);
							$("#itemCd").val(itemView.ITEMCD);
							$("#itemName").val(itemView.ITEMNAME);
// 							$("#madeNameCago").append("<option value=''>"++"</option>");
// 							$("#madeName").val(itemView.MADENAME);
// 							$("#unitName").val(itemView.UNITNAME);
							if(itemView.USEYN=='Y'){
								$("input:checkbox[name=useYN]").attr("checked", true).parent().addClass('on');
							} else{
								$("input:checkbox[name=useYN]").attr("checked", false).parent().addClass('off');
							}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				
				});
		};
		
		// 수정버튼 클릭시 데이터 사용여부 설정 
		function fn_update(){
			$("input[name=itemName]").attr("disabled", false);
			$("select[id=madeNameCago]").attr("disabled", false);
			$("select[id=unitNameCago]").attr("disabled", false);
			$("input[name=useYN]").attr("disabled", false);
// 			$("input[id=updateBtn]").attr("value", '저장u');
// 			$("input[id=updateBtn]").attr("onclick", "db_update();");
			$("#db_insert").hide();
			$("#baseBtn").hide();
			$("#db_update").show();
		};

		// 데이터 수정 후 저장 버튼 클릭시 업데이트 과정
		function db_updateItem(){
			var itemName = document.iForm.itemName;
			var langSelect = document.getElementById("madeNameCago");
			var madeNmCd = langSelect.options[langSelect.selectedIndex].value;
			console.log("제조사옵션"+document.getElementById("madeNameCago").value);
			var langSelect2 = document.getElementById("unitNameCago");
			var unitNmCd = langSelect2.options[langSelect2.selectedIndex].value;
			console.log("단위명옵션"+document.getElementById("unitNameCago").value);
			
			if(itemName.value==''){
				alert("상품이름을 입력하세요");
				document.iForm.itemName.focus();
				return false;
			}
			$("input[name=itemCd]").attr("disabled", false);
			$("input[name=madeNameInput]").attr('value', madeNmCd);
			$("input[name=unitNameInput]").attr('value', unitNmCd);
			document.iForm.action="itemUpdate.do";
			document.iForm.submit();
//	 		alert("마지막 서밋");
		};
		
		// 추가 버튼 클릭시 데이터 사용여부 설정 
		function fn_insert(){
			$("input[name=itemName]").attr("disabled", false);
			$("select[id=madeNameCago]").attr("disabled", false);
			$("select[id=unitNameCago]").attr("disabled", false);
			$("input[name=itemClsCd]").attr("disabled", false);
			$("input[name=useYN]").attr("disabled", false);
// 			$("input[id=updateBtn]").attr("value", '저장u');
// 			$("input[id=updateBtn]").attr("onclick", "db_update();");
			$("#db_insert").show();
			$("#baseBtn").hide();
			$("#db_update").hide();
		};

		// 데이터 추가 후 저장 버튼 클릭시 insert 과정
		function db_insertItem(){
			var itemName = document.iForm.itemName;
			var langSelect = document.getElementById("madeNameCago");
			var madeNmCd = langSelect.options[langSelect.selectedIndex].value;
			console.log("제조사옵션"+document.getElementById("madeNameCago").value);
			var langSelect2 = document.getElementById("unitNameCago");
			var unitNmCd = langSelect2.options[langSelect2.selectedIndex].value;
			console.log("단위명옵션"+document.getElementById("unitNameCago").value);
			
			if(itemName.value==''){
				alert("상품이름을 입력하세요");
				document.iForm.itemName.focus();
				return false;
			}
			$("input[name=madeNameInput]").attr('value', madeNmCd);
			$("input[name=unitNameInput]").attr('value', unitNmCd);
			document.iForm.action="itemInsert.do";
			document.iForm.submit();
//	 		alert("마지막 서밋");
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
	<input type="button" id="cagoCheck" onclick="db_cagoList();" value="조회" >
</form>

<!-- <div class="container" id="ajaxDiv"> -->
<!-- <div id="con"> -->
<c:if test="${not empty msg}">
	<p>${msg}</p>
</c:if>
<table class="table" id="clickRow">
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
<!-- </div>  -->
<!-- </div> -->

<!-- <div class="container"> -->
<!-- <div id="changeDiv"> -->
<form id="iForm" name="iForm" method="post"  >
<table class="table" id="inputTable">
	<tr>
		<th>코드내용</th>
	</tr>
	<tr>
		<th>상품코드:</th>
		<td>
			<input type="text" id="itemCd" name="itemCd" value="" disabled="disabled" >
<!-- 			위에서 자바스크립트 바로 인풋값 넣은 위치 -->
<!-- 			<input type="text" id="test12" name="test12">			 -->
		</td>
	</tr>
	<tr>
		<th>상품명:</th>
		<td>
			<input type="text" id="itemName" name="itemName" value="" disabled="disabled" >
		</td>
	</tr>
	<tr>
		<th>제조사:</th>
		<td>
			<select id="madeNameCago" name="madeNameCago" disabled="disabled" >
				<option value="">테스트제조사</option>
			</select>
			<input type="hidden" id="madeNameInput" name="madeNameInput" >
		</td>
		<th>단위명:</th>
		<td>
			<select id="unitNameCago" name="unitNameCago" disabled="disabled">
				<option value="">단위명</option>
			</select>
			<input type="hidden" id="unitNameInput" name="unitNameInput" >
		</td>
	</tr>
	<tr>
		<th>
		 	사용여부 : 
		</th>
		<td>
			<input type="checkbox" name="useYN" id="useYN" checked="checked"/>사용
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" id="itemClsCd" name="itemClsCd" disabled="disabled" >
		</td>
	</tr>	
	<tr>
		<td>
			<button type="button" id="view_insert" onclick="fn_insert();">추가</button>
		</td>
		<td>
			<button type="button" id="view_update" onclick="fn_update();">수정</button>
		</td>
		<td>
			<button type="button" id="baseBtn">저장b</button>
		</td>
		<td>
			<input type="button" id="db_update" onclick="db_updateItem();" value="저장u">
		</td>
		<td>
			<input type="button" id="db_insert" onclick="db_insertItem();" value="저장a">
		</td>
	</tr>
</table>
</form>
<!-- </div> -->
<!-- </div> -->

</body>
</html>