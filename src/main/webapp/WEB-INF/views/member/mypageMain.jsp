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

<script src="${pageContext.request.contextPath}/resources/js/curreny.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>    


	<div class="container member-profile">
    	<form method="get" action="${pageContext.request.contextPath}/member/editProfile.do">
       		<div class="row">
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
                       <a href="">나의 신고목록</a>
                       <br/>
                       <button type = "button" value = ${loginMember.id} class = "chat">채팅내역</button>
                   </div>
               </div>
               <div class="col-1">
               </div>
               <div class="col-3">
                   <div class="profile-img">
                   	<br /><br />
                       <img src="${pageContext.request.contextPath}/resources/img/default_profile.png" alt=""/>
                       <!-- <div class="file btn btn-lg">
                          	사진 변경<input type="file" name="file"/>
                       </div> -->
                   </div>
               </div>
               <div class="col-4">
                   <div class="profile-head"><br /><br />
                    <c:if test="${!empty loginMember}">
	                    <h3>
	                        [${loginMember.name}]님 안녕하세요
	                    </h3>
	                    <h5>
	                        ${loginMember.nickname}
	                    </h5>
	                    <p class="proile-rate">나의 평점 : <span>38점</span></p>
	                    <p class="proile-point">나의 북토리 : <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${loginMember.cash}" />토리</span></p>
	                    <button class="profile-edit-btn">프로필 수정</button>
                    </c:if>
                    <c:if test="${!empty sessionScope.kakaoE}">
	                    <h3>
	                        [${sessionScope.kakaoN}]님 안녕하세요
	                    </h3>
	                    <h5>
	                        ${sessionScope.kakaoN}
	                    </h5>
	                    <p class="proile-rate">나의 평점 : <span>38점</span></p>
	                    <p class="proile-point">나의 북토리 : <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${sessionScope.kakaoCash}" />토리</span></p>
	                    <button class="profile-edit-btn">프로필 수정</button>
                    </c:if>
                    <!-- <input type="submit" class="profile-edit-btn" value="Edit Profile"/> -->
                   </div>
               </div>
           </div>
		</form>           
	</div>

<script>
$(document).ready(function() {
	
	
	$(".chat").on("click", function(e){

		loginMember = $(e.target).val();
	
		location.href = `${pageContext.request.contextPath}/chat/chatMain?loginMember=\${loginMember}`;
		
	});


	

	
	



});


</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
