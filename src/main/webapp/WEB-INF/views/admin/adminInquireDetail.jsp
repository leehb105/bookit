﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/member/common/adminSidebar.jsp"/>
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
			<div class="col-lg-8 col-md-10 ml-100">
				<div class="section-heading text-center">
					<h5>회원문의</h5>
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
									<h6>${inquire.memberId}</h6>
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

					<c:if test="${adminInquire.condition lt 1 || adminInquire.condition == null}">
	                    <!-- Leave A Reply -->
	                    <div class="roberto-contact-form mt-50 mb-50">
	                        <h2>문의 답변</h2>
	
	                        <!-- Form -->
	                        <form:form 
	                        	action="${pageContext.request.contextPath}/admin/inquireAdminReply.do"
	                        	method="post"
	                        	onsubmit="return adminInquireValidate();">
	                            <div class="row">
	                                <input type="hidden" name="inquireNo" value="${inquire.no}"/>
	                                <input type="hidden" name="condition" value="0"/>
	                                <input type="hidden" name="adminId" value="${loginMember.id}"/>
	                                <input type="hidden" name="adminName" value="${loginMember.nickname}"/>
	                                <div class="col-12">
	                                    <textarea 
	                                    	name="content" class="form-control mb-30" 
	                                    	placeholder="내용을 입력하세요." style="resize: none"></textarea>
	                                </div>
	                                <div class="col-6">
	                                    <input type="submit" class="btn roberto-btn btn-3 mt-15" value="답변 등록">
	                                </div>
	                            </div>
	                        </form:form>
	                    </div>
                    </c:if>
                </div>
            </div>
        </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
