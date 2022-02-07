<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<c:if test="${!empty loginMember}">
		<div class="button-area mt-40">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<button type="button" class="btn roberto-btn w-10 float-right" onclick="location.href='bookingEnroll.do'">책 등록</button>
					</div>
	
				</div>
			</div>
		</div>

	</c:if>

	<!-- Booking Area Start -->
    <div class="roberto-news-area section-padding-30-0">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <!-- Single Booking List Area -->
					<c:forEach var="booking" items="${list }">                   
	                    <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="100ms">
	                        <!-- List Cover -->
	                        <div class="post-thumbnail">
								<!-- <input type="hidden" name="bno" value="${booking.boardNo}"> -->
	                            <a href="#"><img src="${booking.bookInfo.cover }" alt=""></a>
	                        </div>
	                        <!-- List Content -->
	                        <div class="post-content">
	                            <!-- List Meta -->
	                            <!-- List Title -->
	                            <a href="${pageContext.request.contextPath}/booking/bookingDetail.do?bno=${booking.boardNo}" class="post-title">${booking.bookInfo.title }</a>
	                            <!-- List Author, publisher, pubdate -->
	                            <p>${booking.bookInfo.author} 저 | ${booking.bookInfo.publisher} | <fmt:formatDate value="${booking.bookInfo.pubdate }" pattern="yyyy년 MM월"/></p>
	                            
	                            <div class="list-price">
	                            	<table class="table text-center">
	                            		<tr>
	                            			<td>상태</td>
	                            			<td>보증금</td>
	                            			<td>일당 대여료</td>
	                            		</tr>
	                            		<tr>
	                            			<td>${booking.bookStatus}</td>
	                            			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.deposit }" />원</td>
	                            			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.price }" />원</td>
	                            		</tr>
		                            		
	                            	
	                            	</table>
	                            
	                            
	                          
	                            </div>	
	                            <!-- <div class="post-meta"><a href="">asd</a></div> -->
								
	                        </div>
	                    </div>
					</c:forEach> 
					
					

                    <!-- Pagination -->
                    <nav class="roberto-pagination wow fadeInUp mb-100" data-wow-delay="600ms">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next <i class="fa fa-angle-right"></i></a></li>
                        </ul>
                    </nav>
                </div>

    <!-- Booking Area End -->

	

    <!-- Partner Area End -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
