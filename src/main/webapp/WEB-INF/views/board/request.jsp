<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
<style>
.requestImg h6{
	display: inline-block;
}
.requestImg img{
	border-radius: 50%;
	width: 40px;
}
textarea {
    resize: none;
}
.modal-body p {
    display: inline-block;
    width: 100px;
    text-align: right;
    margin-right: 30px;
}
</style>

<script>
$(document).ready(function() {
	// 신고대상ID 모달에 담기
	$("#reportUserEnrollModal").on('show.bs.modal', function(event) {
		var reportee = $(event.relatedTarget).data('reportee');
		$(".modal-body #reportee").val(reportee);
	});
	// 모달창 끄면 내용 초기화
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	});
});
function requestDelete(){
	var requestNo = $("input[id=requestNo]").val();
	$.ajax({
		url: `${pageContext.request.contextPath}/board/requestDelete.do`,
		method: "POST",
		data: {
			requestNo : requestNo
		},
		beforeSend : function(xhr){
			/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(res){
			if(res = 1){
				alert("삭제되었습니다.");
				location.replace(`${pageContext.request.contextPath}/board/request.do`);
			}
			else{
				alert("다시 시도해주세요.");
			}
		},
		error: console.log
	});
}
</script>

	<c:if test="${!empty loginMember}">
		<div class="button-area mt-40">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<button type="button" class="btn btn-outline-success w-10 float-right" onclick="location.href='requestForm.do'">요청서 작성</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	
    <div class="roberto-news-area section-padding-30-0">
        <div class="container">
            <div class="row ">
                <div class="col-12 col-lg-8">
                	<c:forEach items="${requestList}" var="requestList">
	                    <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="100ms">
	                        <div class="post-thumbnail">
                            	<img class="w-50" src="${requestList.cover}" alt="">
	                        </div>
	                        <div class="post-content">
	                            <h5 class="mb-4"><strong>${requestList.title}</strong></h5>
	                            <h6>저자 : ${requestList.author}</h6>
	                            <h6>출판사 : ${requestList.publisher}</h6>
	                            <h6>출판일 : <fmt:formatDate value="${requestList.pubdate}" pattern="yyyy.MM.dd"/></h6>
	                            <h6>희망 도서 상태 : ${requestList.bookCondition}</h6>
	                            <h6>희망 대여비 : <fmt:formatNumber value="${requestList.wishPrice}" pattern="#,###"/>원/일</h6>
	                        </div>
		                    <div class="post-content requestImg dropdown">
		                    	<img class="mr-2" src="${pageContext.request.contextPath}/resources/img/profile/${requestList.profileImage}"
		                    	onerror="this.src='${pageContext.request.contextPath}/resources/img/profile/default_profile.png'"/>
	                    		<h6 class="dropdown-toggle" data-toggle="dropdown">${requestList.nickname}</h6>
	                    		<div class="dropdown-menu">
	                    			<a class="dropdown-item" data-reportee="${requestList.memberId}" data-toggle="modal" data-target="#reportUserEnrollModal"><small>신고</small></a>
	                    			<a class="dropdown-item" href=""><small>채팅</small></a>
	                    			<c:if test="${requestList.memberId eq loginMember.id}">
	                    				<a class="dropdown-item" onclick="requestDelete();"><small>삭제</small></a>
	                    				<input type="hidden" id="requestNo" value="${requestList.no}"/>
	                    			</c:if>
	                    		</div>
		                    </div>
	                    </div>
                    </c:forEach>
                </div>
			</div>
		</div>
	</div>
	<div class="mb-50">${pagebar}</div>
	
	
    <!-- 사용자 신고 등록 Modal -->
    <div class="modal fade" id="reportUserEnrollModal" tabindex="-1" role="dialog"
        aria-labelledby="reportUserEnrollModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reportUserEnrollModalLabel">사용자 신고</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form:form method="POST" action="${pageContext.request.contextPath}/report/reportUserEnroll.do">
	                <div class="modal-body">
	                    <div>
	                        <p>신고자ID</p>
	                        <input type="text" id="reporter" name="reporter" value="${loginMember.id}" readonly />
	                    </div>
	                    <div>
	                        <p>신고대상ID</p>
	                        <input type="text" id="reportee" name="reportee" value="" readonly />
	                    </div>
	                    <div>
							<p>사유</p>
							<input type="radio" name="reason" id="badword" value="욕설">
							<label for="badword">욕설</label>&nbsp;
							<input type="radio" name="reason" id="cheat" value="사기">
							<label for="cheat">사기</label>&nbsp;
							<input type="radio" name="reason" id="loop" value="도배">
							<label for="loop">도배</label>&nbsp;
							<input type="radio" name="reason" id="ad" value="광고">
							<label for="ad">광고</label>&nbsp;
							<input type="radio" name="reason" id="weird" value="음란물">
							<label for="weird">음란물</label>&nbsp;
						</div>
	                    <div>
	                        <p>상세내용</p>
	                        <textarea name="detail" cols="55" rows="5" placeholder="내용을 입력하세요."></textarea>
	                    </div>
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	                    <button type="submit" class="btn btn-success">신고</button>
	                </div>
				</form:form>
            </div>
        </div>
    </div>



<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

