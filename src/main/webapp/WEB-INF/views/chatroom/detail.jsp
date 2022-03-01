<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/chat.css" />


<div class="container member-profile">

                <div id="msgArea" class="chat-history">
                	<ul>
	                	<c:forEach items="${ChatList}" var ="chatHistory">
	                		<c:if test="${not empty chatHistory and chatHistory.writer eq loginMember.id}">
	                				<li class="self"><b>${chatHistory.writer} : ${chatHistory.message}</b></li>
	                		</c:if>
	                			<c:if test="${not empty chatHistory and chatHistory.writer ne loginMember.id}">
	                				<li class="member"><b>${chatHistory.writer} : ${chatHistory.message}</b></li>
	                		</c:if>
	                	
	                	 </c:forEach>
	                </ul>
                </div>
                
                <div class="msg-send">
                        <input type="text" value="chatMain" id = "msg" class="inputChat"/>
                        <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
                </div>

   

		
		
</div>
        
        <br />
        <hr />

        <form action="">
        	<input type="hidden" value = ${chatRoom.memberId} id = "roomMember"/>
        	<input type="hidden" value = ${chatRoom.roomId} id = "roomId"/>
        	<input type="hidden" value = ${loginMember.id} id = "loginMember"/>
        </form>
<script>
$(document).ready(function() {
	var socket = new SockJS("${pageContext.request.contextPath}/endpoint");
	var roomMember = $("#roomMember").val();
	var roomId = $("#roomId").val();
	var userId = $("#loginMember").val();
	
	


	
	// SockJS를 내부에 들고있는 stomp를 내어줌
	client = Stomp.over(socket);
	
	// connection이 맺어지면 실행
	client.connect({}, function(frame) {
		
		client.subscribe("/sub/room/" + roomId, function(chat){

			var content = JSON.parse(chat.body);
			var message = content.message;
			var writer = content.writer;
			var str = '';
		
		
			if(writer == userId){
				str = "<li class=self>";
				str += "<b>" + writer + " : " + message + "</b>";
				str += "</li>";
				$("#msgArea ul").append(str);
					
			}
			else{
				str = "<li class=member>";
				str += "<b>" + writer + " : " + message + "</b>";
				str += "</li>";
				$("#msgArea ul").append(str);
			}
			
		});
	});
	

	
	$("#button-send").on("click", function(e){
		
		var msg = $("#msg").val();
	

		
		// 첫번째 인자는 spring controller mapping("/app"을 spring controller로 배낸다는 stomp prefix 규칙이다 즉 "/app"뒤가 진짜 mapping 주소)
		// 두번째 인자는 서버로 보낼 떄 추가하고싶은 stomp 헤더이다.
		// 세번째 인자는 서버로 보낼 때 추가하고 싶은 stomp 바디이다. 서버 컨트롤러에서는 mapping된 함수의 String 인자로 json stringify된 문자열을 받을 수 있다.
		client.send("/app/chat",{},JSON.stringify({roomId : roomId, message : msg, writer : userId}));
		msg.value = '';
		
		/**app은 컨트롤러쪽에서 빠져있어도됨 spring이 자동으로 해줌
			
		*/
		
	});
	
	
	
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>