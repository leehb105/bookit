<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
function inquireValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}
</script>

    <!-- Contact Form Area Start -->
    <div class="roberto-contact-form-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <!-- Section Heading -->
                    <div class="section-heading text-center wow fadeInUp" data-wow-delay="100ms">
                        <h4>문의하기</h4>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Form -->
                    <div class="roberto-contact-form">
                        <form action="${pageContext.request.contextPath}/inquire/inquireEnroll.do" method="post" onsubmit="return inquireValidate();">
                            <div class="row">
	                            <select name="category" class="ml-15">
								    <option value="게시판">게시판</option>
								    <option value="북토리">북토리</option>
								    <option value="대여">대여</option>
								</select>
                                <div class="col-8 col-lg-4 wow fadeInUp" data-wow-delay="100ms">
	                                <input type="text" name="title" class="form-control mb-30" placeholder="제목을 입력하세요.">
                                </div>
								<div class="col-8 col-lg-4 wow fadeInUp" data-wow-delay="100ms">
	                                <input name="memberId" class="form-control mb-30" value="honggd" readonly>
                                </div>
                                <div class="col-12 wow fadeInUp" data-wow-delay="100ms">
                                    <textarea name="content" class="form-control mb-30" placeholder="내용을 입력하세요.(200자)"></textarea>
                                </div>
                                <div class="col-12 text-center wow fadeInUp" data-wow-delay="100ms">
                                    <button type="submit" class="btn roberto-btn mt-15">문의접수</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact Form Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
