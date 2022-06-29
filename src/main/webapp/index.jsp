<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/collectionImage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
// 인터파크 베스트셀러
$(() => {
    const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: "http://book.interpark.com/api/bestSeller.api",
		data: {
			key: "4CF11621757EDF17D8BA21B59906CE5911022255FF90339036F0FC3ADF91AA8E",
			categoryId: 100,
			output: "json"
		},
		dataType: "jsonp",
		contentType: "javascript/jsonp; charset=utf-8",
		headers: headers,
		success(data){
			//console.log(data);
			const item = data.item;
			//console.log(item);
			for(var i = 0; i < item.length; i++){
				const title = item[i].title;
				const author = item[i].author;
				const coverSmallUrl = item[i].coverSmallUrl;
				// console.log(title, author, coverSmallUrl);
				$(".interpark").before(
					'<div class="mt-1 d-flex align-items-center">'
					+ 	'<span class="ml-50">' + (i + 1) + '</span>'
					+ 	'<img class="mr-50 ml-5" src="' + coverSmallUrl + '" style="display: inline-block; width: 15%" />'
					+ 	'<table class="table table-borderless table-sm ml-4 align-middle">'
					+		'<tr>'
					+			'<td><small><strong>' + title + '</strong></small></td>'
					+		'</tr>'
					+		'<tr>'
					+			'<td><small>' + author + '</small></td>'
					+		'</tr>'
					+ 	'</table>'
					+ '</div>'
				);
				if(i == 7){
					break;
				}
			}
		},
		error: console.log
	});
});

// 알라딘 베스트셀러
$(() => {
    const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	$.ajax({
		url: "http://www.aladin.co.kr/ttb/api/ItemList.aspx",
		data: {
			ttbkey: "ttbdbqjqdyd1752002",
			QueryType: "Bestseller",
			MaxResults: 7,
			start: 1,
			SearchTarget: "Book",
			output: "js",
			Version: "20131101"
		},
		dataType: "jsonp",
		contentType: "javascript/jsonp; charset=utf-8",
		headers: headers,
		success(data){
			// console.log(data);
			const item = data.item;
			// console.log(item);
			for(var i = 0; i < item.length; i++){
				const title = item[i].title;
				const author = item[i].author;
				const cover = item[i].cover;
				// console.log(title, author, cover);
				$(".aladin").before(
					'<div class="mt-1 d-flex align-items-center">'
					+ 	'<span class="ml-50">' + (i + 1) + '</span>'
					+ 	'<img class="mr-50 ml-5" src="' + cover + '" style="display: inline-block; width: 15%" />'
					+ 	'<table class="table table-borderless table-sm ml-4 align-middle">'
					+		'<tr>'
					+			'<td><small><strong>' + title + '</strong></small></td>'
					+		'</tr>'
					+		'<tr>'
					+			'<td><small>' + author + '</small></td>'
					+		'</tr>'
					+ 	'</table>'
					+ '</div>'
				);
			}
		},
		error: console.log
	});
});

//베스트 관심책(BOOKIT)
$(document).ready(function(){
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	// console.log(header);
	// console.log(token);
	$.ajax({
		url: `${pageContext.request.contextPath}/bestWishBook.do`,
		method: "POST",
		dataType : 'json',
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success(wishlist){
        	// console.log(wishlist);
				$(".bookit").before(
					'<div class="mb-4" style="padding-top: 110px">'
						+  '<img class="mr-100 ml-100" src="' + wishlist.cover + '" style="display: inline-block; width: 50%" />'
							+ '<div style="padding-top: 50px; text-align: center;">'
								+ '<h6><strong>' + wishlist.title + '</strong></h6>'
								+ '<h6>' + wishlist.author + '</h6>'
							+ '</div>'
					+ '</div>');
		},
		error: console.log
	});
});

