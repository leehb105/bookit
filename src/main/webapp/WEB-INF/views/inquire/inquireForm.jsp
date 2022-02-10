<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script>
	function inquireValidate() {
		var $content = $("[name=content]");
		if (/^(.|\n)+$/.test($content.val()) == false) {
			alert("내용을 입력하세요.");
			return false;
		}
		return true;
	}
</script>

<!-- Contact Form Area Start -->
<div class="container member-profile">
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

			<div class="col-10">
				<!-- Section Heading -->
				<div class="section-heading text-center wow fadeInUp" data-wow-delay="100ms">
					<h4>문의하기</h4>
				</div>

				<!-- Form -->
				<div class="roberto-contact-form">
					<form:form
						action="${pageContext.request.contextPath}/inquire/inquireEnroll.do"
						method="post" onsubmit="return inquireValidate();">
						<div class="row">
							<select name="category" class="ml-15 wow fadeInUp"
								data-wow-delay="100ms">
								<option value="게시판">게시판</option>
								<option value="북토리">북토리</option>
								<option value="대여">대여</option>
							</select>
							<div class="col-8 col-lg-4 wow fadeInUp" data-wow-delay="100ms">
								<input type="text" name="title" class="form-control mb-30"
									placeholder="제목을 입력하세요.">
							</div>
							<div class="col-8 col-lg-4 wow fadeInUp" data-wow-delay="100ms">
								<input name="memberId" class="form-control mb-30"
									value="${loginMember.id}" readonly>
							</div>
							<div class="col-12 wow fadeInUp" data-wow-delay="100ms">
								<textarea name="content" class="form-control mb-30"
									style="resize: none" maxlength="200"
									placeholder="내용을 입력하세요.(200자)"></textarea>
							</div>
							<div class="col-12 text-center wow fadeInUp"
								data-wow-delay="100ms">
								<button type="submit" class="btn roberto-btn mt-15">문의접수</button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Contact Form Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
