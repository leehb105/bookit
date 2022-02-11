<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminList.css"/>
<div class = "admin_container">


	<div class="member-profile">
	    	<form method="get" action="">

	                   <div class="profile-work">
	                       <a href="#"><p>회원목록</p></a>
	                       <b>통계</b><br />	
	 				 	   <a href="${pageContext.request.contextPath}/admin/chart/chart.do">-가입 회원</a><br />
	 				 	   <a href="${pageContext.request.contextPath}/admin/chart/addressChart.do">-회원 주소</a><br />
	 				 	   <a href="#">-리뷰 작성</a><br />
	 				 	   <a href="${pageContext.request.contextPath}/admin/chart/cashChart.do">-북토리 충전</a>
	                   </div>
			</form>           
	</div>
	
	<div class = "memberList_container">
		<table id="tbl-board" class="table table-striped table-hover">
			<tr>
				<th>아이디</th>
				<th>이메일</th>
				<th>닉네임</th>
				<th>이름</th>
				<th>핸드폰</th> 
				<th>가입날짜</th> 
				<th>권한</th>
			</tr>
			<c:forEach items="${memberList}" var="memberList">
				<tr>
					<td>${memberList.id}</td>
					<td>${memberList.email}</td>
					<td>${memberList.nickname}</td>
					<td>${memberList.name}</td>
					<td>${memberList.phone}</td>
					<td><fmt:formatDate value="${memberList.enrollDate}" pattern="yy/MM/dd HH:mm"/> </td>
					<td>
						<select id="authority">
							<option value="${memberList.authority}"/>					
						</select></td>
				</tr>
			</c:forEach>
	</table>
	${pagebar}
	
	</div>



</div>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>