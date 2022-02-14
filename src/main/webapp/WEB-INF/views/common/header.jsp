<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 인증객체의 principal속성을 pageContext 속성으로 저장 -->
<sec:authentication property="principal" var="loginMember"/>


<!DOCTYPE html>
<html lang="en">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Title -->
    <title>Bookit - Book Rental & Resale</title>

    <!-- Favicon --> 
    <%-- <link rel="icon" href="${pageContext.request.contextPath}/resources/img/core-img/favicon.png"> --%>

    <!-- Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/roberto/style.css">
    
    <!-- Socket JS등록 및 STOMP 채팅을 위한 script 3개 -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/dist/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <!-- datepicker 사용을 위한 링크 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <script src="${pageContext.request.contextPath}/resources/roberto/js/bootstrap-datepicker.ko.js"></script>

    <!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/review.css">
    
</head>
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>

<body>
    <!-- Preloader -->
    <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- /Preloader -->

    <!-- Header Area Start -->
    <header class="header-area">
        <!-- Search Form -->
        <div class="search-form d-flex align-items-center">
            <div class="container">
                <form action="${pageContext.request.contextPath}/search/searchBook.do" method="get">
                    <input type="search" name="title" id="searchFormInput" placeholder="검색할 도서를 입력해주세요">
                    <button type="submit"><i class="icon_search"></i></button>
                </form>
            </div>
        </div>


        <!-- Main Header Start -->
        <div class="main-header-area">
            <div class="classy-nav-container breakpoint-off" style="box-shadow: 3px 3px 3px 3px #f5f5f5">
                <div class="container">
                    <!-- Classy Menu -->
                    <nav class="classy-navbar justify-content-between" id="robertoNav">

                        <!-- Logo -->
                        <a class="nav-brand" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/img/bookit_logo.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">
                            <!-- Menu Close Button -->
                            <!-- <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div> -->
                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul id="nav">
                                    
                                    <li><a href="${pageContext.request.contextPath}/booking/bookingEnroll.do">대여등록</a></li>  
                                    <li><a href="${pageContext.request.contextPath}/board/used.do">중고거래</a></li>  
                                    <li><a href="${pageContext.request.contextPath}/board/community.do">커뮤니티</a></li>  
                                  	<li><a href="${pageContext.request.contextPath}/board/request.do">도서요청</a></li>  
                                        <!-- <ul class="dropdown">
                                            <li><a href="./index.html">- Home</a></li>
                                            <li><a href="./room.html">- Rooms</a></li>
                                            <li><a href="./single-room.html">- Single Rooms</a></li>
                                            <li><a href="./about.html">- About Us</a></li>
                                            <li><a href="./blog.html">- Blog</a></li>
                                            <li><a href="./single-blog.html">- Single Blog</a></li>
                                            <li><a href="./contact.html">- Contact</a></li>
                                            <li><a href="#">- Dropdown</a>
                                                <ul class="dropdown">
                                                    <li><a href="#">- Dropdown Item</a></li>
                                                    <li><a href="#">- Dropdown Item</a></li>
                                                    <li><a href="#">- Dropdown Item</a></li>
                                                    <li><a href="#">- Dropdown Item</a></li>
                                                </ul>
                                            </li>
                                        </ul> -->

                                    <li><a href="#">컬렉션</a></li>             
 								</ul>

                                <!-- Search -->
                                <div class="search-btn ml-4" style="padding-right: 15px">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </div>
                                <!-- Login -->
                              <sec:authorize access="isAnonymous()">

	                                <div class="book-now-btn ml-3 ml-lg-5">
	                                    <a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인/회원가입<i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
	                                </div>
                              </sec:authorize>
                              
                              
                              <sec:authorize access="isAuthenticated()">
                              	<div style="padding-right:20px">
                              		<c:choose>
	                              		<c:when test="${loginMember.id eq 'admin'}">
	                              			<a href="${pageContext.request.contextPath}/admin/admin.do">
		                            		<sec:authentication property="principal.username"/>
		                            		</a>님 &nbsp
	                                        <a href="${pageContext.request.contextPath}/booking/myBooking.do?pageNum=1&amout=5"><i class="fa fa-list fa-lg"></i></a> &nbsp
		                            	<a href="#"><i class="fa fa-heart fa-lg"></i></a>
		                            	<a href="${pageContext.request.contextPath}/member/memberLogout.do" class="btn roberto-btn mb-15 w-10">로그아웃</a>
	                              		</c:when>
	                              		
	                              		<c:otherwise>
		                              		<a href="${pageContext.request.contextPath}/member/mypageMain.do">
		                            		<sec:authentication property="principal.username"/>
		                            		</a>님 &nbsp
	                                        <a href="${pageContext.request.contextPath}/booking/myBooking.do?pageNum=1&amout=5"><i class="fa fa-list fa-lg"></i></a> &nbsp
		                            		<a href="#"><i class="fa fa-heart fa-lg"></i></a>
		                            		<a href="${pageContext.request.contextPath}/member/memberLogout.do" class="btn roberto-btn mb-15 w-10">로그아웃</a>
	                              		</c:otherwise>
                              		</c:choose>
		                          </div>
						  	  </sec:authorize>	
						  	  
						  	  <c:if test="${!empty sessionScope.kakaoE}">
                              	<div style="padding-right:10px">
                              		
	                            	<a href="${pageContext.request.contextPath}/member/mypageMain.do">${sessionScope.kakaoN}님</a>
	                            	<a href="#"><i class="glyphicon glyphicon-th-list"></i></a>
	                            	<a href="#"><i class="fa fa-heart fa-lg"></i></a>
	                              		
                              	</div>
                              	
								<a href="${pageContext.request.contextPath}/member/memberLogout.do" class="btn roberto-btn mb-15 w-10">로그아웃</a>
						  	  	
						  	  </c:if>
                            </div>
                            <!-- Nav End -->
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- Header Area End -->