<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css"/>
<script>

console.log("TEST");
console.log("${community}");

function goCommunityList(){
	location.href = "${pageContext.request.contextPath}/board/community.do";
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
      <input type="button" value="취소" onclick="goCommunityList();">
	<p>${community.title}</p>
	<p>${community.nickname}"</p>
	<p>${community.content}</p>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
