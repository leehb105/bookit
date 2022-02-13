<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
// 컬렉션 불러오기(랜덤으로 3개). 475번줄 collection-area
$(document).ready(function(){
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	console.log(header);
	console.log(token);
	$.ajax({
		url: `${pageContext.request.contextPath}/collectionList.do`,
		method: "POST",
		dataType : 'json',
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success(collectionList){
        	console.log(collectionList);
			for(var i = 0; i < 3; i++){
				var no = collectionList[i].no;
				$(".collection-area").append(
					'<div class="col-12 col-md-6 col-lg-4">'
						+ '<div class="single-post-area mb-100 wow fadeInUp text-center" data-wow-delay="100ms">'
							+ '<a href="${pageContext.request.contextPath}/collection/collectionDetail.do?no=' + no + '" class="post-thumbnail">'
							+ ' <img class="w-50" src="' + collectionList[i].profileImage + '"'
							+ ' onerror="this.src=`${pageContext.request.contextPath}/resources/img/profile/default_profile.png`"/>'
							+ '</a>'
							+ '<h5 class="post-title">' + collectionList[i].nickname + '님의<br /></h5>'
							+ '<h6>' + collectionList[i].collectionName + '</h6>'
						+ '</div>'
					+ '</div>');
			}
		},
		error: console.log
	});
});
</script>

    <!-- Welcome Area Start -->
    <section class="welcome-area">
        <div class="welcome-slides owl-carousel">
            <!-- Single Welcome Slide -->
            <div class="single-welcome-slide bg-img bg-overlay" style="background-image: url(img/bg-img/16.jpg);" data-img-url="img/bg-img/16.jpg">
                <!-- Welcome Content -->
                <div class="welcome-content h-100">
                    <div class="container h-100">
                        <div class="row h-100 align-items-center">
                            <!-- Welcome Text -->
                            <div class="col-12">
                                <div class="welcome-text text-center">
                                    <h6 data-animation="fadeInLeft" data-delay="200ms">Rental &amp; Resale</h6>
                                    <h2 data-animation="fadeInLeft" data-delay="500ms">Welcome To Bookit</h2>
                                    <a href="#" class="btn roberto-btn btn-2" data-animation="fadeInLeft" data-delay="800ms">Discover Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Single Welcome Slide -->
            <!-- <div class="single-welcome-slide bg-img bg-overlay" style="background-image: url(img/bg-img/17.jpg);" data-img-url="img/bg-img/17.jpg">
                Welcome Content
                <div class="welcome-content h-100">
                    <div class="container h-100">
                        <div class="row h-100 align-items-center">
                            Welcome Text
                            <div class="col-12">
                                <div class="welcome-text text-center">
                                    <h6 data-animation="fadeInUp" data-delay="200ms">Rental &amp; Resale</h6>
                                    <h2 data-animation="fadeInUp" data-delay="500ms">Welcome To Bookit</h2>
                                    <a href="#" class="btn roberto-btn btn-2" data-animation="fadeInUp" data-delay="800ms">Discover Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            Single Welcome Slide
            <div class="single-welcome-slide bg-img bg-overlay" style="background-image: url(img/bg-img/18.jpg);" data-img-url="img/bg-img/18.jpg">
                Welcome Content
                <div class="welcome-content h-100">
                    <div class="container h-100">
                        <div class="row h-100 align-items-center">
                            Welcome Text
                            <div class="col-12">
                                <div class="welcome-text text-center">
                                    <h6 data-animation="fadeInDown" data-delay="200ms">Rental &amp; Resale</h6>
                                    <h2 data-animation="fadeInDown" data-delay="500ms">Welcome To Bookit</h2>
                                    <a href="#" class="btn roberto-btn btn-2" data-animation="fadeInDown" data-delay="800ms">Discover Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> -->
    </section>
    <!-- Welcome Area End -->

    <!-- About Us Area Start -->
    <section class="roberto-about-area section-padding-100-0">
        <!-- Hotel Search Form Area -->
        <div class="book-search-form-area">
            <div class="container-fluid">
                <div class="book-search-form">
                    <form
                        action="${pageContext.request.contextPath}/booking/bookingList.do"
                        method="get"
                        id="resfrm">
                        <div class="row justify-content-between align-items-end">
                            <div class="col-6 col-md-2 col-lg-3">
                                <label for="checkIn">대여 시작일</label>
                                <!-- <input type="date" class="form-control" id="checkIn" name="checkIn"> -->
                                <input type="text" class="input-small form-control" name="checkIn" id="checkIn" autocomplete="off" placeholder="대여 시작일">
                            </div>
                            <div class="col-6 col-md-2 col-lg-3">
                                <label for="checkOut">대여 종료일</label>
                                <!-- <input type="date" class="form-control" id="checkOut" name="checkOut"> -->
                                <input type="text" class="input-small form-control" name="checkOut" id="checkOut" autocomplete="off" placeholder="대여 종료일">
                            </div>
                            <div class="col-6 col-md-2 col-lg-3">
                            	<label for="bookTitle">책 제목</label>
                            	<input type="text" class="form-control" id="bookTitle" name="bookTitle" placeholder="책 제목을 입력하세요" autofocus>
                            </div>
                            <div class="col-12 col-md-3">
                                <button type="button" class="form-control btn roberto-btn w-100" onclick="checkInputDate();">Check Availability</button>
                                <!-- <button type="button" class="form-control btn roberto-btn w-100" >Check Availability</button> -->
                            </div>
                            <h2>${test}</h2>     
                        </div>
                        <input type="hidden" name="pageNum" value="1">
                        <input type="hidden" name="amount" value="1">
                    </form>
                </div>
            </div>
        </div>

        <!-- <div class="container mt-100">
            <div class="row align-items-center">
                <div class="col-12 col-lg-6">
                    Section Heading
                    <div class="section-heading wow fadeInUp" data-wow-delay="100ms">
                        <h6>About Us</h6>
                        <h2>Welcome to <br>Roberto Hotel Luxury</h2>
                    </div>
                    <div class="about-us-content mb-100">
                        <h5 class="wow fadeInUp" data-wow-delay="300ms">With over 340 hotels worldwide, NH Hotel Group offers a wide variety of hotels catering for a perfect stay no matter where your destination.</h5>
                        <p class="wow fadeInUp" data-wow-delay="400ms">Manager: <span>Michen Taylor</span></p>
                        <img src="img/core-img/signature.png" alt="" class="wow fadeInUp" data-wow-delay="500ms">
                    </div>
                </div>

                <div class="col-12 col-lg-6">
                    <div class="about-us-thumbnail mb-100 wow fadeInUp" data-wow-delay="700ms">
                        <div class="row no-gutters">
                            <div class="col-6">
                                <div class="single-thumb">
                                    <img src="img/bg-img/13.jpg" alt="">
                                </div>
                                <div class="single-thumb">
                                    <img src="img/bg-img/14.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="single-thumb">
                                    <img src="img/bg-img/15.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    About Us Area End

    Service Area Start
    <div class="roberto-service-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="service-content d-flex align-items-center justify-content-between">
                        Single Service Area
                        <div class="single-service--area mb-100 wow fadeInUp" data-wow-delay="100ms">
                            <img src="img/core-img/icon-1.png" alt="">
                            <h5>Transportion</h5>
                        </div>

                        Single Service Area
                        <div class="single-service--area mb-100 wow fadeInUp" data-wow-delay="300ms">
                            <img src="img/core-img/icon-2.png" alt="">
                            <h5>Reiseservice</h5>
                        </div>

                        Single Service Area
                        <div class="single-service--area mb-100 wow fadeInUp" data-wow-delay="500ms">
                            <img src="img/core-img/icon-3.png" alt="">
                            <h5>Spa Relaxtion</h5>
                        </div>

                        Single Service Area
                        <div class="single-service--area mb-100 wow fadeInUp" data-wow-delay="700ms">
                            <img src="img/core-img/icon-4.png" alt="">
                            <h5>Restaurant</h5>
                        </div>

                        Single Service Area
                        <div class="single-service--area mb-100 wow fadeInUp" data-wow-delay="900ms">
                            <img src="img/core-img/icon-1.png" alt="">
                            <h5>Bar &amp; Drink</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    Service Area End

    Our Room Area Start
    <section class="roberto-rooms-area">
        <div class="rooms-slides owl-carousel">
            Single Room Slide
            <div class="single-room-slide d-flex align-items-center">
                Thumbnail
                <div class="room-thumbnail h-100 bg-img" style="background-image: url(img/bg-img/16.jpg);"></div>

                Content
                <div class="room-content">
                    <h2 data-animation="fadeInUp" data-delay="100ms">Premium King Room</h2>
                    <h3 data-animation="fadeInUp" data-delay="300ms">400$ <span>/ Day</span></h3>
                    <ul class="room-feature" data-animation="fadeInUp" data-delay="500ms">
                        <li><span><i class="fa fa-check"></i> Size</span> <span>: 30 ft</span></li>
                        <li><span><i class="fa fa-check"></i> Capacity</span> <span>: Max persion 5</span></li>
                        <li><span><i class="fa fa-check"></i> Bed</span> <span>: King Beds</span></li>
                        <li><span><i class="fa fa-check"></i> Services</span> <span>: Wifi, Television, Bathroom</span></li>
                    </ul>
                    <a href="#" class="btn roberto-btn mt-30" data-animation="fadeInUp" data-delay="700ms">View Details</a>
                </div>
            </div>

            Single Room Slide
            <div class="single-room-slide d-flex align-items-center">
                Thumbnail
                <div class="room-thumbnail h-100 bg-img" style="background-image: url(img/bg-img/17.jpg);"></div>

                Content
                <div class="room-content">
                    <h2 data-animation="fadeInUp" data-delay="100ms">Best King Room</h2>
                    <h3 data-animation="fadeInUp" data-delay="300ms">125$ <span>/ Day</span></h3>
                    <ul class="room-feature" data-animation="fadeInUp" data-delay="500ms">
                        <li><span><i class="fa fa-check"></i> Size</span> <span>: 30 ft</span></li>
                        <li><span><i class="fa fa-check"></i> Capacity</span> <span>: Max persion 5</span></li>
                        <li><span><i class="fa fa-check"></i> Bed</span> <span>: King Beds</span></li>
                        <li><span><i class="fa fa-check"></i> Services</span> <span>: Wifi, Television, Bathroom</span></li>
                    </ul>
                    <a href="#" class="btn roberto-btn mt-30" data-animation="fadeInUp" data-delay="700ms">View Details</a>
                </div>
            </div>
        </div>
    </section>
    Our Room Area End

    Testimonials Area Start
    <section class="roberto-testimonials-area section-padding-100-0">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-md-6">
                    <div class="testimonial-thumbnail owl-carousel mb-100">
                        <img src="img/bg-img/10.jpg" alt="">
                        <img src="img/bg-img/11.jpg" alt="">
                    </div>
                </div>

                <div class="col-12 col-md-6">
                    Section Heading
                    <div class="section-heading">
                        <h6>Testimonials</h6>
                        <h2>Our Guests Love Us</h2>
                    </div>
                    Testimonial Slide
                    <div class="testimonial-slides owl-carousel mb-100">

                        Single Testimonial Slide
                        <div class="single-testimonial-slide">
                            <h5>âThis can be achieved by applying search engine optimization or popularly known as SEO. This is a marketing strategy which increases the quality and quantity of traffic flow to a particular website via search engines.â</h5>
                            <div class="rating-title">
                                <div class="rating">
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                </div>
                                <h6>Robert Downey <span>- CEO Deercreative</span></h6>
                            </div>
                        </div>

                        Single Testimonial Slide
                        <div class="single-testimonial-slide">
                            <h5>âLorem ipsum dolor sit amet, consectetur adipisicing elit. Necessitatibus delectus facilis molestias, error vitae praesentium quos eaque qui ea, tempore blanditiis sint reprehenderit, quaerat. Commodi ab architecto sit suscipit exercitationem!â</h5>
                            <div class="rating-title">
                                <div class="rating">
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                </div>
                                <h6>Akash Downey <span>- CEO Deercreative</span></h6>
                            </div>
                        </div>

                        Single Testimonial Slide
                        <div class="single-testimonial-slide">
                            <h5>âLorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor, ex quos. Alias a rem maiores, possimus dicta sit distinctio quis iusto!â</h5>
                            <div class="rating-title">
                                <div class="rating">
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                </div>
                                <h6>Downey Sarah <span>- CEO Deercreative</span></h6>
                            </div>
                        </div>

                        Single Testimonial Slide
                        <div class="single-testimonial-slide">
                            <h5>âLorem ipsum dolor sit amet, consectetur adipisicing elit. Labore sequi laboriosam fugit suscipit aspernatur, minima minus voluptatum, id ab atque similique ex earum. Magni.â</h5>
                            <div class="rating-title">
                                <div class="rating">
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                </div>
                                <h6>Robert Brown <span>- CEO Deercreative</span></h6>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    Testimonials Area End

    Projects Area Start
    <section class="roberto-project-area">
        Projects Slide
        <div class="projects-slides owl-carousel">
            Single Project Slide
            <div class="single-project-slide active bg-img" style="background-image: url(img/bg-img/5.jpg);">
                Project Text
                <div class="project-content">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                    </div>
                </div>
                Hover Effects
                <div class="hover-effects">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                        <p>I focus a lot on helping the first time or inexperienced traveler head out prepared and confident...</p>
                    </div>
                    <a href="#" class="btn project-btn">Discover Now <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                </div>
            </div>

            Single Project Slide
            <div class="single-project-slide bg-img" style="background-image: url(img/bg-img/6.jpg);">
                Project Text
                <div class="project-content">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                    </div>
                </div>
                Hover Effects
                <div class="hover-effects">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                        <p>I focus a lot on helping the first time or inexperienced traveler head out prepared and confident...</p>
                    </div>
                    <a href="#" class="btn project-btn">Discover Now <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                </div>
            </div>

            Single Project Slide
            <div class="single-project-slide bg-img" style="background-image: url(img/bg-img/7.jpg);">
                Project Text
                <div class="project-content">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                    </div>
                </div>
                Hover Effects
                <div class="hover-effects">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                        <p>I focus a lot on helping the first time or inexperienced traveler head out prepared and confident...</p>
                    </div>
                    <a href="#" class="btn project-btn">Discover Now <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                </div>
            </div>

            Single Project Slide
            <div class="single-project-slide bg-img" style="background-image: url(img/bg-img/8.jpg);">
                Project Text
                <div class="project-content">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                    </div>
                </div>
                Hover Effects
                <div class="hover-effects">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                        <p>I focus a lot on helping the first time or inexperienced traveler head out prepared and confident...</p>
                    </div>
                    <a href="#" class="btn project-btn">Discover Now <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                </div>
            </div>

            Single Project Slide
            <div class="single-project-slide bg-img" style="background-image: url(img/bg-img/9.jpg);">
                Project Text
                <div class="project-content">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                    </div>
                </div>
                Hover Effects
                <div class="hover-effects">
                    <div class="text">
                        <h6>Entertaiment</h6>
                        <h5>Racing Bike</h5>
                        <p>I focus a lot on helping the first time or inexperienced traveler head out prepared and confident...</p>
                    </div>
                    <a href="#" class="btn project-btn">Discover Now <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                </div>
            </div>
        </div>
    </section>
    Projects Area End

    <!-- Blog Area Start -->
    <section class="roberto-blog-area section-padding-100-0">
        <div class="container">
            <div class="row">
                <!-- Section Heading -->
                <div class="col-12">
                    <div class="section-heading text-center wow fadeInUp" data-wow-delay="100ms">
                        <h2>Book Collections</h2>
                        <button class="btn btn-link float-right" onclick="location.href='${pageContext.request.contextPath}/collection/collectionList.do';">More Collections</button>
                    </div>
                </div>
            </div>

            <div class="row collection-area">
                <!-- 스크립트로 컬렉션 리스트 불러오는 곳 -->
            </div>
        </div>
    </section>
    <!-- Blog Area End -->

    <!-- Call To Action Area Start
    <section class="roberto-cta-area">
        <div class="container">
            <div class="cta-content bg-img bg-overlay jarallax" style="background-image: url(img/bg-img/1.jpg);">
                <div class="row align-items-center">
                    <div class="col-12 col-md-7">
                        <div class="cta-text mb-50">
                            <h2>Contact us now!</h2>
                            <h6>Contact (+12) 345-678-9999 to book directly or for advice</h6>
                        </div>
                    </div>
                    <div class="col-12 col-md-5 text-right">
                        <a href="#" class="btn roberto-btn mb-50">Contact Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    Call To Action Area End

    Partner Area Start
    <div class="partner-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="partner-logo-content d-flex align-items-center justify-content-between wow fadeInUp" data-wow-delay="300ms">
                        Single Partner Logo
                        <a href="#" class="partner-logo"><img src="img/core-img/p1.png" alt=""></a>
                        Single Partner Logo
                        <a href="#" class="partner-logo"><img src="img/core-img/p2.png" alt=""></a>
                        Single Partner Logo
                        <a href="#" class="partner-logo"><img src="img/core-img/p3.png" alt=""></a>
                        Single Partner Logo
                        <a href="#" class="partner-logo"><img src="img/core-img/p4.png" alt=""></a>
                        Single Partner Logo
                        <a href="#" class="partner-logo"><img src="img/core-img/p5.png" alt=""></a>
                    </div>
                </div>
            </div>
        </div>
    </div> -->
    <!-- Partner Area End -->

