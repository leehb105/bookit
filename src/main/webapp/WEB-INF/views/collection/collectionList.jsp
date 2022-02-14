<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/collectionImage.css" />

<!-- Breadcrumb Area Start -->
<div class="breadcrumb-area bg-img bg-overlay jarallax" style="background-image: none">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcrumb-content text-center">
                    <h2 class="page-title">Collection Home</h2>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Collection</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb Area End -->

<!-- Service Area Start -->
<section class="roberto-service-area section-padding-100-0 mb-100">
    <div class="container">

        <div class="row">
        	<c:forEach items="${collectionList}" var="collectionList">
	            <div class="col-12 col-md-6 col-lg-4">
					<div class="single-post-area mb-100 wow fadeInUp text-center" data-wow-delay="50ms">
						<div class="collectionImage mb-4">
							<a href="${pageContext.request.contextPath}/collection/collectionDetail.do?no=${collectionList.no}">
								<img src="${pageContext.request.contextPath}/resources/img/profile/${collectionList.profileImage}"
								onerror="this.src='${pageContext.request.contextPath}/resources/img/profile/default_profile.png'">
							</a>
						</div>
						<h5 class="post-title">${collectionList.nickname}님의</h5>
						<h6>${collectionList.collectionName}</h6>
					</div>
				</div>
            </c:forEach>
        </div>
    </div>
    ${pagebar}
</section>
<!-- Service Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
