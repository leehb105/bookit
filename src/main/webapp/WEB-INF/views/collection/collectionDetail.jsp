<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- Breadcrumb Area Start -->
<div class="breadcrumb-area bg-img bg-overlay jarallax" style="background-image: url(img/bg-img/16.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcrumb-content text-center">
                    <h2 class="page-title">OOO님의 컬렉션제목</h2>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Collection</li>
                            <li class="breadcrumb-item active" aria-current="page">OOO님의 컬렉션제목</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb Area End -->

<!-- Rooms Area Start -->
<div class="roberto-rooms-area section-padding-100-0">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <!-- Section Heading -->
                <div class="section-heading text-center wow fadeInUp" data-wow-delay="100ms">
                    <h4>OOO님의 컬렉션제목</h4>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-12 col-lg-8">
                <!-- Single Room Area -->
                <div class="single-room-area d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="100ms">
                    <!-- Room Thumbnail -->
                    <div class="room-thumbnail">
                        <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    </div>
                    <!-- Room Content -->
                    <div class="room-content">
                        <h2>Room View Sea</h2>
                        <h4>400$ <span>/ Day</span></h4>
                        <div class="room-feature">
                            <h6>Size: <span>30 ft</span></h6>
                            <h6>Capacity: <span>Max persion 5</span></h6>
                            <h6>Bed: <span>King beds</span></h6>
                            <h6>Services: <span>Wifi, television ...</span></h6>
                        </div>
                        <a href="#" class="btn view-detail-btn">View Details <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                    </div>
                </div>

                <!-- Single Room Area -->
                <div class="single-room-area d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="300ms">
                    <!-- Room Thumbnail -->
                    <div class="room-thumbnail">
                        <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    </div>
                    <!-- Room Content -->
                    <div class="room-content">
                        <h2>Small Room</h2>
                        <h4>400$ <span>/ Day</span></h4>
                        <div class="room-feature">
                            <h6>Size: <span>30 ft</span></h6>
                            <h6>Capacity: <span>Max persion 5</span></h6>
                            <h6>Bed: <span>King beds</span></h6>
                            <h6>Services: <span>Wifi, television ...</span></h6>
                        </div>
                        <a href="#" class="btn view-detail-btn">View Details <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                    </div>
                </div>

                <!-- Single Room Area -->
                <div class="single-room-area d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="500ms">
                    <!-- Room Thumbnail -->
                    <div class="room-thumbnail">
                        <img src="${pageContext.request.contextPath}/resources/img/21.jpg" alt="">
                    </div>
                    <!-- Room Content -->
                    <div class="room-content">
                        <h2>Premium King Room</h2>
                        <h4>400$ <span>/ Day</span></h4>
                        <div class="room-feature">
                            <h6>Size: <span>30 ft</span></h6>
                            <h6>Capacity: <span>Max persion 5</span></h6>
                            <h6>Bed: <span>King beds</span></h6>
                            <h6>Services: <span>Wifi, television ...</span></h6>
                        </div>
                        <a href="#" class="btn view-detail-btn">View Details <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Rooms Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
