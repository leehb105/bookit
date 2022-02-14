<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container member-profile">
	<div class="container mb-100">
    	<div class="row mb-50">
			<div class="col-2">
				<div class="profile-work">
					<b><a href="${pageContext.request.contextPath}/admin/admin.do">회원관리</a></b>
					<p>신고</p>
					<a href="${pageContext.request.contextPath}/admin/adminReportUserList.do">사용자 신고목록</a><br />
					<a href="${pageContext.request.contextPath}/admin/adminReportBoardList.do">게시글 신고목록</a><br /><br />
					<p>문의</p>
					<a href="${pageContext.request.contextPath}/admin/adminInquireList.do">회원문의</a><br /><br />
	                <p>통계</p>	
	 				<a href="${pageContext.request.contextPath}/admin/chart/chart.do">가입 회원</a><br />
	 				<a href="${pageContext.request.contextPath}/admin/chart/cashChart.do">북토리 충전</a><br />
	 				<br />
	 				<b><a href="${pageContext.request.contextPath}/chat/chatMain.do">채팅 목록</a></b>
				</div>
			</div>
		<!-- </div>
	</div>
</div> -->