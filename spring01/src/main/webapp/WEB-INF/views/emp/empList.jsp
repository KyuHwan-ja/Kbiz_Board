<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>

</head>
<body>
<!--  사원 목록 페이지  -->
<h2>사원목록</h2>
<table style="border:1px solid #ccc">
    <colgroup>
        <col width="10%"/>
        <col width="*"/>
        <col width="*"/>
        <col width="*"/>
        <col width="*"/>
        <col width="*"/>
        <col width="*"/>
        <col width="*"/>
    </colgroup>
    <thead>
        <tr>
            <th scope="col">사원명</th>
            <th scope="col">판매량</th>
            <th scope="col">입사일</th>
            <th scope="col">사원번호</th>
            <th scope="col">MGR</th>
            <th scope="col">직종</th>
            <th scope="col">부서번호</th>
            <th scope="col">주급</th>
        </tr>
    </thead>
<!--                         fn -> 접두어 (prefix) 위에 prefix="fn" -->
<!--                                                var ->  for문 내부에서 사용할 변수 -->
    <tbody>
        <c:choose>
            <c:when test="${fn:length(empList) > 0}">
                <c:forEach items="${empList }" var="row">
                    <tr>
                        <td>${row.ENAME }</td>
                        <td>${row.COMM }</td>
                        <td>${row.HIREDATE }</td>
                        <td>${row.EMPNO }</td>
                        <td>${row.MGR }</td>
                        <td>${row.JOB }</td>
                        <td>${row.DEPTNO }</td>
                        <td>${row.SAL }</td>
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
</body>
</html>
