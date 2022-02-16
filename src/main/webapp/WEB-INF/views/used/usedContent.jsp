<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="loginMember" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="loginMember" />

<script src="https://kit.fontawesome.com/01809a491f.js" crossorigin="anonymous"></script>
<script>
function goUsedList(){
	location.href = "${pageContext.request.contextPath}/used/used.do";
}
function updateUsed(){
	location.href = "${pageContext.request.contextPath}/used/usedUpdate.do?no=${used.usedBoardNo}";
}
function usedDelete(){
	let check = confirm("정말 삭제하시겠습니까?");
	if (check){
		location.href='usedDelete.do?no=${used.usedBoardNo}'
	}
}
function showButton(){
	if ("${used.writer}" == "${loginMember.id}"){
		
	}else{
		document.getElementById('delete').style.display = 'none';
		document.getElementById('modify').style.display = 'none';
	}
}
$(document).ready(function(){
	// 페이지 로드시 모달창 출력 방지
	$(".modal").css({"display": "none"});
	// modal창 끄고 다시 켰을 때 내용 리셋
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	});
});
// modal textarea 높이 조절
function adjustHeight() {
	var textEle = $('textarea');
	textEle[0].style.height = 'auto';
	var textEleHeight = textEle.prop('scrollHeight');
	textEle.css('height', textEleHeight);
};

</script>
<style>
	div#board-container{width:400px;}
	input, button, textarea {margin-bottom:15px;}
	button { overflow: hidden; }
	/* 부트스트랩 : 파일라벨명 정렬*/
	div#board-container label.custom-file-label{text-align:left;}
</style>
<<<<<<< HEAD
    <div class="roberto-contact-form-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                
             <div class="section-heading text-left wow fadeInUp" data-wow-delay="100ms">
                      <c:if test="${used.writer == loginMember.id}">
                 <input type="button" class="btn btn-outline-danger w-10 float-right" style="margin-left: 5px;" value="삭제" id="delete" onclick="usedDelete();">  
	<input type="submit" class="btn btn-outline-success w-10 float-right" value="수정" id="modify" onclick="updateUsed();"> 
                      </c:if>
                        <h3>상세 보기</h3>
                    </div>

=======
>>>>>>> branch 'master' of https://github.com/jinmae1/bookit.git

<div class="roberto-contact-form-area section-padding-100 wow fadeInUp">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-heading text-left" data-wow-delay="100ms">
					<c:if test="${used.writer == loginMember.id}">
						<input type="button" class="btn btn-outline-danger w-10 float-right" style="margin-left: 5px;" value="삭제" id="delete" onclick="usedDelete();">  
						<input type="submit" class="btn btn-outline-success w-10 float-right" value="수정" id="modify" onclick="updateUsed();"> 
					</c:if>
					<h3>상세 보기</h3>
					<hr class="my-2">
				</div>
			</div>
		</div>

		<div class="roberto-contact-form p-2" data-wow-delay="100ms">
			<div class="row">
				<div class="col-6">
					<h5>
						[${used.category}]<span style="margin-right:30%;"> ${used.title}</span>
					</h5>
				</div>
				<div class="col-6">
					<h5>
						<span style="font-size:15px; margin-left:10px">
							<img src="${pageContext.request.contextPath}/resources/img/profile/${used.profileImage}" height="30" width="30" style="border-radius: 20px; margin-right:5px;"/>
								${used.nickname} 
							<span style="font-size:15px; margin-left:10px">조회수 : ${used.readCount} 작성일 : <fmt:formatDate value="${used.regDate}" pattern="yy/MM/dd HH:mm" /> </span>
						</span>
					</h5>
				</div>
				<div class="col-12 mt-2">
					<hr class="my-2"> 
					<p>
						<span><strong>희망 가격 :</strong></span>
						<span> ${used.price} <strong>원/일</strong></span>
					</p>

					<p>
						<span><strong>도서 상태 :</strong></span>
						<span> ${used.bookState} </span>
					</p>
					<p>
						<span><strong>거래 방법 :</strong></span>
						<span>${used.tradeMethod}</span>
					</p>
				</div>

				<div class="col-2">
					<div class="mt-2">
						<form:form
								action="${pageContext.request.contextPath}/chatroom/create"
								method="post">
								<input type="hidden" name = "writer" value="${used.nickname}"/>
								<input type="button" class="btn btn-outline-success"  value="채팅" />
						</form:form>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<!-- 파일 이미지 -->	
		<div class="row">
			<c:if test="${!empty used.files}">
				<c:forEach items="${used.files}" var="file">
					<img
						src="${pageContext.request.contextPath}/resources/img/board/${file.renamedFilename}">
				</c:forEach>
			</c:if>
			<br>
			<div class="container float-center">
				<p style="margin-bottom: 300px; margin-top:50px">${used.content}</p>
			</div>

			<div class="container">
				<!-- 파일 다운로드 -->
				<c:forEach items="${used.files}" var="files" varStatus="vs">
					<a
						href="${pageContext.request.contextPath}/board/fileDownload.do?fileNo=${files.no}"
						> 첨부파일
						${vs.count} - ${files.originalFilename}</a>
					<hr>
				</c:forEach>
			</div>
		
			<div class="report" style="text-align: center;">
				<h3>
					<a href="#" data-toggle="modal" data-target="#reportBoardEnrollModal"><i
						class="fas fa-ban" style="display: inline-block; color:red;"></i></a>
				</h3>

			</div>
		</div>
		<br>

		<!-- 게시글 신고 등록 Modal -->
		<div class="modal fade" id="reportBoardEnrollModal" tabindex="-1"
			role="dialog" aria-labelledby="reportBoardEnrollModalLabel"
			aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="reportBoardEnrollModalLabel">신고
							상세내용</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<form:form method="POST"
						action="${pageContext.request.contextPath}/report/reportBoardEnroll.do">
						<div class="modal-body">
							<div>
								<p>신고자ID</p>
								<input type="text" name="reporter" value="${loginMember.id}"
									readonly />
							</div>
							<div>
								<p>게시판</p>
								<input type="text" name="boardName" value="community" readonly />
							</div>
							<div>
								<p>게시글NO</p>
								<input type="text" name="boardNo" value="${community.communityNo}"
									readonly />
							</div>
							<div>
								<p>사유</p>
								<input type="radio" name="reason" id="badword" value="욕설">
								<label for="badword">욕설</label>&nbsp; <input type="radio"
									name="reason" id="cheat" value="사기"> <label for="cheat">사기</label>&nbsp;
								<input type="radio" name="reason" id="loop" value="도배"> <label
									for="loop">도배</label>&nbsp; <input type="radio" name="reason"
									id="ad" value="광고"> <label for="ad">광고</label>&nbsp; <input
									type="radio" name="reason" id="weird" value="음란물"> <label
									for="weird">음란물</label>&nbsp;
							</div>
							<div>
								<p>상세내용</p>
								<textarea name="detail" cols="40" onkeyup="adjustHeight();"
									placeholder="내용을 입력하세요"></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-success">신고</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>