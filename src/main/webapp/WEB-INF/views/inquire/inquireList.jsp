<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
function goInquireForm(){
	location.href = "${pageContext.request.contextPath}/inquire/inquireForm.do";
}
$(() => {
	$("tr[data-no]").click((e) => {
		const $tr = $(e.target).parent();
		const no = $tr.data("no");
		location.href = `${pageContext.request.contextPath}/inquire/inquireDetail.do?no=\${no}`;
	});
});
</script>
<style>
.selectInquire:hover{
	cursor: pointer;
	background: #f7fff6;
}
</style>

<div class="container member-profile">
	<div class="container mb-100">
    	<div class="row mb-50">
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
    	
            <div class="col-lg-9 col-md-10 ml-auto mr-auto">
	    		<div class="section-heading text-center">
					<h5>1:1 문의내역</h5>
				</div>
				<input type="button" value="문의등록" id="btn-add" class="btn btn-outline-success float-right mb-30" onclick="goInquireForm();"/>
                <div class="table-responsive">
	                <table class="table" style="text-align: center;">
	                    <thead>
	                        <tr>
	                            <th>번호</th>
	                            <th>작성자</th>
	                            <th>제목</th>
	                            <th>작성일</th>
	                            <th>상태</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${inquireList}" var="inquireList">
		                        <tr data-no="${inquireList.no}" class="selectInquire">
		                            <td>${inquireList.no}</td>
		                            <td>${inquireList.memberId}</td>
		                            <td>[${inquireList.category}] ${inquireList.title}</td>
		                            <td><fmt:formatDate value="${inquireList.regDate}" pattern="yyyy/MM/dd"/></td>
		                            <td>
			                            <c:choose>
			                            	<c:when test="${inquireList.condition eq 0}">대기중</c:when>
			                            	<c:when test="${inquireList.condition eq 1}"><strong style="color: #7add4e;">답변완료</strong></c:when>
			                            </c:choose>
		                            </td>
		                        </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
                </div>
				${pagebar}
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
