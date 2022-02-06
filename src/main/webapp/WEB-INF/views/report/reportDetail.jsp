<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <!-- Blog Area Start -->
    <div class="roberto-news-area section-padding-100-0">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <!-- Blog Details Text -->
                    
                    <div class="comment_area mb-50 clearfix">
                    	<hr />
                        <p><h5>${reportUser.reason}</h5></p>
                        <ol>
                            <!-- Single Comment Area -->
                            <li class="single_comment_area">
                                <!-- Comment Content -->
                                <div class="comment-content d-flex">
                                    <!-- Comment Meta -->
                                    <div class="comment-meta">
                                        <a href="#" class="post-date"><fmt:formatDate value="${reportUser.regDate}" pattern="yyyy/MM/dd"/></a>
                                        <h6>신고자ID : ${reportUser.reporter}</h6>
                                        <h6>신고대상ID : ${reportUser.reportee}</h6>
                                        <pre class="mt-50">${reportUser.detail}</pre>
                                    </div>
                                </div>
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
