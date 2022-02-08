<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script>
	// 게시글 신고 처리 상태 변경 함수(condition값, no값 넘겨주기)
	function reportBoardUpdateCondition(condition) {
		var no = $("input[id=no1]").val();
		let f = document.createElement('form');

		let obj1 = document.createElement('input');
		obj1.setAttribute('type', 'hidden');
		obj1.setAttribute('name', 'condition');
		obj1.setAttribute('value', condition);

		let obj2 = document.createElement('input');
		obj2.setAttribute('type', 'hidden');
		obj2.setAttribute('name', 'no');
		obj2.setAttribute('value', no);
		
		csrf = document.createElement('input');
		csrf.setAttribute('type', 'hidden');
		csrf.setAttribute('name', '${_csrf.parameterName}');
		csrf.setAttribute('value', '${_csrf.token}');

		f.appendChild(obj1);
		f.appendChild(obj2);
		f.appendChild(csrf);
		f.setAttribute('method', 'post');
		f.setAttribute('action', '${pageContext.request.contextPath}/admin/reportBoardUpdateCondition.do');
		document.body.appendChild(f);
		f.submit();
	};
	
	// 게시글 신고 modal에 띄울 내용 담기
	$(document).ready(function() {
		$(".modal").css({"display": "none"});
		$("#reportBoardDetailModal").on('show.bs.modal', function(event) {
			var reporter = $(event.relatedTarget).data('reporter');
			var boardName = $(event.relatedTarget).data('boardname');
			var boardNo = $(event.relatedTarget).data('boardno');
			var reason = $(event.relatedTarget).data('reason');
			var detail = $(event.relatedTarget).data('detail');
			var no = $(event.relatedTarget).data('no');
			
			$(".modal-body #reporter").val(reporter);
			$(".modal-body #boardName").val(boardName);
			$(".modal-body #boardNo").val(boardNo);
			$(".modal-body #reason").val(reason);
			$(".modal-body #detail").val(detail);
			$(".modal-body #no1").val(no);
		});
	});
	
	// 회원 삭제
	function deleteUser(){
		var reportee = $("input[id=reportee]").val();
		let f = document.createElement('form:form');

		let obj1 = document.createElement('input');
		obj1.setAttribute('type', 'hidden');
		obj1.setAttribute('name', 'reportee');
		obj1.setAttribute('value', reportee);

		f.appendChild(obj1);
		f.setAttribute('method', 'post');
		f.setAttribute('action', '${pageContext.request.contextPath}/admin/deleteUser.do');
		document.body.appendChild(f);
		f.submit();
	}
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
				<div class="profile-work text-center">
					<a href="#"><p>회원관리</p></a><br />
					<a href="${pageContext.request.contextPath}/admin/adminReportList.do"><p>신고접수</p></a><br />
					<a href="#"><p>회원통계</p></a><br />
					<a href="${pageContext.request.contextPath}/admin/adminInquireList.do"><p>회원문의</p></a>
				</div>
			</div>
			<div class="col-lg-8 col-md-10 ml-auto mr-auto">
				<div class="section-heading text-center">
					<h5>게시글 신고 목록</h5>
				</div>
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
								<td><a href="">${reportBoardList.boardName}-${reportBoardList.boardNo}</a></td>
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
									<p style="transform: translate(0px, -30px);">상세내용</p>
										<textarea id="detail" cols="30" onkeyup="adjustHeight();"></textarea>
								</div>
								<input type="hidden" id="no1" value="" />
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
								<button type="button" name="success" class="btn btn-success" onclick="reportBoardUpdateCondition(1);">승인</button>
								<button type="button" name="danger" class="btn btn-danger" onclick="reportBoardUpdateCondition(2);">반려</button>
								<button type="button" name="danger" class="btn btn-info" onclick="deleteUser();">회원정지</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
