<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

   	<input style="margin: 100px 0 0 950px" type="button" value="문의등록" id="btn-add" class="btn btn-outline-success" onclick="goInquireForm();"/>
    <div class="container mb-100">
    	<div class="row mb-50">
            <div class="col-lg-8 col-md-10 ml-auto mr-auto">
            <h5>1:1 문의 목록</h5>
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
			</div>
		</div>
	${pagebar}
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
