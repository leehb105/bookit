<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
/* function adminInquireValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}; */

$(conditionUpdateFrm).submit((e) => {
	e.preventDefault();
	
	const no = $("[name=inquireNo]", e.target).val();
	const obj = {condition : $("[name=condition]", e.target).val()};
	const jsonStr = JSON.stringify(obj);
	
	$.ajax({
		url: `${pageContext.request.contextPath}/inquire/inquireUpdateCondition.do?no=\${no}`,
		method: "PUT",
		data: jsonStr,
		contentType: "application/json; charset=utf-8",
		success(resp){
			console.log(resp);
		},
		error: console.log,
		complete(){
			$(e.target)[0].reset();
			$(menuSearchFrm)[0].reset();
		}
	});
});
</script>

    <!-- Blog Area Start -->
    <div class="roberto-news-area section-padding-100-0">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <!-- Blog Details Text -->
                    
                    <div class="comment_area mb-50 clearfix">
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
                                        <h6>${inquire.memberId}</h6>
                                        <pre class="mt-50">${inquire.content}</pre>
                                    </div>
                                </div>
                            </li>
                        </ol>
                    </div>
		
                    <!-- Comments Area -->
                    <%-- <c:if test="${inquire.condition eq 0}"> --%>
                    <div class="comment_area mb-50 clearfix">
                        <p><h5>[답변]<small>[${inquire.category}] ${inquire.title}</small></h5></p>

                        <ol>
                            <!-- Single Comment Area -->
                            <li class="single_comment_area">
                                <!-- Comment Content -->
                                <div class="comment-content d-flex">
                                    <!-- Comment Meta -->
                                    <div class="comment-meta">
                                        <a href="#" class="post-date"><fmt:formatDate value="${adminInquire.regDate}" pattern="yyyy/MM/dd"/></a>
                                        <h6>${adminInquire.adminName}</h6>
                                        <pre class="mt-50">${adminInquire.content}</pre>
                                    </div>
                                </div>
                            </li>
                        </ol>
                    </div>
                    <%-- </c:if> --%>

                    <!-- Leave A Reply -->
                    <div class="roberto-contact-form mt-80 mb-100">
                        <h2>문의 답변</h2>

                        <!-- Form -->
                        	<!-- onsubmit="return adminInquireValidate();" -->
                        <form 
                        	id="conditionUpdateFrm"
                        	action="${pageContext.request.contextPath}/inquire/inquireAdminReply.do"
                        	method="post">
                            <div class="row">
                                <input type="hidden" name="inquireNo" value="${inquire.no}"/>
                                <input type="hidden" name="condition" value="${inquire.condition}"/>
                                <input type="hidden" name="adminId" value="admin1234"/>
                                <input type="hidden" name="adminName" value="관리자이올시다"/>
                                <div class="col-12">
                                    <textarea name="content" class="form-control mb-30" placeholder="내용을 입력하세요."></textarea>
                                </div>
                                <div class="col-12">
                                    <input type="submit" class="btn roberto-btn btn-3 mt-15" value="답변 등록">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
