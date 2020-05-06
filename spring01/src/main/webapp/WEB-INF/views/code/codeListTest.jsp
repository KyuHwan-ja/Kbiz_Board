<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ut" tagdir="/WEB-INF/tags/" %>

<div class="container" id="bodyDiv">
<table class="table">
	<tr>
		<th>###########</th>
	</tr>
	<tr>
		<th>코드번호:</th>
		<td>
			<input type="text" id="cdNo" name="cdNo" value="" >
		</td>
	</tr>
	<tr>
		<th>코드레벨:</th>
		<td>
			<input type="text" id="cdLvl" name="cdLvl" value="" >
		</td>
	</tr>
	<tr>
		<th>상위코드:</th>
		<td>
			<input type="text" id="upCd" name="upCd" value="">
		</td>
	</tr>
	<tr>
		<th>코드이름:</th>
		<td>
			<input type="text" id="cdName" name="cdName" value="">
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
			<button type="button" onclick="location.href='' ">추가</button>
		</td>
		<td>
			<button type="button" onclick="location.href='' ">수정</button>
		</td>
		<td>
			<button type="button" onclick="location.href='' ">저장</button>
		</td>
	</tr>
</table>
</div>

</body>
