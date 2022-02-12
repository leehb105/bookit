
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css"/>
<script src="https://kit.fontawesome.com/01809a491f.js" crossorigin="anonymous"></script>

<script>
function updateCommunity(){
	location.href = "${pageContext.request.contextPath}/board/communityUpdate.do?no=${community.communityNo}";
}
function communityDelete(){
	let check = confirm("정말 삭제하시겠습니까?");
	if (check){
		location.href='communityDelete.do?no=${community.communityNo}'
	}
}
function showButton(){
	if ("${community.memberId}" == "${loginMember.id}"){
		
	}else{
		document.getElementById('delete').style.display = 'none';
		document.getElementById('modify').style.display = 'none';
	}
}

function like(){
	document.getElementById('full').style.display = 'inline-block';
	document.getElementById('empty').style.display = 'none';
	
}
function dislike(){
	document.getElementById('full').style.display = 'none';
	document.getElementById('empty').style.display = 'inline-block';
}
function goCommunityList(){
	location.href = "${pageContext.request.contextPath}/board/community.do";
}


console.log("recomments :", "${community.comment}")

console.log("${community.comment[0].no}")
console.log("delete :", "${community.comment[0].deleteYn}")

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
textarea {resize: none;}
.modal-body p {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 30px;
}
.modal-body input {width: auto;}
</style>
<div id="board-container" class="mx-auto text-center">
      <input type="submit" value="수정" id="modify" onclick="updateCommunity();">
      <input type="button" value="삭제" id="delete" onclick="communityDelete();">
      <input type="button" value="리스트로" onclick="goCommunityList();">
    <p>${community.category}</p>  
	<p>${community.title}</p>
	<!-- 프로필 이미지 -->
	<p>${community.nickname}</p>
	<p>${community.regDate}</p>
	<p>${community.readCount}</p>
	<p>${community.likeCount}</p>
	<p>${community.commentCount}</p>
	<!-- 파일 이미지 -->
	<c:forEach items="${community.file}"  var="file" varStatus="vs">
	<img src="${pageContext.request.contextPath}/resources/img/board/${file.renamedFilename}">
								
	</c:forEach>
	<!-- 글 내용 -->
	<p>${community.content}</p>
	<p>${community.likeCount}</p>
	<!-- 파일 다운로드 -->
	<c:forEach items="${community.file}" var="file" varStatus="vs">
	<a href="${pageContext.request.contextPath}/board/fileDownload.do?fileNo=${file.no}"
	role="button"
	class="btn btn-outline-success btn-block">
	첨부파일 ${vs.count} - ${file.originalFilename}</a>
	<hr>
	</c:forEach>
	
	<hr>
	
	<table>
	<!-- 댓글 -->
	<c:choose>
		<c:when test="${community.comment ne null}" >

					<c:forEach items="${community.comment}" var="comment">
						<tr data-no="${comment.no}">
					
						<td>${comment.nickname}</td>
						<td><fmt:formatDate value="${comment.regDate}" pattern="yy/MM/dd HH:mm"/></td>
						
						
						<c:choose>
						
							<c:when test="${comment.isParent == 'Y' && comment.deleteYn ==  false}">	
							<td>${comment.content}</td>
								<c:forEach items="${comment.reComments}" var="reComment">
								<tr data-no="${reComment.no}">
									
									<td>${reComment.nickname}</td>
									<td><fmt:formatDate value="${reComment.regDate}" pattern="yy/MM/dd HH:mm"/></td>
									<td>${reComment.content}</td>
								</c:forEach>
							</c:when>
							
							
							<c:when test="${comment.isParent == 'Y' && comment.deleteYn == true && comment.commentLevel == 1}">
							
								<td>삭제된 댓글입니다.</td>
								<c:forEach items="${comment.reComments}" var="reComment">
								<tr data-no="${reComment.no}">
									<td>${reComment.nickname}</td>
									<td><fmt:formatDate value="${reComment.regDate}" pattern="yy/MM/dd HH:mm"/></td>
									<td>${reComment.content}</td>
								</c:forEach>
							</c:when>
						</c:choose>
						</tr>	
					</c:forEach>
					
					</c:when>
					
					<c:otherwise>
						테스트
					</c:otherwise>
			</c:choose>
</table>
			<!--  댓글이 없으면 = 출력 안함 -->

	
	
	
	
	<div class = "likeBan" >
	<h3 id="empty" style="diaplay: inline-block;"><a href="#" onclick="like();" ><i class="far fa-thumbs-up"></i></a></h3>
	<h3 id="full" style="display: none"><a href="#" onclick="dislike();"><i class="fas fa-thumbs-up"></i></a></h3>
	<h3><a href="#" data-toggle="modal" data-target="#reportBoardEnrollModal"><i class="fas fa-ban" style="display: inline-block;"></i></a></h3>
</div>
	<br>

</div>


<!-- 게시글 신고 등록 Modal -->
<div class="modal fade" id="reportBoardEnrollModal" tabindex="-1"
	role="dialog" aria-labelledby="reportBoardEnrollModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h5 class="modal-title" id="reportBoardEnrollModalLabel">신고 상세내용</h5>
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                <span aria-hidden="true">×</span>
	            </button>
	        </div>
	        <form:form method="POST" action="${pageContext.request.contextPath}/report/reportBoardEnroll.do">
	            <div class="modal-body">
	                <div>
	                    <p>신고자ID</p>
	                    <input type="text" name="reporter" value="${loginMember.id}" readonly/>
	                </div>
	                <div>
	                    <p>게시판</p>
	                    <input type="text" name="boardName" value="community" readonly/>
	                </div>
	                <div>
	                    <p>게시글NO</p>
	                    <input type="text" name="boardNo" value="${community.communityNo}" readonly/>
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
	                    <textarea name="detail" cols="40" onkeyup="adjustHeight();" placeholder="내용을 입력하세요"></textarea>
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

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>