<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="https://kit.fontawesome.com/01809a491f.js" crossorigin="anonymous"></script>
<sec:authentication property="principal" var="loginMember"/>

	<!-- Rooms Area Start -->
    <div class="roberto-rooms-area section-padding-100-0 wow fadeInUp" data-wow-delay="100ms">
        <div class="container">
            <div class="row justify-content-center">
                <div class="text-center">
                    <!-- Single Room Details Area -->
                    <h3>해당 페이지의 권한이 없습니다.</h3>
                    <p style="margin-bottom: 500px;"></p>
                </div>
            </div>
        </div>
    </div>

	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
