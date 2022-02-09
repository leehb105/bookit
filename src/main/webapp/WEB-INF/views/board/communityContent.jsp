<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css"/>
<script src="https://kit.fontawesome.com/01809a491f.js" crossorigin="anonymous"></script>
<script>


console.log("${reComments}");
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

console.log("${community.comment[0].no}")
console.log("delete :", "${community.comment[0].deleteYn}")

</script>
<style>
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button { overflow: hidden; }
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<div id="board-container" class="mx-auto text-center">
      <input type="submit" value="수정" onclick="updateCommunity();">
      <input type="button" value="취소" onclick="goCommunityList();">
    <p>${community.category}</p>  
	<p>${community.title}</p>
	<!-- 프로필 이미지 -->
	<p>${community.nickname}</p>
	<p>${community.regDate}</p>
	<p>${community.readCount}</p>
	<p>${community.likeCount}</p>
	<p>${community.commentCount}</p>
	<!-- 파일 이미지 -->
	<p>${community.content}"</p>
	<p>${community.likeCount}</p>
	
	<hr>

	
	<div class = "likeBan" >
	<h3 id="empty" style="diaplay: inline-block;"><a href="#" onclick="like();" ><i class="far fa-heart" ></i></a></h3>
	<h3 id="full" style="display: none"><a href="#" onclick="dislike();"><i class="fas fa-heart"></i></a></h3>
	<h3><a href="#"><i class="fas fa-ban" style="diaplay: inline-block;"></i></a></h3>
</div>
	<br>

</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
