<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

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
<section class="roberto-service-area section-padding-100-0">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <!-- Section Heading -->
                <div class="section-heading text-center wow fadeInUp" data-wow-delay="100ms">
                    <h4>Collection</h4>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Single Service Area -->
            <div class="col-12 col-md-6 col-lg-4" onclick="location.href='${pageContext.request.contextPath}/collection/collectionDetail.do';">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    <div class="service-title d-flex align-items-center justify-content-center">
                        <h5>OOO님의 컬렉션제목</h5>
                    </div>
                </div>
            </div>
            <!-- Single Service Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    <div class="service-title d-flex align-items-center justify-content-center">
                        <h5>OOO님의 컬렉션제목</h5>
                    </div>
                </div>
            </div>
            <!-- Single Service Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    <div class="service-title d-flex align-items-center justify-content-center">
                        <h5>OOO님의 컬렉션제목</h5>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    <div class="service-title d-flex align-items-center justify-content-center">
                        <h5>OOO님의 컬렉션제목</h5>
                    </div>
                </div>
            </div>
            <!-- Single Service Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    <div class="service-title d-flex align-items-center justify-content-center">
                        <h5>OOO님의 컬렉션제목</h5>
                    </div>
                </div>
            </div>
            <!-- Single Service Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    <div class="service-title d-flex align-items-center justify-content-center">
                        <h5>OOO님의 컬렉션제목</h5>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</section>
<!-- Service Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
