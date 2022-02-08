<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<style>
div#board-container{width:400px; margin:100px auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
div#board-container label.custom-file-label{text-align:left;}
</style>
<script>
function goRequestList(){
	location.href = "${pageContext.request.contextPath}/board/request.do";
}
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
</script>
<div id="board-container">

	<form 
		name="boardFrm" 
		action="${pageContext.request.contextPath}/board/requestEnroll.do" 
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return boardValidate();">
		<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
	    <textarea class="form-control" name="content" placeholder="내용" required></textarea>
		<br />
		<input type="submit" class="btn btn-outline-success" value="저장" >
		<input type="button" value="취소" id="btn-add" class="btn btn-outline-danger" 
		onclick="goRequestList();"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>