// 컬렉션 불러오기(랜덤으로 3개). 475번줄 collection-area
$(document).ready(function(){
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	// console.log(header);
	// console.log(token);
	$.ajax({
		url: `${pageContext.request.contextPath}/collectionList.do`,
		method: "POST",
		dataType : 'json',
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success(collectionList){
        	// console.log(collectionList);
			for(var i = 0; i < 3; i++){
				var no = collectionList[i].no;
				$(".collection-area").append(
					'<div class="col-12 col-md-6 col-lg-4">'
						+ '<div class="single-post-area mb-100 wow fadeInUp text-center" data-wow-delay="100ms">'
							+ '<div class="collectionImage mb-4">'
								+ '<a href="${pageContext.request.contextPath}/collection/collectionDetail.do?no=' + no + '">'
									+ ' <img src="${pageContext.request.contextPath}/resources/img/profile/' + collectionList[i].profileImage + '"'
									+ ' onerror="this.src=`${pageContext.request.contextPath}/resources/img/profile/default_profile.png`"/>'
								+ '</a>'
							+ '</div>'
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
            <!-- <div class="single-welcome-slide bg-img bg-overlay" style="background-image: url(img/bg-img/16.jpg);" data-img-url="img/bg-img/16.jpg"> -->
            <div class="single-welcome-slide bg-img">
                <!-- Welcome Content -->
                <div class="welcome-content h-100">
                    <div class="container h-100">
                        <div class="row h-100 align-items-center">
                            <!-- Welcome Text -->
                            <div class="col-12">
                                <div class="welcome-text text-center">
                                    <h6 data-animation="fadeInLeft" data-delay="200ms">도서 대여 &amp; 중고거래</h6>
                                    <h2 data-animation="fadeInLeft" data-delay="500ms">Welcome To Bookit</h2>
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
            </div> -->
        </div>
    </section>
    <!-- Welcome Area End -->


    <!-- Booking Area Start -->
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
                            <!-- <div class="col-6 col-md-2 col-lg-3">
                                <label for="checkIn">대여 시작일</label>
                                <input type="text" class="input-small form-control" name="checkIn" id="checkIn" autocomplete="off" placeholder="대여 시작일">
                            </div>
                            <div class="col-6 col-md-2 col-lg-3">
                                <label for="checkOut">대여 종료일</label>
                                <input type="text" class="input-small form-control" name="checkOut" id="checkOut" autocomplete="off" placeholder="대여 종료일">
                            </div> -->
                            <div class="col-12 col-md-9 col-lg-9">
                            	<label for="bookTitle">책 제목</label>
                            	<input type="text" class="form-control" id="bookTitle" name="bookTitle" placeholder="대여할 책 제목을 입력하세요" autofocus>
                            </div>
                            <div class="col-12 col-md-3">
                                <button type="button" class="form-control btn roberto-btn w-100" id="searchBtn" onclick="checkInputDate();">대여 도서 검색</button>
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
    <!-- Booking Area End -->


    <!-- BestSeller Area Start -->
    <section class="roberto-project-area">
        <!-- Projects Slide -->
        <div class="projects-slides owl-carousel">
            <!-- Single Project Slide -->
            <div class="single-project-slide" style="background-image: url(resources/img/bg-img/aladin_logo.png);" data-img-url="resources/img/bg-img/aladin_logo.png">
            	<!-- script append -->
                <!-- Project Text -->
                <div class="aladin project-content">
                    <div class="text">
                        <h6>알라딘</h6>
                        <h5>Best Seller</h5>
                    </div>
                </div>
            </div>

            <!-- Single Project Slide -->
            <div class="single-project-slide" style="background-color: #F5F5F5;">
                <!-- Project Text -->
                <div class="bookit project-content">
                    <div class="text">
                        <h6>BOOKIT</h6>
                        <h5>Best</h5>
                    </div>
                </div>
            </div>

            <!-- Single Project Slide -->
            <div class="single-project-slide" style="background-image: url(resources/img/bg-img/interpark_logo.png);" data-img-url="resources/img/bg-img/interpark_logo.png">
            	
                <!-- Project Text -->
                <div class="interpark project-content">
                    <div class="text">
                        <h6>인터파크</h6>
                        <h5>Best Seller</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- BestSeller Area End -->


    <!-- Collection Area Start -->
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
    <!-- Collection Area End -->


<script>
    //도서 명 input
    const bookTitle = document.getElementById('bookTitle');
    const searchBtn = document.getElementById('searchBtn');
    window.onload = function(){
        //버튼 죽여놓음
        searchBtn.disabled = true;
    };

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

    //기본값 오늘날짜 설정
    let startDate = new Date();
    let endDate = new Date();
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
        .on('changeDate', function(e){
            // console.log(e.date, typeof e.date);
            endDate = e.date; //선택한 날짜를 대입
            //대여 시작일보다 전날짜를 대여종료일에서 선택할 수 없음
            $('#checkOut').datepicker('setStartDate', endDate);

            //종료일보다 시작일이 후라면 자동으로 시작일로 날짜 변경
            if($('#checkOut').val() != ''){
                if($('#checkIn').val() > $('#checkOut').val()){
                    $('#checkIn').datepicker('setDate', new Date($('#checkOut').val()));
                }
            }

            if($('#bookTitle').val() != '' && $('#checkIn').val() != '' && $('#checkOut').val() != ''){
                $('#searchBtn').attr("disabled", false);
            }else{
                //입력값 없을 시 다시 버튼 비활성화
                $('#searchBtn').attr("disabled", true);
            }
            
        });;//datepicker end

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
        // .on("show", function(e) {
        //     //이벤트의 종류
        //     //show : datePicker가 보이는 순간 호출
        //     //hide : datePicker가 숨겨지는 순간 호출
        //     //clearDate: clear 버튼 누르면 호출
        //     //changeDate : 사용자가 클릭해서 날짜가 변경되면 호출 (개인적으로 가장 많이 사용함)
        //     //changeMonth : 월이 변경되면 호출
        //     //changeYear : 년이 변경되는 호출
        //     //changeCentury : 한 세기가 변경되면 호출 ex) 20세기에서 21세기가 되는 순간
            
        //     console.log(e);// 찍어보면 event 객체가 나온다.
        //     //간혹 e 객체에서 date 를 추출해야 하는 경우가 있는데 
        //     // e.date를 찍어보면 Thu Jun 27 2019 00:00:00 GMT+0900 (한국 표준시)
        // })
        .on('changeDate', function(e){
            startDate = e.date; //선택한 날짜를 대입
            //대여 종료일보다 이후 날짜를 대여 시작일에서 선택할 수 없음
            $('#checkIn').datepicker('setEndDate', startDate);
    
            //시작일보다 전날짜를 선택하면 자동으로 시작일로 날짜 변경
            if($('#checkIn').val() > $('#checkOut').val()){
                $('#checkOut').datepicker('setDate', new Date($('#checkIn').val()));
            }

            if($('#bookTitle').val() != '' && $('#checkIn').val() != '' && $('#checkOut').val() != ''){
                $('#searchBtn').attr("disabled", false);
            }else{
                //입력값 없을 시 다시 버튼 비활성화
                $('#searchBtn').attr("disabled", true);
            }


        });//datepicker end
    });

    
    function checkInputDate() {

        const resfrm = document.getElementById("resfrm");

        //입력이 되었을때만
        if(bookTitle.value != ''){
            resfrm.submit();

        }

    }
    //도서입력 체크
    $(function(){
        $('#bookTitle').on('input', function(){
            if($('#bookTitle').val() != '' && $('#checkIn').val() != '' && $('#checkOut').val() != ''){
                $('#searchBtn').attr("disabled", false);
            }else{
                //입력값 없을 시 다시 버튼 비활성화
                $('#searchBtn').attr("disabled", true);
            }
        });
    });
    // //대여시작일 체크
    // $(function(){
    //     $('#checkIn').on('input', function(){
    //         if($('#bookTitle').val() != '' && $('#checkIn').val() != '' && $('#checkOut').val() != ''){
    //             $('#searchBtn').attr("disabled", false);
    //         }else{
    //             //입력값 없을 시 다시 버튼 비활성화
    //             $('#searchBtn').attr("disabled", true);
    //         }
    //     });
    // });
    // //대여 종료일 체크
    // $(function(){
    //     $('#checkOut').on('input', function(){
    //         if($('#bookTitle').val() != '' && $('#checkIn').val() != '' && $('#checkOut').val() != ''){
    //             $('#searchBtn').attr("disabled", false);
    //         }else{
    //             //입력값 없을 시 다시 버튼 비활성화
    //             $('#searchBtn').attr("disabled", true);
    //         }
    //     });
    // });


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
 