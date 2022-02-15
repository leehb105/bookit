<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="https://kit.fontawesome.com/01809a491f.js" crossorigin="anonymous"></script>
<sec:authentication property="principal" var="loginMember"/>

	<!-- Rooms Area Start -->
    <div class="roberto-rooms-area section-padding-100-0 wow fadeInUp" data-wow-delay="100ms">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-8">
                    <!-- Single Room Details Area -->
                    <h3>도서 상세 정보</h3>
                    <hr class="my-2">
                    <div class="single-room-details-area mt-30 mb-50">
                        <div class="single-blog-post d-flex align-items-center mb-50">
                            <a href="${pageContext.request.contextPath}/search/bookDetail.do?isbn=${booking.bookInfo.isbn13}">
                                <img src="${booking.bookInfo.cover}" class="d-block w-40 mr-30" alt="">
                            </a>
                            <div class="post-content">
                                <!-- booking Title -->
                                <a href="${pageContext.request.contextPath}/search/bookDetail.do?isbn=${booking.bookInfo.isbn13}" class="post-title">${booking.bookInfo.title }</a>
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

                        <h3>대여정보</h3>
                        <hr class="my-2">

                        <c:if test="${booking.member.profileImage eq null}">
                            <img src="${pageContext.request.contextPath}/resources/img/profile/default_profile.png" alt="author" style="width: 10%;">
                            </c:if>
                        <c:if test="${booking.member.profileImage ne null}">
                            <img src="${pageContext.request.contextPath}/resources/img/profile/${review.member.profileImage}" alt="author">
                        </c:if>

                        <span>
                            ${booking.member.nickname}(${booking.member.id})
                        </span>
                         &nbsp; 작성일 <span>${newDate}</span>
                        
                        <div class="hotel-reservation--area m-3">
                            <p>${booking.content}</p>


                        </div>
                        
                    </div>
                    
                </div>

                <div class="col-12 col-lg-4">
                    <!-- Hotel Reservation Area -->
                    <div class="hotel-reservation--area mt-100">
                        <form th:action method="post" id="resEnrollFrm">
                        	<div>
                        		<input type="hidden" id="bookingNo" name="boardNo" value="${booking.boardNo}"/>
                        		<c:if test="${wishlistCount eq 0}">
									<h3 id="empty" style="display: inline-block;"><a href="#" onclick="like();" ><i class="far fa-heart" ></i></a></h3>
									<h3 id="full" style="display: none"><a href="#" onclick="dislike();"><i class="fas fa-heart"></i></a></h3>
								</c:if>
								<c:if test="${wishlistCount eq 1}">
									<h3 id="empty" style="display: none;"><a href="#" onclick="like();" ><i class="far fa-heart" ></i></a></h3>
									<h3 id="full" style="display: inline-block"><a href="#" onclick="dislike();"><i class="fas fa-heart"></i></a></h3>
								</c:if>
							</div>
                            <label for="checkInDate">대여일자</label>
                            <div class="row no-gutters">
                                <div class="col-6">
                                    <input type="text" class="input-small form-control" name="checkIn" id="checkIn" autocomplete="off" placeholder="대여 시작일">
                                </div>
                                <div class="col-6">
                                    <input type="text" class="input-small form-control" name="checkOut" id="checkOut" autocomplete="off" placeholder="대여 종료일">
                                </div>
                            </div>
                            <div class="form-group mt-30">
                                <button type="button" class="btn roberto-btn w-100" id="bookResBtn" onclick="bookResEnroll();">대여 신청</button>
                            </div>
                            <input type="hidden" id="pay" name="pay" value="">
                            <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
                        </form>
                        <input type="hidden" id="deposit" value="${booking.deposit}">
                        <input type="hidden" id="price" value="${booking.price}">
                        
                        
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
