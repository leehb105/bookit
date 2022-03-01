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

<jsp:include page="/WEB-INF/views/member/common/adminSidebar.jsp"/>

<script>
$(() => {
	$("tr[data-no]").click((e) => {
		const $tr = $(e.target).parent();
		const no = $tr.data("no");
		location.href = `${pageContext.request.contextPath}/admin/adminInquireDetail.do?no=\${no}`;
	});
});
</script>
<style>
.selectInquire:hover{
	cursor: pointer;
	background: #f7fff6;
}
</style>
    	
            <div class="col-lg-9 col-md-10 ml-auto mr-auto">
	    		<div class="section-heading text-center">
					<h5>회원문의</h5>
				</div>
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
