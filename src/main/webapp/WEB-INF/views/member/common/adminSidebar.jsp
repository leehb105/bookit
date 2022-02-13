<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container member-profile">
	<div class="container mb-100">
    	<div class="row mb-50">
			<div class="col-2">
				<div class="profile-work">
					<a href="#"><p>회원관리</p></a>
					<p>신고</p>
					<a href="${pageContext.request.contextPath}/admin/adminReportUserList.do">사용자 신고목록</a><br />
					<a href="${pageContext.request.contextPath}/admin/adminReportBoardList.do">게시글 신고목록</a><br /><br />
					<p>문의</p>
					<a href="${pageContext.request.contextPath}/admin/adminInquireList.do">회원문의</a><br /><br />
					<a href="#"><p>회원통계</p></a>
				</div>
			</div>
		<!-- </div>
	</div>
</div> -->