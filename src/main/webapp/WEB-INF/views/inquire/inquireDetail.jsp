<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<script>
function adminInquireValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
};
</script>

<div class="container member-profile">
    <!-- Blog Area Start -->
    <div class="roberto-news-area">
        <div class="container">
            <div class="row">
				<div class="col-2">
					<div class="profile-work">
						<a href="${pageContext.request.contextPath}/member/mypageMain.do"><p>마이페이지HOME</p></a>
						<a href="${pageContext.request.contextPath}/member/editProfile.do">정보수정</a><br />
						<p>북토리 관리</p>
						<a href="">결제 내역</a><br /> <a href="">거래 내역</a><br /> <a href="">북토리충전</a>
						<p>나의 게시글</p>
						<a href="">게시글 작성목록</a><br /> <a href="">리뷰 작성목록</a><br />
						<p>1:1 문의</p>
						<a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1문의하기</a><br />
						<a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1문의내역</a><br />
						<p>신고내역</p>
						<a href="${pageContext.request.contextPath}/report/reportList.do">나의 신고목록</a><br />
					</div>
				</div>
                <div class="col-lg-8 col-md-10 ml-100">
                	<div class="section-heading text-center">
						<h5>1:1 문의내역</h5>
					</div>
                    <!-- Blog Details Text -->
                    <div class="comment_area clearfix pb-0">
                    	<hr />
                        <p><h5>[${inquire.category}] ${inquire.title}</h5></p>
                        <ol>
                            <!-- Single Comment Area -->
                            <li class="single_comment_area">
                                <!-- Comment Content -->
                                <div class="comment-content d-flex">
                                    <!-- Comment Meta -->
                                    <div class="comment-meta">
                                        <a href="#" class="post-date"><fmt:formatDate value="${inquire.regDate}" pattern="yyyy/MM/dd"/></a>
                                        <h6>${loginMember.id}</h6>
                                        <pre class="mt-30">${inquire.content}</pre>
                                    </div>
                                </div>
                            </li>
                        </ol>
                    </div>
		
                    <!-- Comments Area -->
                    <c:if test="${adminInquire.condition eq 1}">
	                    <div class="comment_area mb-50 clearfix pb-0">
	                        <p><h5>[답변]<small>[${inquire.category}] ${inquire.title}</small></h5></p>
	                        <ol>
	                            <li class="single_comment_area">
	                                <!-- Comment Content -->
	                                <div class="comment-content d-flex">
	                                    <!-- Comment Meta -->
	                                    <div class="comment-meta">
	                                        <a href="#" class="post-date"><fmt:formatDate value="${adminInquire.regDate}" pattern="yyyy/MM/dd"/></a>
	                                        <h6>${adminInquire.adminName}</h6>
	                                        <pre class="mt-30">${adminInquire.content}</pre>
	                                    </div>
	                                </div>
	                            </li>
	                        </ol>
	                    </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog Area End -->
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
