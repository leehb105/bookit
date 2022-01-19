<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- #HB.3 script 3개등록 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<title>Insert title here</title>
</head>
<body>

	        <div class="container">
	           <ul>
		            <c:forEach items="${list}" var ="ChatRoom">
		                
		                    <li>${ChatRoom.name}</li>
		                    <button class = "detail" value = ${ChatRoom.roomId}>${ChatRoom.name} 입장하기</button>
		            </c:forEach>
	            </ul>
	        </div>
	        <form action="${pageContext.request.contextPath}/chatroom/create" method="post">
	            <input type="text" name="name" class="form-control">
	            <button class="btn btn-secondary">개설하기</button>
	        </form>




<script>
$(".detail").click((e) => {
	
	const id = $(e.target).val()
	console.log(id);
	location.href = `${pageContext.request.contextPath}/chatroom/detail.do?id=\${id}`;
});




</script> 
</body>
</html>