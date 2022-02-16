<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/member/common/sidebar.jsp"/>

<script>
	// 게시글 신고 modal에 띄울 내용 담기
	$(document).ready(function() {
		$(".modal").css({"display": "none"});
		
		$("#reportBoardDetailModal").on('show.bs.modal', function(event) {
			var reporter = $(event.relatedTarget).data('reporter');
			var boardNameKor = $(event.relatedTarget).data('boardnamekor');
			var boardNo = $(event.relatedTarget).data('boardno');
			var reason = $(event.relatedTarget).data('reason');
			var detail = $(event.relatedTarget).data('detail');
			
			$(".modal-body #reporter").val(reporter);
			$(".modal-body #boardNameKor").val(boardNameKor);
			$(".modal-body #boardNo").val(boardNo);
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
	// 신고한 게시글로 이동
	$(() => {
		$(".btn-link[data-no]").click((e) => {
			const $td = $(e.target);
			const boardname = $td.data("boardname");
			const no = $td.data("no");
			console.log(boardname);
			console.log(no);
			location.href = `${pageContext.request.contextPath}/board/\${boardname}Content.do?no=\${no}`;
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
textarea {
	border: none;
	resize: none;
}
</style>
<!-- include header.jsp / sidebar.jsp -->
			<div class="col-lg-8 col-md-10 ml-auto mr-auto">
				<div class="section-heading text-center">
					<h5>게시글 신고 목록</h5>
				</div>
				<div class="table-responsive">
					<table class="table text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>게시판NO</th>
								<th>신고자ID</th>
								<th>사유</th>
								<th>신고일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${reportBoardList}" var="reportBoardList">
								<tr class="selectReport">
									<td>${reportBoardList.no}</td>
									<td class="btn-link" data-no="${reportBoardList.no}" data-boardname="${reportBoardList.boardName}">
										<c:if test="${reportBoardList.boardName eq 'community'}">커뮤니티-${reportBoardList.boardNo}</c:if>
										<c:if test="${reportBoardList.boardName eq 'used'}">중고거래-${reportBoardList.boardNo}</c:if>
										<c:if test="${reportBoardList.boardName eq 'request'}">도서요청-${reportBoardList.boardNo}</c:if>
									</td>
									<td>${reportBoardList.reporter}</td>
									<td data-toggle="modal"
										data-target="#reportBoardDetailModal"
										data-no="${reportBoardList.no}"
										data-reporter="${reportBoardList.reporter}"
										data-boardnamekor="<c:choose>
<c:when test="${reportBoardList.boardName eq 'community'}">커뮤니티</c:when>
<c:when test="${reportBoardList.boardName eq 'used'}">중고거래</c:when>
<c:when test="${reportBoardList.boardName eq 'request'}">도서요청</c:when>
</c:choose>"
										data-boardno="${reportBoardList.boardNo}"
										data-reason="${reportBoardList.reason}"
										data-detail="${reportBoardList.detail}">${reportBoardList.reason}
									</td>
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
							<c:if test="${empty reportBoardList}">
								<tr>
									<td colspan="6"><p>신고하신 내역이 없습니다.</p></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					${pagebar}
					
					<!-- 게시글 신고 상세보기 Modal -->
					<div class="modal fade" id="reportBoardDetailModal" tabindex="-1"
						role="dialog" aria-labelledby="reportBoardDetailModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="reportBoardDetailModalLabel">신고 상세내용</h5>
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
										<input type="text" id="boardNameKor" value="" />
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
