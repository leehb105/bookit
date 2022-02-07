<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색결과</title>
    <!-- Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/roberto/style.css">


</head>
<body>
    
    <div class="roberto-news-area section-padding-100-0">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <!-- Section Heading -->
                    <div class="section-heading text-left wow fadeInUp" data-wow-delay="100ms">
                        <h5><span style="color: #1cc3b2;">"${query}"</span> 총 ${totalResults}개의 도서가 검색되었습니다.</h5>
                        <hr class="my-2">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Form -->
                    <div class="roberto-contact-form">
                        <form action="${pageContext.request.contextPath}/booking/bookSearch.do" method="get">    
                            <div class="col-12 wow fadeInUp form-inline form-group" data-wow-delay="100ms">
                                <c:forEach var="book" items="${list }">                   
                                    <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp w-75" data-wow-delay="100ms">
                                        <!-- List Cover -->
                                        <div class="post-thumbnail w-25">
                                            <!-- <input type="hidden" name="bno" value="${booking.boardNo}"> -->
                                            <a href="#"><img src="${book.cover }" alt=""></a>
                                        </div>
                                        <!-- List Content -->
                                        <div class="post-content">
                                            <!-- List Meta -->
                                            <!-- List Title -->
                                            <a href="${pageContext.request.contextPath}/booking/bookingEnroll.do" class="post-title">${book.title }제목란</a>
                                            <!-- List Author, publisher, pubdate -->
                                            <p>${book.author} 저 | ${book.publisher} | <fmt:formatDate value="${book.pubdate }" pattern="yyyy년 MM월"/></p>
                                            
                                        </div>
                                    </div>
					            </c:forEach>                                    
                            </div>                         
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>









<!-- **** All JS Files ***** -->
    <!-- jQuery 2.2.4 -->
    <script src="${pageContext.request.contextPath}/resources/roberto/js/jquery.min.js"></script>
    <!-- Popper -->
    <script src="${pageContext.request.contextPath}/resources/roberto/js/popper.min.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/resources/roberto/js/bootstrap.min.js"></script>
    <!-- All Plugins -->
    <script src="${pageContext.request.contextPath}/resources/roberto/js/roberto.bundle.js"></script>
    <!-- Active -->
    <script src="${pageContext.request.contextPath}/resources/roberto/js/default-assets/active.js"></script>
</body>
</html>