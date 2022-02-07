<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<!-- 등록 폼 시작 -->
    <div class="roberto-contact-form-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <!-- Section Heading -->
                    <div class="section-heading text-center wow fadeInUp" data-wow-delay="100ms">
                        <h5>등록할 책을 검색하세요</h5>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Form -->
                    <div class="roberto-contact-form">
                        <form action="${pageContext.request.contextPath}/booking/bookSearch.do" method="get">       
                            <div class="col-12 wow fadeInUp form-inline form-group" data-wow-delay="100ms">
                                <div class="col-lg-6">
                                    <input type="text" class="form-control" name="title" placeholder="책 이름을 입력하세요">
                                </div>
                                <div class="col-lg-3">
                                    <button type="submit" class="btn roberto-btn" formtarget="_blank">책 검색</button>
                                </div>                                    
                            </div>                         
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>














        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-lg-8">
                    <!-- Single Room Details Area -->
                    <div class="single-room-details-area mb-50">
                        <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="100ms">
                            
                            <form action="" class="nl-form">
                                <input type="text" class="form-control">
        
                            </form>
                            
                            
                            <img src="${booking.bookInfo.cover}" class="d-block w-40" alt="">
                            <div class="post-content">
                                <!-- booking Title -->
                                <a href="#" class="post-title">${booking.bookInfo.title }</a>
                                <!-- 분류 -->
                                <p>${booking.bookInfo.categoryName}</p>
                                <!-- 저자, 출판사, 출판일 -->
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td>저자</td>
                                        <td>${booking.bookInfo.author}</td>
                                    </tr>
                                    <tr>
                                        <td>출판사</td>
                                        <td>${booking.bookInfo.publisher}</td>
                                    </tr>
                                    <tr>
                                        <td>출판일</td>
                                        <td><fmt:formatDate value="${booking.bookInfo.pubdate }" pattern="yyyy년 MM월"/></td>
                                    </tr>
                                    <tr>
                                        <td>ISBN</td>
                                        <td>${booking.bookInfo.isbn13}</td>
                                    </tr>
                                    <tr>
                                        <td>쪽수</td>
                                        <td>${booking.bookInfo.itemPage} 쪽</td>
                                    </tr>
                                </table>
                                

                            </div>
                        </div>
                        <!-- Room Features -->
                        <div class="room-features-area d-flex flex-wrap mb-50">
                            <h6>책 상태: <span>${booking.bookStatus}</span></h6>
                            <h6>보증금: <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.deposit }" />원</span></h6>
                            <h6>일 대여료: <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.price }" />원</span></h6>

                        </div>

                        <h2>대여정보</h2>
                        <span>제공자</span>
                        <span>${booking.member.nickname}(${booking.member.id})</span>
                        <br>
                        <span>작성일 ${newDate}</span>

                        <p>${booking.content}</p>
                    </div>

                    
                </div>

                
            </div>
        </div>
    </div>

    <!-- Rooms Area End -->
<script>
 




</script>
	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
