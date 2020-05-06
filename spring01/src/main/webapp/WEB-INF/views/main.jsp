<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>main</title>
</head>
<body>
<h1>
	Hello world main!  
</h1>
<!-- 	session 영역의 Attribute에 바인딩 된 객체를 참조하는 Map객체 -->
	<c:choose>
		<c:when test="${sessionScope.id==null }">
			<a href="./login.do">로그인</a>
		</c:when>
		<c:otherwise>
			${sessionScope.id }님이 로그인중입니다.
			<a href="./logout.do">로그아웃</a>
		</c:otherwise>
	</c:choose>

<P>  The time on the server is ${serverTime}. </P>
		<c:if test="${msg=='success' }">
			<h2>(${sessionScope.id })님 환영홥니다.</h2>
		</c:if>
		
		<input type="button" value="사원명부보기_list" id="emp_btn_1" onclick="location.href='./empList.do';">
		<br>
		<input type="button" value="사원명부보기_param" id="emp_btn_3" onclick="location.href='./empListParam.do';">
		<br>
<!-- 		<input type="button" value="로그인" id="emp_btnLogin" onclick="location.href='./login.do';"> -->

</body>
</html>
