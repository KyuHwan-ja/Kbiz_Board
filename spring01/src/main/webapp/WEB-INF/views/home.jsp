<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
		
		<input type="button" value="사원명부보기_list" id="emp_btn_1" onclick="location.href='./empList.do';">
		<br>
		<br>
		<input type="button" value="사원명부보기_param" id="emp_btn_3" onclick="location.href='./empListParam.do';">
		<br>
		<br>
		<input type="button" value="로그인" id="emp_btnLogin" onclick="location.href='./login.do';">
		<br>
		<br>
		<input type="button" value="코드관리" id="emp_btn_4" onclick="location.href='./codeList.do';">
		<br>
		<br>
		<input type="button" value="아이템 리스트" id="emp_btnLogin" onclick="location.href='./itemList.do';">
		<br>
		<br>
		<input type="button" value="아이템 수량" id="emp_btnLogin" onclick="location.href='./itemCount.do';">
		<br>
		<br>
		<input type="button" value="아이템 출고" id="emp_btnLogin" onclick="location.href='./itemOut.do';">
		<br>
		<br>
		<input type="button" value="아이템 출고 수정본" id="emp_btnLogin" onclick="location.href='./itemListCountOut.do';">
		
</body>
</html>
