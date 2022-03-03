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
    <div class="roberto-news-area section-padding-30-0 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-12 mb-100">
                    <!-- Single Booking List Area -->
					<c:forEach var="booking" items="${list }">     
						<hr class="my-2 wow fadeInUp">              
	                    <div class="single-blog-post d-flex align-items-center mt-30 mb-30 wow fadeInUp" data-wow-delay="100ms">
	                        <!-- List Cover -->
	                        <div class="col-3">
								<!-- <input type="hidden" name="bno" value="${booking.boardNo}"> -->
	                            <a href="#"><img src="${booking.bookInfo.cover }" alt=""></a>
	                        </div>
	                        <!-- List Content -->
	                        <div class="post-content">
	                            <!-- List Meta -->
	                            <!-- List Title -->
	                            <a href="${pageContext.request.contextPath}/booking/bookingDetail.do?bno=${booking.boardNo}&checkIn=${checkIn}&checkOut=${checkOut}" class="post-title">${booking.bookInfo.title }</a>
	                            <!-- List Author, publisher, pubdate -->
	                            <p>${booking.bookInfo.author} 저 | ${booking.bookInfo.publisher} | <fmt:formatDate value="${booking.bookInfo.pubdate }" pattern="yyyy년 MM월"/></p>
	                            
	                            <div class="list-price">
	                            	<table class="table text-center">
	                            		<tr>
	                            			<td>상태</td>
	                            			<td>보증금</td>
	                            			<td>일당 대여료</td>
	                            			<td>주소</td>
	                            		</tr>
	                            		<tr>
	                            			<td>${booking.bookStatus}</td>
	                            			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.deposit }" />원</td>
	                            			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.price }" />원</td>
											<td>${booking.member.searchAddress}</td>
	                            		</tr>
		                            		
	                            	
	                            	</table>
	                            
	                            
	                          
	                            </div>	
	                            <!-- <div class="post-meta"><a href="">asd</a></div> -->
								
	                        </div>
	                    </div>
					</c:forEach> 
					<c:if test="${empty list}">
						<div class="col-12 mb-100">
							<h2>검색 결과가 없습니다.</h2>
						</div>
						
					</c:if>
					<c:if test="${!empty list}">
						<hr class="my-2 wow fadeInUp">
						<!-- Pagination -->
						<nav class="roberto-pagination wow fadeInUp mb-100" data-wow-delay="100ms">
							<ul class="pagination">
								<c:if test="${page.prev}"> 
									<li class="page-item"><a class="page-link" href="${page.startPage - 1}"> 이전 <i class="fa fa-angle-left"></i></a></li>
								</c:if>
								<c:forEach var="num" begin="${page.startPage }" end="${page.endPage }">
									<li class="page-item ${page.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${num}">${num}</a></li>
								</c:forEach>
								<c:if test="${page.next}">
									<li class="page-item"><a class="page-link" href="${page.endPage + 1}"> 다음 <i class="fa fa-angle-right"></i></a></li>
								</c:if>
	
							</ul>
						</nav>
					</c:if>

					<form id='actionForm' action="${pageContext.request.contextPath}/booking/bookingList.do" method="get"> 
						<input type="hidden" name="bookTitle" value=""> 
						<input type="hidden" name="pageNum" value="${page.cri.pageNum}"> 
						<input type="hidden" name="amount" value="${page.cri.amount}"> 
					</form>



					
                </div>
			</div>
		</div>

    <!-- Booking Area End -->
<script>
	var actionForm = $('#actionForm'); 
	$('.page-item a').on('click', function(e) { e.preventDefault(); 
		//걸어둔 링크로 이동하는 것을 일단 막음 
		actionForm.find('input[name="pageNum"]').val($(this).attr('href')); 

		const url = new URL(window.location.href);
		const urlParams = url.searchParams;
		// console.log(urlParams.get('checkIn'));

		const checkIn = urlParams.get('checkIn');
		const checkOut = urlParams.get('checkOut');
		const bookTitle = urlParams.get('bookTitle');

		$('input[name=checkIn').attr('value', checkIn);
		$('input[name=checkOut').attr('value', checkOut);
		$('input[name=bookTitle').attr('value', bookTitle);

		actionForm.submit(); 
	});


</script>
	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
