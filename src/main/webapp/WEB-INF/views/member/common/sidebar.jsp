<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />

	<jsp:include page="/WEB-INF/views/common/header.jsp" />


	<div class="container member-profile">
		<div class="row">
			<div class="col-2">
				<div class="profile-work">
					<a href="${pageContext.request.contextPath}/member/mypageMain.do">
						<p>마이페이지HOME</p>
					</a>
					<a href="${pageContext.request.contextPath}/member/editProfile.do">정보 수정</a><br />
					<p>북토리 관리</p>
					<a href="${pageContext.request.contextPath}/member/payments/history.do">결제 내역</a><br />
					<a href="${pageContext.request.contextPath}/member/trade/history.do">거래 내역</a><br />
					<a href="${pageContext.request.contextPath}/member/payments/charge.do">북토리 충전</a>
					<p>나의 게시글</p>
					<a href="${pageContext.request.contextPath}/member/myPosts.do">나의 게시글</a><br />
					<a href="${pageContext.request.contextPath}/member/bookReviewList.do?pageNum=1">도서 리뷰 작성목록</a><br />
					<a href="${pageContext.request.contextPath}/member/reviewList.do?pageNum=1">사용자 리뷰 작성목록</a><br />
					<p>1:1 문의</p>
					<a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1 문의하기</a><br />
					<a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1 문의내역</a><br />
					<p>신고내역</p>
					<a href="${pageContext.request.contextPath}/report/reportUserList.do">사용자 신고목록</a><br />
					<a href="${pageContext.request.contextPath}/report/reportBoardList.do">게시글 신고목록</a><br />
					<p><a href="${pageContext.request.contextPath}/chat/chatMain.do">채팅 목록</a></p>
				</div>
			</div>
			 <!--  
           </div>

	</div>
-->