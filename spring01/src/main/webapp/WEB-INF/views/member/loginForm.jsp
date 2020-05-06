<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 페이지</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){  
// 		alert("경고");
		$("#btnLogin").click(function(){
			var id = $("#id").val();
			var pass = $("#pass").val();
			
			if(id==""){
				alert("아이디를 입력하세요");
				$("#id").focus();
				return;
			}
			if(pass==""){
				alert("비밀번호를 입력하세요");
				$("#pass").focus();
				return;
			}
			document.form1.action="/kyu/loginCheck.do"
			document.form1.submit();
		});
	});
// 	$(function(){
// 		$("btnMemJoin").click(function(){
// 			alert("경고")
// 			document.form2.action="/kyu/join.do"
// 			document.form2.submit();
// 		});
// 	})
</script>
</head>
<body>
<h2>로그인</h2>
	<form name="form1" method="post">
		<table>
			<tr>
				<td>아이디 : </td>
				<td><input type="text" name="id" id="id"></td>
			</tr>
			<tr>
				<td>비밀번호 : </td>
				<td><input type="password" name="pass" id="pass"></td>
			</tr>
			<tr>
				<td>
					<button type="button" id="btnLogin">로그인</button>
				</td>
				<td>
					<a href="/kyu/joinForm.do"><button type="button" id="btnMemJoin">회원가입</button></a>
				</td>
			</tr>
			<tr>
				<c:if test="${msg == 'failure' }">
						<div style="color:red">
							아이디 또는 비밀번호가 일치하지 않습니다.
						</div>
					</c:if>
					
					<c:if test="${msg == 'logout' }">
						<div style="color:red">
							로그 아웃 되었습니다.
						</div>
					</c:if>
			</tr>
		</table>
		
	</form>
</body>
</html>