<script>
//datdpicker 한글설정
    $(function() {
        $.fn.datepicker.dates['ko'] = {
            days: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
            daysShort: ["일", "월", "화", "수", "목", "금", "토"],
            daysMin: ["일", "월", "화", "수", "목", "금", "토"],
            months: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
            monthsShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
            today: "오늘",
            clear: "초기화",
            format: "yyyy-mm-dd",
            titleFormat: "yyyy년 MM월", /* Leverages same syntax as 'format' */
            weekStart: 0
        };
    });


    $(function() {
        //대여시작일 설정
        $('#checkIn').datepicker({
            format: 'yyyy-mm-dd' //달력 날짜 형태
            ,language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
            ,changeYear: true //option값 년 선택 가능
            ,changeMonth: true //option값  월 선택 가능                
            ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
            ,buttonText: "선택" //버튼 호버 텍스트              
            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            ,autoclose : true	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
            ,title: "대여 시작일"	//캘린더 상단에 보여주는 타이틀
            // ,showWeekDays : true // 위에 요일 보여주는 옵션 기본값 : true
            ,clearBtn : true //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
            // ,todayBtn : true //'오늘'버튼 활성화
            ,todayHighlight : true //오늘날짜 하이라이트 효과
            ,startDate : new Date() //오늘날짜 이전의 날짜는 선택 불가

        })
        .on("show", function(e) {
            //이벤트의 종류
            //show : datePicker가 보이는 순간 호출
            //hide : datePicker가 숨겨지는 순간 호출
            //clearDate: clear 버튼 누르면 호출
            //changeDate : 사용자가 클릭해서 날짜가 변경되면 호출 (개인적으로 가장 많이 사용함)
            //changeMonth : 월이 변경되면 호출
            //changeYear : 년이 변경되는 호출
            //changeCentury : 한 세기가 변경되면 호출 ex) 20세기에서 21세기가 되는 순간
            
            console.log(e);// 찍어보면 event 객체가 나온다.
            //간혹 e 객체에서 date 를 추출해야 하는 경우가 있는데 
            // e.date를 찍어보면 Thu Jun 27 2019 00:00:00 GMT+0900 (한국 표준시)
        });//datepicker end

    });

    $(function() {
        //대여 종료일 설정
        $('#checkOut').datepicker({
            format: 'yyyy-mm-dd' //달력 날짜 형태
            ,language : 'ko'	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
            ,changeYear: true //option값 년 선택 가능
            ,changeMonth: true //option값  월 선택 가능                
            ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
            ,buttonText: "선택" //버튼 호버 텍스트              
            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트 
            ,autoclose : true	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
            ,title: "대여 종료일"	//캘린더 상단에 보여주는 타이틀
            // ,showWeekDays : true // 위에 요일 보여주는 옵션 기본값 : true
            ,minDate: 0 //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,clearBtn : true //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
            // ,todayBtn : true //'오늘'버튼 활성화
            ,todayHighlight : true //오늘날짜 하이라이트 효과
            ,startDate : new Date() //오늘날짜 이전의 날짜는 선택 불가

        })
        .on("show", function(e) {
            //이벤트의 종류
            //show : datePicker가 보이는 순간 호출
            //hide : datePicker가 숨겨지는 순간 호출
            //clearDate: clear 버튼 누르면 호출
            //changeDate : 사용자가 클릭해서 날짜가 변경되면 호출 (개인적으로 가장 많이 사용함)
            //changeMonth : 월이 변경되면 호출
            //changeYear : 년이 변경되는 호출
            //changeCentury : 한 세기가 변경되면 호출 ex) 20세기에서 21세기가 되는 순간
            
            console.log(e);// 찍어보면 event 객체가 나온다.
            //간혹 e 객체에서 date 를 추출해야 하는 경우가 있는데 
            // e.date를 찍어보면 Thu Jun 27 2019 00:00:00 GMT+0900 (한국 표준시)
        });//datepicker end
    });













    function checkInputDate() {

        const resfrm = document.getElementById("resfrm");
        resfrm.submit();

    //     const checkIn = document.getElementById("checkIn");
    //     const checkOut = document.getElementById("checkOut");
    //     const $bookTitle = $(bookTitle);
    //     const resfrm = document.getElementById("resfrm");
    //     // console.log(checkIn);
    //     // console.log(checkOut);
    //     // console.log(new Date());

    //     //날짜 객체 생성
    //     let startDate = new Date(checkIn.value);
    //     let endDate = new Date(checkOut.value);

    //     if(startDate < new Date()){
    //         alert("오늘보다 이전 날짜는 선택할 수 없습니다.");
    //         //대여시작일 오늘날짜로 변경
    //         checkIn.value = getFormatDate();
    //     }else if (checkIn.value == '' || checkOut.value == '') {
    //         alert("대여 기간을 선택하세요.");
    //         //대여시작일 오늘날짜로 변경
    //         checkIn.value = getFormatDate();
    //     }else if(startDate.getTime() > endDate.getTime()){
    //         alert("대여시작일이 예약 마지막일보다 후일 수 없습니다. ");
    //         //마지막일 초기화
    //         checkOut.value = '';
    //     }
    //     else if($bookTitle.val() == ''){
    //         alert("대여할 책의 제목을 입력하세요.");
    //         //커서 이동
    //         $bookTitle.focus();
    //     }else{
    //         //체크 완료후 제출
    //         resfrm.submit();
    //     }
    // }
    // //오늘날짜 포멧함수
    // function getFormatDate(){
    //     const date = new Date();
    //     //날짜 포멧 ex) 2022-01-01
    //     const today = date.getFullYear() + '-' + (("00"+(date.getMonth()+1).toString()).slice(-2)) + '-' + (("00"+date.getDate().toString()).slice(-2));
    //     return today;
    }



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
 