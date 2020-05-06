<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="page" required="true" %>
<%@ attribute name="startPage" required="true" %>
<%@ attribute name="endPage" required="true" %>
<%@ attribute name="totalPage" required="true" %>
				<ul class="pagination">
				<!-- 맨 앞 페이지(1페이지)로 이동하는 아이콘 -->
				<li>
					<a href="codeList.do?page=1">
						<span class="glyphicon glyphicon-step-backward"></span>
					</a>
				</li>
				<!-- 이전 페이지로 이동 : 조건 : 1페이지보다 커야한다. -->
				<c:if test="${page > 1 }">
					<li title="이전 페이지">
						<a href="codeList.do?page=${page - 1 }">
							<span class="glyphicon glyphicon-chevron-left"></span>
						</a>
					</li>
				</c:if>
				<c:forEach begin="${startPage }" end="${endPage }" var="index">
				  <li ${(page == index)?" class=\"active\"":""}>
				  	<a href="codeList.do?page=${index }">${index }</a>
				  </li>
				 </c:forEach>
				 <!-- 다음 페이지로 이동 : 조건 : 현재 페이지가 totalPage보다 작아야 한다. -->
				<c:if test="${page < totalPage }">
					<li title="다음 페이지">
						<a href="codeList.do?page=${page + 1 }">
							<span class="glyphicon glyphicon-chevron-right"></span>
						</a>
					</li>
				</c:if>
				 
				<!-- 맨 뒷 페이지(전체 페이지)로 이동하는 아이콘 -->
				 <li>
					<a href="codeList.do?page=${totalPage }">
						<span class="glyphicon glyphicon-step-forward"></span>
					</a>
				 </li>
				</ul>
