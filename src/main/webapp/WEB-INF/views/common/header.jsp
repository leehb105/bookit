<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

</head>

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
                <form action="index.html" method="get">
                    <input type="search" name="search-form-input" id="searchFormInput" placeholder="Type your keyword ...">
                    <button type="submit"><i class="icon_search"></i></button>
                </form>
            </div>
        </div>

        <!-- Top Header Area Start -->
        <!-- <div class="top-header-area">
            <div class="container">
                <div class="row">

                    <div class="col-6">
                        <div class="top-header-content">
                            <a href="#"><i class="icon_phone"></i> <span>(123) 456-789-1230</span></a>
                            <a href="#"><i class="icon_mail"></i> <span>info.colorlib@gmail.com</span></a>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="top-header-content">
                            Top Social Area
                            <div class="top-social-area ml-auto">
                                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-tripadvisor" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div> -->
        <!-- Top Header Area End -->

        <!-- Main Header Start -->
        <div class="main-header-area">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Classy Menu -->
                    <nav class="classy-navbar justify-content-between" id="robertoNav">

                        <!-- Logo -->
                        <a class="nav-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/resources/img/bookit_logo.png" alt=""></a>

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
                                    
                                    <li><a href="#">중고거래</a></li>
                                    <li><a href="#">커뮤니티</a></li>
                                    <li><a href="#">도서요청</a>
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
                                    </li>
                                    <li><a href="#">컬렉션</a></li>
                                    <li><a href="#">관리자</a></li>
									<li><a href="${pageContext.request.contextPath}/chat/chatMain.do">채팅테스트</a></li>                               
 									</ul>

                                <!-- Search -->
                                <div class="search-btn ml-4" style="padding-right: 30px">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </div>

                                <!-- Login -->
                              <c:if test="${empty loginMember}">
                                <div class="book-now-btn ml-3 ml-lg-5">
                                    <a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인/회원가입<i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                                </div>
                              </c:if>
                              <c:if test="${!empty loginMember}">
                              	<div style="padding-right:10px">
                              		
	                            	<a href="#">${loginMember.name}님</a>
	                            	<a href="#"><i class="fa fa-heart fa-lg"></i></a>
	                              		
                              	</div>
                              	
								<a href="${pageContext.request.contextPath}/member/memberLogout.do" class="btn roberto-btn mb-15">로그아웃</a>
						  	  	
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