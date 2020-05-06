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
</style>
<script type="text/javascript">
$(document).ready(function(){
	//  id="addBtn" onclick="db_insert();" value="저장a" 
	$("#addBtn").hide();
	//  id="updateBtn" onclick="db_update();" value="저장u"
	$("#updateBtn").hide();
	//  id="update1" onclick="fn_update();"
	$("#update1").hide();
	//class="table" id="clickRow"
	$("#clickRow tr").click(function(){
		var str ="";
		var tdArr=new Array();
		// 현재 클릭된 row
		var tr=$(this);
		var td=tr.children();
		//해당 cdNo 가져오기
		var cdNo = $(this).find(".cdNo").text();
		//tr.text()는 클릭된 row 즉 tr에 있는 모든 값을 가져온다.
		console.log("클릭한 row의 모든 데이터 :"+tr.text());

		// 코드 리스트에서 한줄 선택시 그 데이터 아래에 뿌려주기 
		fn_cdNoAjax(cdNo);
		//fn_cdNoTest(cdNo);		
		
// 		location = "view.do?cdNo="+cdNo+"&page=${pageObject.page}";
		
		$("#update1").show();
		$("#addBtn").hide();
		});
});

	// 코드 리스트에서 한줄 선택시 그 데이터 아래에 뿌려주기 
	function fn_cdNoAjax(cdNo){
		var param = {"cdNo":cdNo};
		
		$.ajax({
			type : "POST",
			url : "/kyu/view.do",
			data : JSON.stringify(param), // json을 string으로 변환 시켜주는 함수
			contentType : "application/json",  // 서버에 데이터 보낼 때
			success : function(codeView){
				console.log(codeView);
				$("input[name=cdNo]").attr("disabled", true);
				$("input[name=cdLvl]").attr("disabled", true);
				$("input[name=upCd]").attr("disabled", true);
				$("input[name=cdName]").attr("disabled", true);
				$("input[name=useYN]").attr("disabled", true);
				$("#cdNo").val(codeView.CDNO);
				$("#cdLvl").val(codeView.CDLVL);
				$("#upCd").val(codeView.UPCD);
				$("#cdName").val(codeView.CDNAME);
				if(codeView.USEYN=='Y'){
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
		$("input[name=cdLvl]").attr("disabled", false);
		$("input[name=upCd]").attr("disabled", false);
		$("input[name=cdName]").attr("disabled", false);
		$("input[name=useYN]").attr("disabled", false);
		$("input[id=updateBtn]").attr("value", '저장u');
		$("input[id=updateBtn]").attr("onclick", "db_update();");
		$("#addBtn").hide();
		$("#baseBtn").hide();
		$("#updateBtn").show();
	};
	
	// 데이터 수정 후 저장 버튼 클릭시 업데이트 과정
	function db_update(){
		var cdLvl = document.cForm.cdLvl;
		var upCd = document.cForm.upCd.value;
		var cdName = document.cForm.cdName;
// 		var $cForm = $('<form>/<form>');
		const patt=/^([C]([0-9]{4}))$/;
// 		alert(upCd);
		console.log(upCd.match(patt));
		
		if(cdLvl.value==''){
			alert("코드레벨을 입력하세요");
			document.cForm.cdLvl.focus();
			return false;
		}
		else if((upCd.match(patt))==null){
			alert("상위코드를 C0000 형태에 맞게 입력해주세요");
			document.cForm.upCd.focus();
			return false;
		}
		else if(cdName.value==''){
			alert("코드이름을 입력하세요");
			document.cForm.cdName.focus();
			return false;
		}
		$("input[name=cdNo]").attr("disabled", false);
// 		$cForm.attr("action", "/kyu/codeUpdate.do");
// 		$("cForm").attr("action", "codeUpdate.do");
// 		$cForm.submit();
		document.cForm.action="codeUpdate.do";
		document.cForm.submit();
// 		alert("마지막 서밋");
	};
	
	// 추가버튼 클릭시 데이터 사용여부 설정 
	function fn_insert(){
		$("input[name=cdNo]").attr("disabled", false);
		$("#cForm").find('input').each(function(){
			this.value='';
		});
		$("input[id=addBtn]").attr("value", '저장a');
		$("input[name=cdNo]").attr("disabled", true);
		$("input[name=cdLvl]").attr("disabled", false);
		$("input[name=upCd]").attr("disabled", false);
		$("input[name=cdName]").attr("disabled", false);
		$("input[name=useYN]").attr("disabled", false);
		$("#addBtn").show();
		$("#baseBtn").hide();
		$("#updateBtn").hide();
	};
	
	// 추가 버튼후 저장 버튼 클릭시 db에 sumit 하기전
	function db_insert(){
		var cdLvl = document.cForm.cdLvl;
		var upCd = document.cForm.upCd.value;
		var cdName = document.cForm.cdName;
		const patt = /^([C]([0-9]{4}))$/;
		
		if($('input[name=useYN]').is(":checked")){
			$('input[name=YN]').val('on');
		}else{
			$('input[name=YN]').val('off');
		}
		console.log("체크박스 값"+$('input[name=YN]').val());
		
		if(cdLvl.value==''){
			alert("코드레벨을 입력하세요");
			document.cForm.cdLvl.focus();
			return false;
		}
		else if((upCd.match(patt))==null){
			alert("상위코드를 C0000 형태에 맞게 입력해 주세요")
			document.cForm.upCd.focus();
			return false;
		}
		else if(cdName.value==''){
			alert("코드이름을 입력하세요");
			document.cForm.cdName.focus();
			return false;
		}
		document.cForm.action="codeInsert.do";
		document.cForm.submit();
	};
	
	
	//에이작스를 이용해서 임의 html 구간 바꿔주기 미완성
// 	function fn_cdNoTest(_cdNo){
// 		var param = {"cdNo":_cdNo};
		
// 		$.ajax({
// 			type : "POST",
// 			url : "/kyu/view.do",
// 			data : JSON.stringify(param),
// 			contentType : "html",
// 			success : function(codeView){
// 				var result = "";

// 				result += '<table class="table" id="myTable">'
// 							+ '<tr><th>코드내용</th></tr>'
// 							+ '<tr>'
// 							+ '<th>코드번호:</th>'   			
// 							+ '<td><input type="text" id="cdNo" name="cdNo" value="'+codeView.CDNO+'"></td></tr>';

// 				$("#myTable").replaceWith(result);
// 			},
// 			error : function(request,status,error){
// 				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
// 			}
// 	 	});
// 	}
	
</script>  
</head>
<body>
<h2>전체리스트</h2>
<div class="container" >
<div class="row">
<table class="table" id="clickRow">
	<colgroup>
		<col width="20%" />
		<col width="20%" />
		<col width="20%" />
		<col width="20%" />
		<col width="20%" />
	</colgroup>
    <thead>
        <tr>
            <th >코드번호</th>
            <th >코드레벨</th>
            <th >상위코드</th>
            <th >코드이름</th>
            <th >사용여부</th>
        </tr>
    </thead>
<!--                         fn -> 접두어 (prefix) 위에 prefix="fn" -->
<!--                                                var ->  for문 내부에서 사용할 변수 -->
    <tbody>
        <c:choose>
            <c:when test="${fn:length(codeList) > 0}">
                <c:forEach items="${codeList }" var="row">
                
                    <tr>
                        <td><span class="cdNo">${row.CDNO }</span></td>
                        <td>${row.CDLVL }</td>
                        <td>${row.UPCD }</td>
                        <td>${row.CDNAME }</td>
                        <td>${row.USEYN }</td>
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
<form id="cForm" name="cForm" method="post"  >
<table class="table" id="myTable">
	<tr>
		<th>코드내용</th>
	</tr>
	<tr>
		<th>코드번호:</th>
		<td>
			<input type="text" id="cdNo" name="cdNo" value="" disabled="disabled">
		</td>
	</tr>
	<tr>
		<th>코드레벨:</th>
		<td>
			<input type="text" id="cdLvl" name="cdLvl" value="" disabled="disabled" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="0~9 를 입력해 주세요">
		</td>
	</tr>
	<tr>
		<th>상위코드:</th>
		<td>
			<input type="text" id="upCd" name="upCd" value="" disabled="disabled" >
<!-- 			<input type="text" id="upCd" name="upCd" value="" disabled="disabled" onKeyup="this.value=this.value.replace(/[^C[0-9]]/g,'');"> -->
<!-- 			<input type="text" id="upCd" name="upCd" value="" pattern="[0-9]{4,4}" title="C0000의 형식을 맞춰주세요" disabled="disabled"> -->
		</td>
	</tr>
	<tr>
		<th>코드이름:</th>
		<td>
			<input type="text" id="cdName" name="cdName" value="" disabled="disabled">
		</td>
	</tr>
	<tr>
		<th>
		 	사용여부 : 
		</th>
		<td>
			<input type="checkbox" name="useYN" id="useYN"  checked="checked"/>사용
		</td>
		<td>
			<input type="hidden" name="YN" id="YN"/>
		</td>
	</tr>
	<tr>
		<td>
			<button type="button" id="btn_insert" onclick="fn_insert();">추가</button>
		</td>
		<td>
			<button type="button" id="update1" onclick="fn_update();">수정</button>
		</td>
		<td>
			<button type="button" id="baseBtn">저장b</button>
		</td>
		<td>
			<input type="button" id="updateBtn" onclick="db_update();" value="저장u">
		</td>
		<td>
			<input type="button" id="addBtn" onclick="db_insert();" value="저장a">
		</td>
	</tr>
</table>
</form>
</div>
</div>

</body>
</html>
