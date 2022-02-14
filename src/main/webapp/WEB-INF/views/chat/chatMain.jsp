<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 인증객체의 principal속성을 pageContext 속성으로 저장 -->
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css"/>



	<div class="container member-profile">
			<div class="chat-row">
				<div class="col-2">
					<div class="profile-work">
						<a href="${pageContext.request.contextPath}/member/mypageMain.do">
							<p>마이페이지HOME</p>
						</a>
						<a href="${pageContext.request.contextPath}/member/editProfile.do">정보 수정</a><br />
						<p>북토리 관리</p>
						<a href="${pageContext.request.contextPath}/member/payments/history.do">결제 내역</a><br />
						<a href="">거래 내역</a><br />
						<a href="${pageContext.request.contextPath}/member/payments/charge.do">북토리 충전</a>
						<p>나의 게시글</p>
						<a href="">게시글 작성목록</a><br />
						<a href="">리뷰 작성목록</a><br />
						<p>1:1 문의</p>
						<a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1 문의하기</a><br />
						<a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1 문의내역</a><br />
						<p>신고내역</p>
						<a href="${pageContext.request.contextPath}/report/reportUserList.do">사용자 신고목록</a><br />
						<a href="${pageContext.request.contextPath}/report/reportBoardList.do">게시글 신고목록</a><br />
						<p><a href="${pageContext.request.contextPath}/chat/chatMain.do">채팅 내역</a></p>
					</div>
				</div>
				 
	        </div>
		<div class ="container-chat">
		
		
		
			<div class ="container-chatheader">
				<form:form action="${pageContext.request.contextPath}/chatroom/create" method="post">
					<br />
					<h5>채팅할 회원 닉네임 입력</h5>
					<input type="text" name="writer" class="writer">
					<button class="btn btn-secondary">개설하기</button>
					
					
				</form:form>
			</div>
			<br />       
        	<div class="container-chatmain">
        		<div class="chatList">

					<c:forEach items="${list}" var ="ChatRoom">
						<button id = ${ChatRoom.roomId} class = "form-control btn roberto-btn w-100" onclick="detail(`${ChatRoom.roomId}`,`${loginMember.id}`)" value = ${ChatRoom.roomId}>
							${ChatRoom.memberId}	
						</button>

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
var loginMember = "${loginMember.id}";
var tf = 0;




// 채팅방 구독하는 함수
function connect(id,loginMember){
		
		client.subscribe("/sub/room/" + id, function(chat){

			var content = JSON.parse(chat.body);
			var message = content.message;
			var writer = content.writer;
			var str = '';
		
		
			if(writer == loginMember){
				str = "<li class ='selfLi'>";
				str += "<span class = 'selfWriter'>" + writer + "</span>"
				str += "<div class = 'self'>" + message + "</div>";
				str += "</li>"
				
				$(".chat-history").append(str);
					
			}
			else{
				str = "<li class = 'memberLi'>";
				str += "<span class = 'memberWriter'>" +writer + "</span>"
				str += "<div class = 'member'>" + message + "</div>";
				str += "</li>"
				$(".chat-history").append(str);
			}
			
			// 스크롤 맨아래로
			$(".chat-history").scrollTop($(".chat-history")[0].scrollHeight);
		});
};


function detail(roomid,loginId) {
	id = roomid;
	loginMember = loginId;
	
	
	
	if(tf == 0){
		
		
		<c:forEach items="${list}" var ="ChatRoom">
			arrRoomId = "${ChatRoom.roomId}";
			connect(arrRoomId,loginMember);
		</c:forEach>
		
		tf = 1;
	}
	
	//connect(id,loginMember);
	// div 비우기
	$(".chat-history").empty();
	
	// 알람표시 지우기

	$("#exclamation").remove();

	
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
					str = "<li class ='selfLi'>";
					str += "<span class = 'selfWriter'>" + chatHistory[i].writer + "</span>"
					str += "<div class = 'self'>" + chatHistory[i].message + "</div>";
					str += "</li>"
					
					$(".chat-history").append(str);
					str = '';
				}
				else{
					str = "<li class = 'memberLi'>";
					str += "<span class = 'memberWriter'>" + chatHistory[i].writer + "</span>"
					str += "<div class = 'member'>" + chatHistory[i].message + "</div>";
					str += "</li>"
					
					$(".chat-history").append(str);
					str = '';
				}
				
			}
			
			// 스크롤 맨아래로
			$(".chat-history").scrollTop($(".chat-history")[0].scrollHeight);
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
	
	
	console.log(loginMember);

	
	
	
	$(".chat").on("click", function(e){

		loginMember = $(e.target).val();
	
		location.href = `${pageContext.request.contextPath}/chat/chatMain?loginMember=\${loginMember}`;
		
	});


	
	$("#button-send").on("click", function(e){

			var msg = $("#msg").val();
		
	
			
			// 첫번째 인자는 spring controller mapping("/app"을 spring controller로 배낸다는 stomp prefix 규칙이다 즉 "/app"뒤가 진짜 mapping 주소)
			// 두번째 인자는 서버로 보낼 떄 추가하고싶은 stomp 헤더이다.
			// 세번째 인자는 서버로 보낼 때 추가하고 싶은 stomp 바디이다. 서버 컨트롤러에서는 mapping된 함수의 String 인자로 json stringify된 문자열을 받을 수 있다.
			client.send("/app/chat",{},JSON.stringify({roomId : id, message : msg, writer : loginMember}));
			msg.value = '';
			$("#msg").val('');
			/**app은 컨트롤러쪽에서 빠져있어도됨 spring이 자동으로 해줌
				
			*/
			
			
			
	});
	
	$("input[type=text]").on('keyup',function(e){
		if(e.key==='Enter' || e.keyCode===13){
			$("#button-send").trigger('click');
			
		}
	});
	
	
	// 채팅 알람 표시해주는 비동기 통신
	
	$.ajax({
		url: "${pageContext.request.contextPath}/chat/chatAlarm",
		method: "GET",
		data:{
			loginMember : loginMember
		},
		success(chatAlarm){
			var len = chatAlarm.length;
			var str = '';
			var btnid;
			for(var i = 0 ; i < len ; i++){
				var id = chatAlarm[i].roomId;
				
				if(chatAlarm[i].read_count === 1){

					str="<svg id='exclamation' xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-exclamation-circle' viewBox='0 0 16 16'>";
					str += "<path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/>";
					str +=	"<path d='M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z'/>";
					str += "</svg>";
					
					$("#"+id).append(str);
					str = '';
				}
				console.log(id);
			}
		},
		error: console.log
	});
	
	
	


});




</script> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>