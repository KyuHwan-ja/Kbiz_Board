<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<link rel="shortcut icon" href="#">
<head>
<%-- <%@ include file="/WEB-INF/include/include-header.jsp" %> --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>

<script type="text/javascript">
function submitCheck(){
// 	alert("submitCheck()함수뜨나경고");
	if(formJoin.id.value==""){
		alert("아이디를 입력해 주세요");
		formJoin.id.focus();
		return false;
	}
	else if(formJoin.pass.value==""){
		alert("비밀번호를 입력해 주세요");
		formJoin.pass.focus();
		return false;
	}
	else if(formJoin.passCheck.value==""){
		alert("비밀번호 확인을 입력해 주세요");
		formJoin.passCheck.focus();
		return false;
	}
	else if(formJoin.pass.value!=formJoin.passCheck.value){
		alert("비밀번호가 일치 하지 않습니다.");
		formJoin.passCheck.focus();
		return false;
	}
	else if(formJoin.name.value==""){
		alert("성명을 입력해 주세요");
		formJoin.name.focus();
		return false;
	}
	else if( !$("#id").attr("disabled") ){
		alert("아이디 중복 체크를 해주세요");
		return false;
	}
// 	alert("여기는 나오나");
	$("input[name=id]").attr("disabled", false);
// 	alert("여기는 나오나22222");
};

	$(document).ready(function(){
// 		var isClicked = false;

// idChekcBtn 중복확인 버튼
// 	$("#idCheckBtn").unbind("click").click(function(e){
		$("#idCheckBtn").click(function(e){		
// 		고유 동작을 중단
// 		e.preventDefault();

// ajax 로 아이디 중복확인 		
		fn_idCheck();
	});
	
// 		사용자가 키보드를 누른다.
// 		keydown 이벤트가 발생한다.
// 		글자가 입력된다.
// 		keypress 이벤트가 발생한다.
// 		사용자가 키보드에서 손을 뗀다.
// 		keyup 이벤트가 발생한다.
	$("#passCheck").keyup(function(){
		if($("#pass").val() != $("#passCheck").val()){
			
			//.html()은 선택한 요소 안의 내용을 가져오거나, 다른 내용으로 바꿉니다. .text()와 비슷하지만 태그의 처리가 다릅니다.
			$("#checkNotice").html("비밀번호 일치하지 않습니다<br><br>");
			
			//.attr()은 요소(element)의 속성(attribute)의 값을 가져오거나 속성을 추가합니다.
			$("#checkNotice").attr("color", "#f82a2aa3");
			
		}else{
			$("#checkNotice").html("비밀번호가 일치합니다<br><br>");
			$("#chekcNotice").attr("color", "#199894b3");
		}
	});
	
	});

	// ajax 로 아이디 중복확인 		
	function fn_idCheck(){
		
		//.val()은 양식(form)의 값을 가져오거나 값을 설정하는 메소드입니다.
		var id=$("#id").val();
		var userData={"id":id}
	
	//.length는 문자열의 길이를 반환하는 속성입니다.
	if(id.length<1){
		alert("아이디를 입력해주시기 바랍니다.")
	}
	else
		{
		$.ajax({
			 // HTTP 요청 방식(GET, POST)
			type : "POST",
			
			// 클라이언트가 요청을 보낼 서버의 URL 주소
			url : "/kyu/idCheck.do", 
			
			//JSON.stringify – 객체를 JSON으로 바꿔줍니다.
			 // HTTP 요청과 함께 서버로 보낼 데이터
			data : JSON.stringify(userData),
			
			//서버로 데이터를 보낼 때이 컨텐츠 유형을 사용
			contentType : "application/json",
			error : function(request,status,error){
				alert("아이디 중복확인 에러"+"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			},
			success : function(result){
				if(result==0){
					$("#id").attr("disabled", true);
					alert("사용이 가능한 아이디 입니다.");
					
				}
				else if(result==1){
					alert("이미 존재하는 아이디 입니다. \n 다른 아이디를 사용해 주세요");
					$("#id").val("");
					
				}
				else{
					alert("에러가 발생하였습니다.");
				}
			}
		});
		}
	}
	
</script>
</head>
<body>
<form name="formJoin" id="formJoin" onsubmit="return submitCheck();"  method="post" action="join.do" >
	<table>
		<tr>
			<th>아이디:</th>
			<td>
				<input type="text" id="id" name="id" >
			</td>
			<td>
<!-- 				<a href="#" id="idCheckBtn" class="btn">중복확인</a> -->
				<input type="button" value="중복확인" id="idCheckBtn" name="idCheckBtn" >
				<input type="hidden" id="isClicked" name="isClicked" > 
			</td>
		</tr>
		<tr>
			<th>비밀번호:</th>
			<td>
				<input type="password" id="pass" name="pass"  pattern="[a-zA-Z0-9]{5,10}" title="영문&숫자 5~10 자리 이어야 합니다">
			</td>
		</tr>
		<tr>
			<th>비밀번호 확인:</th>
			<td>
				<input type="password" id="passCheck" name="passCheck"  pattern="[a-zA-Z0-9]{5,10}" title="영문&숫자 5~10 자리 이어야 합니다" >
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<font id="checkNotice" size="2"></font>
			</td>
		</tr>
		<tr>
			<th>성명:</th>
			<td>
				<input type="text" id="name" name="name" >
			</td>
		</tr>
		<tr>
			<td>
<!-- 				<a href="#" class="btn" id="joinSave" >저장</a> -->
<!-- 				<input type="button"  value="저장" > -->
				<button class="btn btn-default" type="submit">저장</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>