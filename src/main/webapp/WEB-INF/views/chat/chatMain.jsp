<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css"/>


	<div class="container member-profile">
    	<form method="get" action="${pageContext.request.contextPath}/member/editProfile.do">
       		<div class="chat-row">
               <div class="col-2">
                   <div class="profile-work">
                       <a href="${pageContext.request.contextPath}/member/mypageMain.do"><p>마이페이지HOME</p></a>
                       <a href="${pageContext.request.contextPath}/member/editProfile.do">정보 수정</a><br/>
                       <p>북토리 관리</p>
                       <a href="">결제 내역</a><br/>
                       <a href="">거래 내역</a><br/>
                       <a href="">북토리 충전</a>
                       <p>나의 게시글</p>
                       <a href="">게시글 작성목록</a><br/>
                       <a href="">리뷰 작성목록</a><br/>
                       <p>1:1 문의</p>
                       <a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1 문의하기</a><br/>
                       <a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1 문의내역</a><br/>
                       <p>신고내역</p>
                       <a href="">나의 신고목록</a><br/>
                        <p><a href="${pageContext.request.contextPath}/chat/chatMain.do">채팅 내역</a></p>
                   </div>
               </div>	 	
			</div>
		</form>
		<div class ="container-chat">
		
			<div class ="container-chatheader">
				<form action="${pageContext.request.contextPath}/chatroom/create" method="post">
				<br />
				<h5>채팅할 회원 아이디 입력</h5>
				<input type="text" name="name" class="name">
				<input type="hidden" name = "loginMember" class = "loginMember" value = ${loginMember.id}>
				<button class="btn btn-secondary">개설하기</button>
				</form>
				<button class="btn-search" value = ${loginMember.id}>채팅방 목록조회</button>
			</div>
			<br />       
        	<div class="container-chatmain">
        		<div class="chatList">
					<ul>
						<c:forEach items="${list}" var ="ChatRoom">
					        <button class = "form-control btn roberto-btn w-100" onclick="detail(`${ChatRoom.roomId}`)" value = ${ChatRoom.roomId}>${ChatRoom.memberId}</button>
					    </c:forEach>
				    </ul>
			    </div>

			</div>
		</div>   
     </div>
		 
	


<script>
function detail(roomid) {
	const id = roomid;
	console.log(id);
	location.href = `${pageContext.request.contextPath}/chatroom/detail.do?id=\${id}`;
}

$(document).ready(function() {
	
	
	$(".btn-search").on("click", function(e){
		const loginMember = $(e.target).val();
		console.log("로그인멤버 = ",loginMember);
		location.href = `${pageContext.request.contextPath}/chatroom/list?loginMember=\${loginMember}`;
		
	});	
	
	
	

	
	



});







</script> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>