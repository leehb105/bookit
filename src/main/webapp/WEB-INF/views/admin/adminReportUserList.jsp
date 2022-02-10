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
	// 사용자 신고 처리 상태 변경 함수(함수 재사용. condition값, no값 넘겨주기)
	function reportUserUpdateCondition(condition) {
		var no = $("input[id=no]").val();
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
		f.setAttribute('action', '${pageContext.request.contextPath}/admin/reportUserUpdateCondition.do');
		document.body.appendChild(f);
		f.submit();
	};

	// 사용자 신고 modal에 띄울 내용 담기
	$(document).ready(function() {
		$(".modal").css({"display": "none"});
		$("#reportUserDetailModal").on('show.bs.modal', function(event) {
			var reporter = $(event.relatedTarget).data('reporter');
			var reportee = $(event.relatedTarget).data('reportee');
			var reason = $(event.relatedTarget).data('reason');
			var detail = $(event.relatedTarget).data('detail');
			var no = $(event.relatedTarget).data('no');

			$(".modal-body #reporter").val(reporter);
			$(".modal-body #reportee").val(reportee);
			$(".modal-body #reason").val(reason);
			$(".modal-body #detail").val(detail);
			$(".modal-body #no").val(no);
		});
	});
	
	// 회원 삭제
	function enableUser(){
		var reportee = $("input[id=reportee]").val();
		let f = document.createElement('form');

		let obj1 = document.createElement('input');
		obj1.setAttribute('type', 'hidden');
		obj1.setAttribute('name', 'reportee');
		obj1.setAttribute('value', reportee);
		
		csrf = document.createElement('input');
		csrf.setAttribute('type', 'hidden');
		csrf.setAttribute('name', '${_csrf.parameterName}');
		csrf.setAttribute('value', '${_csrf.token}');

		f.appendChild(obj1);
		f.appendChild(csrf);
		f.setAttribute('method', 'post');
		f.setAttribute('action', '${pageContext.request.contextPath}/admin/enableUser.do');
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
					<h5>사용자 신고 목록</h5>
				</div>
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
									<c:set var="condition" value="${reportUserList.condition}"/>
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
								</tr>
							</c:forEach>
						</tbody>
					</table>
					${pagebar}
					

					<!-- Modal -->
					<div class="modal fade" id="reportUserDetailModal" tabindex="-1"
						role="dialog" aria-labelledby="reportUserDetailModalLabel"
						aria-hidden="true">
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
									<input type="hidden" id="no" value="" />
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
									<button type="button" name="success" class="btn btn-success" onclick="reportUserUpdateCondition(1);">승인</button>
									<button type="button" name="danger" class="btn btn-danger" onclick="reportUserUpdateCondition(2);">반려</button>
									<button type="button" name="danger" class="btn btn-info" onclick="enableUser();">회원정지</button>
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
