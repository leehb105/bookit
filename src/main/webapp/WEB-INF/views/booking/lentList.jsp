<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />


<div class="container member-profile">
	<div class="row">
		<div class="col-2">
			<div class="profile-work">
				<p>나의 거래</p>
                <hr class="my-2">
                <a href="${pageContext.request.contextPath}/booking/myBooking.do">나의 대여 게시글</a>
				<br />
				<a href="${pageContext.request.contextPath}/booking/borrowedList.do">나의 빌린 도서</a>
				<br />
				<a href="${pageContext.request.contextPath}/booking/lentList.do"><strong>나의 대여 게시글</strong></a>
			</div>
		</div>


		<!-- <div class="roberto-news-area section-padding-30-0"> -->
		<div class="col-10">
			<table class="table" style="text-align: center;">
				<thead>
					<tr>
						<th>번호</th>
						<th></th>
						<th>제목</th>
						<th>작가</th>
						<th>출판사</th>
						<th>책상태</th>
						<th>대여비</th>
						<th>대여 신청자</th>
						<th>대여기간</th>
						<th>거래상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${inquireList}" var="inquireList">
						<tr data-no="${inquireList.no}" class="selectInquire">
							<td>${inquireList.no}</td>
							<td>${inquireList.memberId}</td>
							<td>[${inquireList.category}] ${inquireList.title}</td>
							<td><fmt:formatDate value="${inquireList.regDate}" pattern="yyyy/MM/dd"/></td>
							<td>
								<c:choose>
									<c:when test="${inquireList.condition eq 0}">대기중</c:when>
									<c:when test="${inquireList.condition eq 1}"><strong style="color: #7add4e;">답변완료</strong></c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty inquireList}">
						<tr>
							<td colspan="5"><p>문의하신 내역이 없습니다.</p></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>	

</div>

	<!-- <c:if test="${!empty loginMember}">
		<div class="button-area mt-40">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<button type="button" class="btn roberto-btn w-10 float-right" onclick="location.href='bookingEnroll.do'">책 등록</button>
					</div>
	
				</div>
			</div>
		</div>

	</c:if> -->

	<!-- Booking Area Start -->
    
                    <!-- Single Booking List Area -->
				
					

					<!-- <hr class="my-2 wow fadeInUp"> -->
                    <!-- Pagination -->
                    <!-- <nav class="roberto-pagination wow fadeInUp mb-100" data-wow-delay="100ms">
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
                    </nav> -->

					<!-- <form id='actionForm' action="${pageContext.request.contextPath}/booking/bookingList.do" method="get"> 
						<input type="hidden" name="checkIn" value=""> 
						<input type="hidden" name="checkOut" value=""> 
						<input type="hidden" name="bookTitle" value=""> 
						<input type="hidden" name="pageNum" value="${page.cri.pageNum}"> 
						<input type="hidden" name="amount" value="${page.cri.amount}"> 
					</form> -->


					<!-- <div class="col-12">
							${pagebar}

					</div> -->
					

	

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
