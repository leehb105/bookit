<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />


<!-- <div class="container mx-3"> -->
<div class="roberto-contact-form-area wow fadeInUp section-padding-100" data-wow-delay="100ms">
    <div class="containe-fluid">
        <div class="row">
            <div class="col-2 ml-3">
                <div class="profile-work">
                    <p>나의 거래</p>
                    <hr class="my-2">
                    <a href="${pageContext.request.contextPath}/booking/myBooking.do?pageNum=1&amout=5"><strong>나의 대여 게시글</strong></a>
                    <br />
                    <a href="${pageContext.request.contextPath}/booking/lentList.do?pageNum=1&amout=5">나의 대여 예약 관리</a>
                    <br />
                    <a href="${pageContext.request.contextPath}/booking/borrowedList.do?pageNum=1&amout=5">내가 빌린 도서</a>
                </div>
            </div>


            <!-- <div class="roberto-news-area section-padding-30-0"> -->
            <div class="col-9">
                <table class="table align-middle table-hover" style="text-align: center;">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th colspan="2">제목</th>
                            <th>작가</th>
                            <th>출판사</th>
                            <th>책상태</th>
                            <th>보증금</th>
                            <th>대여비</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="booking" varStatus="status">
                            <tr onclick="location.href='${pageContext.request.contextPath}/booking/bookingDetail.do?bno=${booking.boardNo}'" style="cursor:pointer;">
                                <td class="align-middle">${page.total - ((page.cri.pageNum - 1) * page.cri.amount) - status.index}</td>
                                <td class="align-middle"><img src="${booking.bookInfo.cover}" alt="" style="width: 30%;"></td>
                                
                                <td class="title align-middle" style="text-align: left;">${booking.bookInfo.title}</td>
                                <td class="author align-middle">
                                    ${booking.bookInfo.author}
                                </td>
                                <td class="align-middle">${booking.bookInfo.publisher}</td>
                                <td class="align-middle">${booking.bookStatus}</td>
                                <td class="align-middle"><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.deposit }" />원</td>
                                <td class="align-middle"><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.price }" />원</td>

                            </tr>

                        </c:forEach>
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="8"><p>작성하신 대여 도서가 없습니다.</p></td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                <!-- Pagination -->
                <nav class="roberto-pagination mb-100">
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

                <form id='actionForm' action="${pageContext.request.contextPath}/booking/myBooking.do" method="get"> 
                    <input type="hidden" name="pageNum" value="${page.cri.pageNum}"> 
                    <input type="hidden" name="amount" value="${page.cri.amount}"> 
                </form>
            </div>

        </div>	
    </div>
</div>

    <!-- Booking Area End -->
<script>
        
    window.onload = function(){
        const title = document.getElementsByClassName('title');
        const author = document.getElementsByClassName('author');
        console.log(title.length);
        for(let i = 0; i < title.length; i++){
            if(title[i].innerHTML.includes('-')){
                //- 하이픈(부제) 있을시에 자르기
                title[i].innerHTML = title[i].innerHTML.substr(0, title[i].innerHTML.indexOf('-'));
            }
            if(author[i].innerHTML.includes('(지은이)')){
                //작가명 (지은이)뒤로 자름 -> 뒤는 엮은이임
                author[i].innerHTML = author[i].innerHTML.substr(0, author[i].innerHTML.indexOf('(지은이)'));
            }
            
        }

    };
	
    var actionForm = $('#actionForm'); 
	$('.page-item a').on('click', function(e) { e.preventDefault(); 
		//걸어둔 링크로 이동하는 것을 일단 막음 
		actionForm.find('input[name="pageNum"]').val($(this).attr('href')); 
		actionForm.submit(); 
	});







</script>
	

    <!-- Partner Area End -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
