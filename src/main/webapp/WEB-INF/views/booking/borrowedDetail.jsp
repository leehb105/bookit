<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />

<!-- <div class="container mx-3"> -->
<div class="roberto-contact-form-area wow fadeInUp section-padding-100" data-wow-delay="100ms">
    <div class="containe">
        <div class="row">
            <div class="col-2 ml-3">
                <div class="profile-work">
                    <p>나의 거래</p>
                    <hr class="my-2">
                    <a href="${pageContext.request.contextPath}/booking/myBooking.do?pageNum=1&amout=5">나의 대여 게시글</a>
                    <br />
                    <a href="${pageContext.request.contextPath}/booking/lentList.do?pageNum=1&amout=5">나의 대여 예약 관리</a>
                    <br />
                    <a href="${pageContext.request.contextPath}/booking/borrowedList.do?pageNum=1&amout=5"><strong>내가 빌린 도서</strong></a>
                </div>
            </div>

            <div class="col-6">
                <!-- Single Room Details Area -->
                <h4><a href="${pageContext.request.contextPath}/booking/borrowedList.do?pageNum=1&amout=5"> 내가 빌린 도서 </a>> 대여 예약 상세</h4>
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
                                    <td>도서 제공자</td>
                                    <td>${booking.member.nickname}(${booking.writer})</td>
                                </tr>
                                <tr>
                                    <td>대여 시작일</td>
                                    <td><fmt:formatDate value="${booking.bookReservation.startDate}" pattern="yyyy년 MM월 dd일"/></td>
                                </tr>
                                <tr>
                                    <td>대여 종료일</td>
                                    <td><fmt:formatDate value="${booking.bookReservation.endDate}" pattern="yyyy년 MM월 dd일"/></td>
                                </tr>
                                <tr>
                                    <td>대여 신청일</td>
                                    <td><fmt:formatDate value="${booking.bookReservation.regDate}" pattern="yyyy년 MM월 dd일"/></td>
                                </tr>
                               
                            </table>
                            
                                

                        </div>
                    </div>
                    <!-- Room Features -->
                    <div class="room-features-area d-flex flex-wrap mb-50">
                        <h6>대여 상태: <span>${booking.bookReservation.status}</span></h6>
                        <c:if test="${booking.bookReservation.status eq '반납완료'}">
                            <h6>반납완료일: <span><fmt:formatDate value="${booking.bookReservation.statusDate}" pattern="yyyy년 MM월 dd일" /></span></h6>
                        </c:if>
                        <c:if test="${booking.bookReservation.status eq '분실'}">
                            <h6>분실처리일: <span><fmt:formatDate value="${booking.bookReservation.statusDate}" pattern="yyyy년 MM월 dd일" /></span></h6>
                        </c:if>
                        <h6>보증금: <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.deposit }" />원</span></h6>
                        <h6>일 대여료: <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${booking.price }" />원</span></h6>
                    </div>

                </div>
                
            </div>
            <!-- 모달 -->
            <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">사용자 평가</h5>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">X</span>
                            </button>
                        </div>
                        <form:form method="post" id="reviewEnrollFrm">
                            <div class="modal-body" id="modalContent">
                                <h3 class="text-center">거래는 만족스러우셨나요?</h3>
                                <div class="star-rating space-x-4 mx-auto mt-40">
                                    <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
                                    <label for="5-stars" class="star pr-4">★</label>
                                    <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
                                    <label for="4-stars" class="star">★</label>
                                    <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
                                    <label for="3-stars" class="star">★</label>
                                    <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
                                    <label for="2-stars" class="star">★</label>
                                    <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
                                    <label for="1-star" class="star">★</label>
                                </div>
                               
                            </div>
                            <div class="modal-footer">
                                <button class="btn roberto-btn" type="button" id="enrollBtn" onclick="reviewEnroll();" data-dismiss="modal">점수 제출</button>
                                <input type="hidden" name="resNo" id="resNo" value="${booking.bookReservation.resNo}">
                                <input type="hidden" name="userId" id="userId" value="${booking.writer}">
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
            <div class="col-2">
                <!-- Hotel Reservation Area -->
                <div class="hotel-reservation--area mt-100">
                    <c:if test="${booking.bookReservation.status eq '반납완료' && count == 0}">
                        <form:form method="post" id="reviewForm">
                            <div class="col-12 mb-3">
                                <button type="button" class="btn btn-primary col-10 btn-lg" id="reviewBtn" onclick="openModal();">사용자 리뷰</button>
                            </div>
                            
                        </form:form>
                    </c:if>
                    <c:if test="${count == 1}">
                        <div class="col-12 mb-3">
                            <button type="button" class="btn btn-primary col-10 btn-lg" id="reviewBtn" onclick="openModal();" disabled>리뷰 등록 완료</button>
                        </div>
                    </c:if>
                    
                </div>
            </div>
        </div>	
    </div>
</div>

    <!-- Booking Area End -->
<script>
        
    const enrollBtn = document.getElementById('enrollBtn');

    $(document).ready(function() {
        enrollBtn.disabled = 'false'; 

        //별점 입력 체크
        $('input:radio[name=rating]').on('input', function() {

            //별점입력 안할시 버튼 제출 금지
            if(!$('input:radio[name=rating]').is(':checked')){
                enrollBtn.disabled = true;
            }else{
                enrollBtn.disabled = false; 
            }
        });


    });


    //모달에 리뷰 등록 출력
    function openModal(){

        $('#reviewModal').modal("show");

    }
    function reviewEnroll(){
        var url = `${pageContext.request.contextPath}/booking/userReviewEnroll.do`;
        $('#reviewEnrollFrm').attr("action", url);
        $('#reviewEnrollFrm').submit(); 
    }

 

</script>
	

    <!-- Partner Area End -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
