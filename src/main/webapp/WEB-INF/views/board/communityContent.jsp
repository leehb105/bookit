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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>


console.log("${reComments}");

function like(){
	$.ajax({
		url: "${pageContext.request.contextPath}/board/like",
		type: "POST",
		cache: false,
		dataType: "json",
		success: 
		function(){
			document.getElementById('full').style.display = 'inline-block';
			document.getElementById('empty').style.display = 'none';			
		},
		error:
		function(request, status, error){
			alert('ajax 실패')
		}
		
	});


function dislike(){
	document.getElementById('full').style.display = 'none';
	document.getElementById('empty').style.display = 'inline-block';
}

function goCommunityList(){
	location.href = "${pageContext.request.contextPath}/board/community.do";
}

function updateCommunity(){
	location.href = "${pageContext.request.contextPath}/board/communityUpdate.do";
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
<body onload="showButton();">

<div id="board-container" class="mx-auto text-center">
      <input type="submit" value="수정" id="modify" onclick="updateCommunity();">
      <input type="button" value="삭제" id="delete" onclick="communityDelete();">
      <input type="button" value="리스트로" onclick="goCommunityList();">
   
    <br>
    <p>${community.communityNo}</p>  
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
	<!-- 파일 다운로드 임시-->
	<p>${community.file[0].renamedFilename}</p>
	<hr>

	<div class = "likeBan" >
	<h3 id="empty" style="diaplay: inline-block;"><a href="#" onclick="like();" ><i class="far fa-thumbs-up"></i></a></h3>
	<h3 id="full" style="display: none"><a href="#" onclick="dislike();"><i class="fas fa-thumbs-up"></i></a></h3>
	<h3><a href="#"><i class="fas fa-ban" style="diaplay: inline-block;"></i></a></h3>
</div>
	<br>

</div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
