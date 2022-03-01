<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/member/common/adminSidebar.jsp"/>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminList.css"/>     

	<div class = "memberList_container">
		<table id="tbl-board" class="table table-striped table-hover">
			<tr>
				<th>아이디</th>
				<th>이메일</th>
				<th>닉네임</th>
				<th>이름</th>
				<th>핸드폰</th> 
				<th>가입날짜</th> 
				<th>권한</th>
			</tr>
			<c:forEach items="${memberList}" var="memberList">
				<tr>
					<td>${memberList.id}</td>
					<td>${memberList.email}</td>
					<td>${memberList.nickname}</td>
					<td>${memberList.name}</td>
					<td>${memberList.phone}</td>
					<td><fmt:formatDate value="${memberList.enrollDate}" pattern="yy/MM/dd HH:mm"/> </td>
					<td>
						<select class = "authority" id="${memberList.id}">
							<option value="ROLE_USER">유저</option>					
							<option value="ROLE_ADMIN" <c:if test="${memberList.authorities[0] eq 'ROLE_ADMIN'}"> selected="selected"</c:if>>관리자</option>
							<c:if test="${empty memberList.authorities}"><option value="ROLE_NULL"  selected="selected">권한없음</option></c:if>	
						</select>
					</td>
				</tr>
			</c:forEach>
	</table>
	${pagebar}
	
	</div>
	
	
            </div>
        </div>
</div>

<script>
$(document).ready(function() {
	$(".authority").on('change',function(e) {
		var role = $(e.target).val();
		var id = e.target.id;
		var returnValue = confirm(id+"님의 권한을 변경하시겠습니까?");
		
		if(returnValue){
			$.ajax({
				url: "${pageContext.request.contextPath}/admin/updateAuthority",
				method: "GET",
				data:{
					userId: id,
					authority : role
				},
				success(resp){
					console.log(resp);
				},
				error: console.log
			});
			
		}

		
	});
	
});



</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>