<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css"/>


	<div class="container member-profile">
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

					<c:forEach items="${list}" var ="ChatRoom">
						<button class = "form-control btn roberto-btn w-100" onclick="detail(`${ChatRoom.roomId}`,`${loginMember.id}`)" value = ${ChatRoom.roomId}>${ChatRoom.memberId}</button>
					</c:forEach>

			    </div>
			    
			    <div class="container-chatHistory">
			    	<div id="msgArea" class="chat-history">
			    		
                	</div>
                	
                	
                	<div class="msg-send">
                        <input type="text" value="chatMain" id = "msg" class="inputChat"/>
                        <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
                	</div>
                	
	                
			    </div>

			</div>
		</div>   
     </div>


<script>

var socket = new SockJS("${pageContext.request.contextPath}/endpoint");
var id;
var loginMember;


// 채팅방 구독하는 함수
function connect(id,loginMember){
		
		client.subscribe("/sub/room/" + id, function(chat){

			var content = JSON.parse(chat.body);
			var message = content.message;
			var writer = content.writer;
			var str = '';
		
		
			if(writer == loginMember){
				str = "<li class=self>";
				str += "<b>" + writer + " : " + message + "</b>";
				str += "</li>";
				$(".chat-history").append(str);
					
			}
			else{
				str = "<li class=member>";
				str += "<b>" + writer + " : " + message + "</b>";
				str += "</li>";
				$(".chat-history").append(str);
			}
			
		});
};

function detail(roomid,loginId) {
	id = roomid;
	loginMember = loginId;
	

	
	connect(id,loginMember);
	// div 비우기
	$(".chat-history").empty();
	

	

	
	// 채팅내역 가져오는 비동기 통신
	$.ajax({
		url: "${pageContext.request.contextPath}/chatroom/detail",
		method: "GET",
		data:{
			id: id
		},
		success(chatHistory){
			
		
			var len = chatHistory.length;
			var str = '';
			for(var i = 0 ; i < len ; i++){
				
				if(chatHistory[i].writer === loginMember){
					str = "<li class = 'self'>";
					str += "<b>" + chatHistory[i].writer + " : " + chatHistory[i].message + "</b>";
					str += "</li>"
					
					$(".chat-history").append(str);
					str = '';
				}
				else{
					str = "<li class = 'member'>";
					str += "<b>" + chatHistory[i].writer + " : " + chatHistory[i].message + "</b>";
					str += "</li>"
					
					$(".chat-history").append(str);
					str = '';
				}
				
			}

			
		},
		error: console.log
	});
	
  
	//location.href = `${pageContext.request.contextPath}/chatroom/detail.do?id=\${id}`;
}

$(document).ready(function() {
	
	// SockJS를 내부에 들고있는 stomp를 내어줌
	client = Stomp.over(socket);
	
	// 클라이언트 연결
	client.connect({});


	
	$(".btn-search").on("click", function(e){
		loginMember = $(e.target).val();
	
		location.href = `${pageContext.request.contextPath}/chatroom/list?loginMember=\${loginMember}`;
		
	});
	
	$("#button-send").on("click", function(e){

			var msg = $("#msg").val();
		
	
			
			// 첫번째 인자는 spring controller mapping("/app"을 spring controller로 배낸다는 stomp prefix 규칙이다 즉 "/app"뒤가 진짜 mapping 주소)
			// 두번째 인자는 서버로 보낼 떄 추가하고싶은 stomp 헤더이다.
			// 세번째 인자는 서버로 보낼 때 추가하고 싶은 stomp 바디이다. 서버 컨트롤러에서는 mapping된 함수의 String 인자로 json stringify된 문자열을 받을 수 있다.
			client.send("/app/chat",{},JSON.stringify({roomId : id, message : msg, writer : loginMember}));
			msg.value = '';
			
			/**app은 컨트롤러쪽에서 빠져있어도됨 spring이 자동으로 해줌
				
			*/
		
	});
	

	
	



});







</script> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>