<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	        <div class="container">
	           <ul>
		            <c:forEach items="${list}" var ="ChatRoom">
		                    <li>${ChatRoom.memberId}</li>
		                    <button class = "detail" value = ${ChatRoom.roomId}>${ChatRoom.memberId} 입장하기</button>
		            </c:forEach>
	            </ul>
	        </div>
	        <form action="${pageContext.request.contextPath}/chatroom/create" method="post">
	        	<br />
	        	<h3>채팅할 회원 아이디 입력</h3>
	            <input type="text" name="name" class="name">
	            <input type="hidden" name = "loginMember" value = ${loginMember.id}>
	            <button class="btn btn-secondary">개설하기</button>
	        </form>
				 <button class="btn-search" value = ${loginMember.id}>채팅방 목록조회</button>

<script>

$(document).ready(function() {
	
	
	$(".btn-search").on("click", function(e){
		const loginMember = $(e.target).val();
		
		location.href = `${pageContext.request.contextPath}/chatroom/list?loginMember=\${loginMember}`;
		
	});	
	
	$(".detail").click((e) => {
		
		const id = $(e.target).val();
		console.log(id);
		location.href = `${pageContext.request.contextPath}/chatroom/detail.do?id=\${id}`;
	});

});






</script> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>