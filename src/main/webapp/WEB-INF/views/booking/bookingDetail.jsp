<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                            <h6>상세주소: <span>${booking.member.jibunAddress}</span></h6>

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
                        &nbsp;&nbsp;
                        <span>${newDate}</span>
                        &nbsp;&nbsp;
                        
                        <div class="hotel-reservation--area m-3">
                            <p>${booking.content}</p>


                        </div>
                        
                    </div>
                    
                </div>

                <div class="col-12 col-lg-4">
                    <!-- Hotel Reservation Area -->
                    <div class="hotel-reservation--area mt-100">
                        <form:form method="post" id="resEnrollFrm">
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
                            <c:if test="${booking.member.id eq loginMember.id}">
                                <button type="button" class="btn roberto-btn w-100" id="bookingDeleteBtn" onclick="bookingDelete();">대여 삭제</button>
                            </c:if>
                            <c:if test="${booking.member.id ne loginMember.id}">
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

                            </c:if>
                            </div>
                            <input type="hidden" id="pay" name="pay" value="">
                            <input type="hidden" id="title" name="title" value="${booking.bookInfo.title}">
                            <input type="hidden" id="bookingMemberId" name="bookingMemberId" value="${booking.member.id}">
                            <!-- <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/> -->
							<input type="hidden" name="deposit" id="deposit" value="${booking.deposit}">
							<input type="hidden" id="price" value="${booking.price}">
                        </form:form>
                        <form:form method="post" id="bookingDeleteFrm">
                            <input type="hidden" name="boardNo" value="${booking.boardNo}">
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Rooms Area End -->
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

            //사용자가 날짜를 모두 입력해야 버튼 활성화
            let checkInDate = document.getElementById('checkIn').value;
            let checkOutDate = document.getElementById('checkOut').value;

            if(checkInDate != '' && checkOutDate != ''){
                console.log(checkInDate);
                console.log(checkOutDate);
                document.getElementById('bookResBtn').disabled = false;

            }
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

             //사용자가 날짜를 모두 입력해야 버튼 활성화
            let checkInDate = document.getElementById('checkIn').value;
            let checkOutDate = document.getElementById('checkOut').value;

            if(checkInDate != '' && checkOutDate != ''){
                console.log(checkInDate);
                console.log(checkOutDate);
                document.getElementById('bookResBtn').disabled = false;

            }
        });//datepicker end
    });


    let resStartDate = new Array();
    let resEndDate = new Array();
    window.onload = function(){
        // console.log('test');
        // console.log(resStartDate);
        // console.log("${startDateList}");

        document.getElementById('bookResBtn').disabled = true;


        //문자열 파싱
        let temp = "${startDateList}".replace('[', '');
        temp = temp.replace(']', '');
        resStartDate = temp.split(", ");

        temp = "${endDateList}".replace('[', '');
        temp = temp.replace(']', '');
        resEndDate = temp.split(", ");

        // console.log(resStartDate);
        // console.log(resEndDate);
        // for(let i = 0; i < resStartDate.length; i++){
        //     $('#checkIn').datepicker("option", "minDate", new Date(resStartDate[i]));
        //     // $("#edate").datepicker("option", "minDate", selectedDate);
        //     $('#checkOut').datepicker('setDatesDisabled', new Date(resEndDate[i]));

        // }
        
    };

    
    //대여 신청 버튼
    function bookResEnroll(){
        const userCash = `${loginMember.cash}`;
        console.log(userCash);
        let checkInDate = document.getElementById('checkIn').value;
        let checkOutDate = document.getElementById('checkOut').value;
        
        //대여 시작일과 종료일이 입력되었을 경우만
        if(checkInDate != '' && checkOutDate != ''){
            console.log(checkInDate);
            console.log(checkOutDate);


            checkInDate = new Date(checkInDate);
            checkOutDate = new Date(checkOutDate);

            const sec = checkOutDate.getTime() - checkInDate.getTime();
            //날짜 사이값
            const date = (sec / 1000 / 60 / 60 / 24) + 1;
            console.log(date);

            const deposit = Number(document.getElementById('deposit').value);
            const price = Number(document.getElementById('price').value);
            console.log(deposit);
            console.log(price);
            //최종 가격
            const pay = deposit + (price * date);
            console.log(pay);
            document.getElementById('pay').value = pay;

            //유저의 캐쉬가 지불가격보다 크거나 같다면
            if(userCash >= pay){
                let url = `${pageContext.request.contextPath}/booking/bookingReservation.do`;
                $("#resEnrollFrm").attr("action", url);
                $("#resEnrollFrm").submit();
            }else{
                //유저 캐쉬가 모자라다면
                alert('충전액이 모자랍니다.');
                location.href = `${pageContext.request.contextPath}/member/payments/charge.do`;
            }

            

            // const url = `${pageContext.request.contextPath}/booking/bookingReservation`;
            // $("#resEnrollFrm").attr("action", url);
            // $("#resEnrollFrm").submit();
        }


        // let url = `${pageContext.request.contextPath}/booking/bookSearch.do`;
        
        // //새탭으로 열기
        // $("#resEnrollFrm").attr("action", url);
        // $("#resEnrollFrm").attr("target", "result");
        // $("#resEnrollFrm").submit();


    }

    function bookingDelete(){
        let url = `${pageContext.request.contextPath}/booking/bookingDelete.do`;
        
        var delConfirm = confirm('대여글을 삭제하시겠습니까?');
        if (delConfirm) {
            $("#bookingDeleteFrm").attr("action", url);
            $("#bookingDeleteFrm").submit();
        }
        else {
            return;
        }

    }






