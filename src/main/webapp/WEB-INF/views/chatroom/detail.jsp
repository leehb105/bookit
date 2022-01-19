<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
        <div class="container">
            <div class="col-6">
                <h1>${room.name}</h1>
            </div>
            <div>
                <div id="msgArea" class="col"></div>
                <div class="col-6">
                    <div class="input-group mb-3">
                        <input type="text" value="chatMain" id = "msg" class="form-control"/>
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" id="button-send" onclick="send()">메세지 보내기</button>
                        </div>
                    </div>
                </div>
            </div>

            
        </div>
<script>
$(document).ready(function() {
	var socket = new SockJS("${pageContext.request.contextPath}/endpoint");
	client = Stomp.over(socket);
	
	client.connect({}, function(frame) {
		
		client.subscribe("/topic/a", function(response){
			console.log(response);
			console.log(JSON.parse(response.body));
		});
	});
	
	
	
});
function send(){
	
	var msg = $("#msg").val();
	console.log(msg);
	
	// 첫번째 인자는 spring controller mapping("/app"을 spring controller로 배낸다는 stomp prefix 규칙이다 즉 "/app"뒤가 진짜 mapping 주소)
	// 두번째 인자는 서버로 보낼 떄 추가하고싶은 stomp 헤더이다.
	// 세번째 인자는 서버로 보낼 때 추가하고 싶은 stomp 바디이다. 서버 컨트롤러에서는 mapping된 함수의 String 인자로 json stringify된 문자열을 받을 수 있다.
	client.send("/app/chat",{},JSON.stringify({msg : msg}));
	
	/**app은 컨트롤러쪽에서 빠져있어도됨 spring이 자동으로 해줌
		
	*/
	
};
</script>
</body>
</html>