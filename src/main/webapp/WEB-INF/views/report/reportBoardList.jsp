<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script>
	// 게시글 신고 modal에 띄울 내용 담기
	$(document).ready(function() {
		$("#reportBoardDetailModal").on('show.bs.modal', function(event) {
			var reporter = $(event.relatedTarget).data('reporter');
			var boardName = $(event.relatedTarget).data('boardname');
			var boardNo = $(event.relatedTarget).data('boardno');
			var reason = $(event.relatedTarget).data('reason');
			var detail = $(event.relatedTarget).data('detail');
			
			$(".modal-body #reporter").val(reporter);
			$(".modal-body #boardName").val(boardName);
			$(".modal-body #boardNo").val(boardNo);
			$(".modal-body #reason").val(reason);
			$(".modal-body #detail").val(detail);
		});
	});
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
					<h5>게시글 신고 목록</h5>
				</div>
				<input type="button" value="게시글 신고" id="btn-add" class="btn btn-outline-success float-right mb-30"
					data-toggle="modal" data-target="#reportUserEnrollModal"/>
				<div class="table-responsive">
					<table class="table text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>신고자ID</th>
								<th>게시판NO</th>
								<th>사유</th>
								<th>신고일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${reportBoardList}" var="reportBoardList">
								<tr class="selectReport" 
									data-toggle="modal"
									data-target="#reportBoardDetailModal"
									data-no="${reportBoardList.no}"
									data-reporter="${reportBoardList.reporter}"
									data-boardname="${reportBoardList.boardName}"
									data-boardno="${reportBoardList.boardNo}"
									data-reason="${reportBoardList.reason}"
									data-detail="${reportBoardList.detail}">
									<td>${reportBoardList.no}</td>
									<td>${reportBoardList.reporter}</td>
									<td>${reportBoardList.boardName}-${reportBoardList.boardNo}</td>
									<td>${reportBoardList.reason}</td>
									<td><fmt:formatDate value="${reportBoardList.regDate}" pattern="yyyy/MM/dd" /></td>
									<td>
										<c:choose>
											<c:when test="${reportBoardList.condition eq 0}">대기중</c:when>
											<c:when test="${reportBoardList.condition eq 1}"><strong style="color: #7add4e;">승인</strong></c:when>
											<c:when test="${reportBoardList.condition eq 2}"><strong style="color: red;">반려</strong></c:when>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					${pagebar}
					
					<!-- 게시글 신고 상세보기 Modal -->
					<div class="modal fade" id="reportBoardDetailModal" tabindex="-1"
						role="dialog" aria-labelledby="#reportBoardDetailModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="#reportBoardDetailModalLabel">신고 상세내용</h5>
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
										<p>게시판</p>
										<input type="text" id="boardName" value="" />
									</div>
									<div>
										<p>게시글NO</p>
										<input type="text" id="boardNo" value="" />
									</div>
									<div>
										<p>사유</p>
										<input type="text" id="reason" value="" />
									</div>
									<div>
										<p>상세내용</p>
										<input type="text" id="detail" value="" />
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