// $(document).ready(function() {       
//     $('#datepicker1').datepicker({
//         format: "yyyy-mm-dd"	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
//         // ,startDate: '-10d'	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
//         // ,endDate: '+10d'	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
//         ,autoclose : true	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
//         ,calendarWeeks : false //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
//         ,clearBtn : false //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
//         // datesDisabled : ['2019-06-24','2019-06-26'],//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
//         // ,daysOfWeekDisabled : [0,6]	//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
//         // ,daysOfWeekHighlighted : [3] //강조 되어야 하는 요일 설정
//         ,disableTouchKeyboard : false	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
//         ,immediateUpdates: false	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
//         ,multidate : false //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
//         // multidateSeparator :",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
//         ,templates : {
//             leftArrow: '&laquo;'
//             ,rightArrow: '&raquo;'
//         } //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
//         ,showWeekDays : true // 위에 요일 보여주는 옵션 기본값 : true
//         ,title: "대여 시작일"	//캘린더 상단에 보여주는 타이틀
//         ,todayHighlight : true 	//오늘 날짜에 하이라이팅 기능 기본값 :false 
//         ,toggleActive : true	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
//         ,weekStart : 0 //달력 시작 요일 선택하는 것 기본값은 0인 일요일 
//         ,language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
//         ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
//         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
//         ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트


//         // dateFormat: 'yy-mm-dd' //Input Display Format 변경
//         // ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
//         // ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
//         // ,changeYear: true //콤보박스에서 년 선택 가능
//         // ,changeMonth: true //콤보박스에서 월 선택 가능                
//         // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
//         // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
//         // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
//         // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
//         // ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
//         // ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
//         // ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
//         // ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
//         // ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
//         // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
//         // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
        
//     }).on("show", function(e) {
//         //이벤트의 종류
//         //show : datePicker가 보이는 순간 호출
//         //hide : datePicker가 숨겨지는 순간 호출
//         //clearDate: clear 버튼 누르면 호출
//         //changeDate : 사용자가 클릭해서 날짜가 변경되면 호출 (개인적으로 가장 많이 사용함)
//         //changeMonth : 월이 변경되면 호출
//         //changeYear : 년이 변경되는 호출
//         //changeCentury : 한 세기가 변경되면 호출 ex) 20세기에서 21세기가 되는 순간
        
//         console.log(e);// 찍어보면 event 객체가 나온다.
//         //간혹 e 객체에서 date 를 추출해야 하는 경우가 있는데 
//         // e.date를 찍어보면 Thu Jun 27 2019 00:00:00 GMT+0900 (한국 표준시)
//     });//datepicker end
// });

// 찜 추가
function like(){
	document.getElementById('full').style.display = 'inline-block';
	document.getElementById('empty').style.display = 'none';
	
	var boardNo = $("input[id=bookingNo]").val();
	console.log(boardNo);
	$.ajax({
		url: `${pageContext.request.contextPath}/wishlist/wishlistEnroll.do`,
		type: "POST",
		data: {
			boardNo : boardNo
		},
		beforeSend : function(xhr){   
			/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		dataType: "json",
		success: function(data){
			if(data == 1) {
				alert("찜 등록되었습니다.");
			} 
			else {
				alert("다시 시도해주세요.");
			}
		},
		error: console.log
	});
}
// 찜 해제
function dislike(){
	document.getElementById('full').style.display = 'none';
	document.getElementById('empty').style.display = 'inline-block';
	
	var boardNo = $("input[id=bookingNo]").val();
	console.log(boardNo);
	$.ajax({
		url: `${pageContext.request.contextPath}/wishlist/wishlistCancel.do`,
		type: "POST",
		data: {
			boardNo : boardNo
		},
		beforeSend : function(xhr){   
			/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		dataType: "json",
		success: function(data){
			if(data == 1) {
				alert("찜 취소되었습니다.");
			} 
			else {
				alert("다시 시도해주세요.");
			}
		},
		error: console.log
	});
}


</script>
	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
