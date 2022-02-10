<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />
	
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script>
	// 사용자 신고 modal에 띄울 내용 담기
	$(document).ready(function() {
		$(".modal").css({"display": "none"});
		
		$("#reportUserDetailModal").on('show.bs.modal', function(event) {
			var reporter = $(event.relatedTarget).data('reporter');
			var reportee = $(event.relatedTarget).data('reportee');
			var reason = $(event.relatedTarget).data('reason');
			var detail = $(event.relatedTarget).data('detail');
			
			$(".modal-body #reporter").val(reporter);
			$(".modal-body #reportee").val(reportee);
			$(".modal-body #reason").val(reason);
			$(".modal-body #detail").val(detail);
		});
		
	});
	// textarea 높이 조절
	function adjustHeight() {
	  var textEle = $('textarea');
	  textEle[0].style.height = 'auto';
	  var textEleHeight = textEle.prop('scrollHeight');
	  textEle.css('height', textEleHeight);
	};
</script>
<style>
.selectReport:hover {
	cursor: pointer;
	background: #f7fff6;
}
.modal-body p {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 30px;
}
.modal-body input {
	border: none;
}
textarea {
	border: none;
	resize: none;
}
</style>

<div class="container member-profile">
	<div class="container mb-100 mt-100">
		<div class="row mb-50">
			<div class="col-2">
				<div class="profile-work">
					<a href="${pageContext.request.contextPath}/member/mypageMain.do"><p>마이페이지HOME</p></a>
					<a href="${pageContext.request.contextPath}/member/editProfile.do">정보수정</a><br />
					<p>북토리 관리</p>
					<a href="">결제 내역</a><br /> <a href="">거래 내역</a><br /> <a href="">북토리충전</a>
					<p>나의 게시글</p>
					<a href="">게시글 작성목록</a><br /> <a href="">리뷰 작성목록</a><br />
					<p>1:1 문의</p>
					<a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1문의하기</a><br />
					<a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1문의내역</a><br />
					<p>신고내역</p>
					<a href="${pageContext.request.contextPath}/report/reportUserList.do">사용자 신고목록</a><br />
					<a href="${pageContext.request.contextPath}/report/reportBoardList.do">게시글 신고목록</a><br />
				</div>
			</div>
			<div class="col-lg-8 col-md-10 ml-auto mr-auto">
				<div class="section-heading text-center">
					<h5>사용자 신고 목록</h5>
				</div>
				<input type="button" value="사용자 신고" id="btn-add" class="btn btn-outline-success float-right mb-30"
					data-toggle="modal" data-target="#reportUserEnrollModal"/>
				<div class="table-responsive">
					<table class="table text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>신고자ID</th>
								<th>신고대상ID</th>
								<th>사유</th>
								<th>신고일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${reportUserList}" var="reportUserList">
								<tr class="selectReport"
									data-toggle="modal"
									data-target="#reportUserDetailModal"
									data-no="${reportUserList.no}"
									data-reporter="${reportUserList.reporter}"
									data-reportee="${reportUserList.reportee}"
									data-reason="${reportUserList.reason}"
									data-detail="${reportUserList.detail}">
									<c:if test="${reportUserList ne null}">
									<td>${reportUserList.no}</td>
									<td>${reportUserList.reporter}</td>
									<td>${reportUserList.reportee}</td>
									<td>${reportUserList.reason}</td>
									<td><fmt:formatDate value="${reportUserList.regDate}" pattern="yyyy/MM/dd" /></td>
									<td>
										<c:choose>
											<c:when test="${reportUserList.condition eq 0}">대기중</c:when>
											<c:when test="${reportUserList.condition eq 1}"><strong style="color: #7add4e;">승인</strong></c:when>
											<c:when test="${reportUserList.condition eq 2}"><strong style="color: red;">반려</strong></c:when>
										</c:choose>
									</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${empty reportUserList}">
								<tr>
									<td colspan="6"><p>신고하신 내역이 없습니다.</p></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					${pagebar}

					<!-- 사용자 신고 상세보기 Modal -->
					<div class="modal fade" id="reportUserDetailModal" tabindex="-1" 
						role="dialog" aria-labelledby="reportUserDetailModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="reportUserDetailModalLabel">신고 상세내용</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">×</span>
									</button>
								</div>
								<div class="modal-body">
									<div>
										<p>신고자ID</p>
										<input type="text" id="reporter" value="" />
									</div>
									<div>
										<p>신고대상ID</p>
										<input type="text" id="reportee" value="" />
									</div>
									<div>
										<p>사유</p>
										<input type="text" id="reason" value="" />
									</div>
									<div>
										<p style="transform: translate(0px, -30px);">상세내용</p>
										<textarea id="detail" cols="30" onkeyup="adjustHeight();"></textarea>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
