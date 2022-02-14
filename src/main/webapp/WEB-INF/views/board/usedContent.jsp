<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used.css"/>
<script src="https://kit.fontawesome.com/01809a491f.js" crossorigin="anonymous"></script>
<script>
function goUsedList(){
	location.href = "${pageContext.request.contextPath}/board/used.do";
}
</script>
<style>
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button { overflow: hidden; }
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<div id="board-container" class="mx-auto text-center">
      <input type="submit" value="등록" >
      <input type="button" value="취소" onclick="goUsedList();">
    <p>${used.category}</p> 
	<p>${used.title}</p>
	<!-- 닉네임 이미지 -->
	<p>${used.nickname}</p>
	<p>${used.regDate}</p>
	<p>${used.readCount}</p>
	<p>${used.price}</p>
	<p>${used.bookState}</p>
	<p>${used.tradeMethod}</p>
	<p>${used.content}</p>
	<!-- 파일 이미지 -->
	<!-- 파일 다운로드 -->
	
	<c:forEach items="${community.file}" var="file" varStatus="vs">
		<a
			href="${pageContext.request.contextPath}/board/fileDownload.do?fileNo=${file.no}"
			role="button" class="btn btn-outline-success btn-block"> 첨부파일
			${vs.count} - ${file.originalFilename}</a>
		<hr>
	</c:forEach>
<div class="likeReport" style="text-align: center;">
	<h3 id="empty" style="diaplay: inline-block;">
		<a href="#" onclick="like();"><i class="far fa-thumbs-up"></i></a>
	</h3>
	<h3 id="full" style="display: none">
		<a href="#" onclick="likeCancel();"><i class="fas fa-thumbs-up"></i></a>
	</h3>
	<h3>
		<a href="#" data-toggle="modal" data-target="#reportBoardEnrollModal"><i
			class="fas fa-ban" style="display: inline-block;"></i></a>
	</h3>
</div>
<br>



</div>
	<br>
	<br>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>