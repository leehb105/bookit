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
                    <div class="section-heading text-left wow fadeInUp" data-wow-delay="100ms">
                        <h3>등록할 책을 검색하세요</h3>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Form -->
                    <div class="roberto-contact-form mb-50">
                        <!-- <form action="${pageContext.request.contextPath}/booking/bookSearch.do" method="get">        -->
                        <form method="get" id="searchFrm">       
                            <div class="col-12 wow fadeInUp form-inline form-group" data-wow-delay="100ms">
                                <div class="col-lg-6">
                                    <input type="text" class="form-control" name="title" id="title" placeholder="책 이름을 입력하세요">
                                </div>
                                <div class="col-lg-3">
                                    <button type="button" class="btn roberto-btn" id="searchBtn" onclick="openSearchWindow();">책 검색</button>
                                    <!-- <button type="submit" class="btn roberto-btn" formtarget="_blank">책 검색</button> -->
                                    <!-- <button type="button" class="btn roberto-btn" id="searchBtn">책 검색</button> -->
                                    <!-- <button type="button" class="btn roberto-btn" data-toggle="modal" data-target="#exampleModal">책 검색</button> -->
                                </div>                                    
                            </div>                         
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- 검색결과 -->
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-lg-12">
                    <!-- Single Room Details Area -->
                    <div class="single-room-details-area mb-50 wow fadeInUp">
                        <h3>책 정보 입력</h3>
                        <hr class="my-2">
                        <div class="single-blog-post d-flex align-items-center mt-5 mb-50 wow fadeInUp" data-wow-delay="100ms">
                            
                            <!-- <form action="" class="nl-form">
                                <input type="text" class="form-control" id="testInput">
        
                            </form> -->
                            
                            <img src="${pageContext.request.contextPath}/resources/img/book-photo.png" class="d-block w-40 mx-5" alt="" id="cover">
                            <div class="post-content mx-5">
                                <!-- booking Title -->
                                <a href="#" id="title"></a>
                                <p></p>
                                <!-- 분류 -->
                                <p id="categoryName"></p>
                                <!-- 저자, 출판사, 출판일 -->
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td>저자</td>
                                        <td id="author"></td>
                                    </tr>
                                    <tr>
                                        <td>출판사</td>
                                        <td id="publisher"></td>
                                    </tr>
                                    <tr>
                                        <td>출판일</td>
                                        <td id="pubdate"><fmt:formatDate value="" pattern="yyyy년 MM월"/></td>
                                    </tr>
                                    <tr>
                                        <td>ISBN</td>
                                        <td id="isbn"></td>
                                    </tr>
                                    <tr>
                                        <td>쪽수</td>
                                        <td id="itemPage"></td>
                                    </tr>
                                </table>
                                <input type="hidden" value="" id="description">

                            </div>
                        </div>
                        <!-- Room Features -->
                        <div class="room-features-area d-flex flex-wrap mb-50 ">
                            <table class="table text-center">
                                <tr>
                                    <td>상태</td>
                                    <td>보증금</td>
                                    <td>일당 대여료</td>
                                </tr>
                                <tr>
                                    <td>
                                        <select class="form-select" id="status">
                                            <option value="0" disabled selected>선택</option>
                                            <option value="1">최상</option>
                                            <option value="2">상</option>
                                            <option value="3">중</option>
                                            <option value="4">하</option>
                                            <option value="5">최하</option>
                                        </select>
                                    </td>
                                    <td>
                                        <div class="form-inline form-group">
                                            <input type="number" class="form-control" placeholder="보증금을 입력하세요" id="deposit" min="1" step="500" onKeyup="this.value=this.value.replace(/[^0-9]/g,'500');" required> &nbsp; <span> 원</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-inline form-group">
                                            <input type="number" class="form-control" placeholder="일일 대여료를 입력하세요" id="price" min="1" step="500" onKeyup="this.value=this.value.replace(/[^0-9]/g,'500');" required> &nbsp; <span> 원</span>
                                        </div>
                                    </td>
                                </tr>
                                    
                            
                            </table>

                        </div>

                        <h3>대여정보 입력</h3>
                        <hr class="my-2">
                        <textarea class="form-control" aria-label="With textarea" rows="7" placeholder="대여 정보에 관한 내용을 입력해주세요 :-)"></textarea>

                        <p>${booking.content}</p>
                    </div>

                    
                </div>

                
            </div>
        </div>
    </div>

    <!-- Rooms Area End -->
<script>
    // 검색 input
    const $title = $('input[name=title]');

    //책 검색 버튼 비활성화
    window.onload = function(){
        $('#searchBtn').attr("disabled", true);
        setInitBookInfo();
    }

    //검색창 입력시 검색 버튼 활성화
    $(function(){
        $title.on('input', function(){
            // console.log($title);
            if($title.val() != ''){
                $('#searchBtn').attr("disabled", false);
            }else{
                //입력값 없을 시 다시 버튼 비활성화
                $('#searchBtn').attr("disabled", true);
            }
        });
    });

    let childWin;
    // const searchFrm = document.getElementById('searchFrm');

    function openSearchWindow(){
        // window.name = "부모창 이름"; 
        window.name = "parentForm";

        let url = `${pageContext.request.contextPath}/booking/bookSearch.do`;
        var option = "width=570, height=350, resizable = no, scrollbars = no";
        
        //새탭으로 열기
        childWin = window.open('', "result", option);
        $("#searchFrm").attr("action", url);
        $("#searchFrm").attr("target", "result");
        $("#searchFrm").submit();

    }

    //자식창에서 호출할 json 페이지적용 함수
    window.getJson = function(){

        book = JSON.parse(localStorage.getItem("book"));
        if(isEmptyObj(book)){
            alert("책정보 없음 - 도서를 다시 선택해주세요.");
        }else if(!checkAllElement(book)){
            alert("해당 도서는 등록할 수 없습니다.");
        }else{
            const date = new Date(book.pubdate);
            const newDate = date.getFullYear() + '년 ' + (date.getMonth()+1) + '월';

            document.getElementById('cover').src = book.cover;
            document.getElementById('title').innerHTML = book.title;
            document.getElementById('author').innerHTML = book.author;
            document.getElementById('publisher').innerHTML = book.publisher;
            document.getElementById('pubdate').innerHTML = newDate;
            document.getElementById('isbn').innerHTML = book.isbn;
            document.getElementById('itemPage').innerHTML = book.itemPage + ' 쪽';
            document.getElementById('categoryName').innerHTML = book.categoryName;
            document.getElementById('description').innerHTML = book.description;
        }
    }

    //검색도서 적용 전 초기 서식
    function setInitBookInfo(){
        document.getElementById('title').innerHTML = '책의 제목입력이 필요합니다.';
        document.getElementById('author').innerHTML = '저자 입력이 필요합니다.';
        document.getElementById('publisher').innerHTML = '출판사 입력이 필요합니다.';
        document.getElementById('pubdate').innerHTML = '출판일 입력이 필요합니다.';
        document.getElementById('isbn').innerHTML = 'ISBN 입력이 필요합니다.';
        document.getElementById('itemPage').innerHTML = '페이지 입력이 필요합니다.';
        document.getElementById('categoryName').innerHTML = '카테고리 입력이 필요합니다.';
    }
    
    //도서 검색창 엔터 이벤트
    document.getElementById('title').addEventListener('keydown', function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            // console.log('엔터 눌림');
            if($title.val() != ''){
                // console.log('if문 진입');
                openSearchWindow();
            }
        };
    }, true);

    //json 객체 비어있는지 검사
    function isEmptyObj(obj){
        if(obj.constructor === Object
            && Object.keys(obj).length === 0)  {
            return true;
        }
        
        return false;
    }

    function checkAllElement(obj){
        //json객체 검사 시 비어있는 항목이 있는 경우 false 반환
        for(let i in obj){
            // console.log(obj[i]);
            if(obj[i] == ""){
                return false;
            }
        }        
        return true;
    }

    //보증금 0원에 대한 처리
    document.getElementById('deposit').addEventListener('keyup', function(){
        const deposit = document.getElementById('deposit');
        // console.log(Number(deposit.value), typeof Number(deposit.value));
        // console.log(deposit.value.length);

        if(deposit.value.length > 0){
            if(Number(deposit.value) <= 0){
                alert('보증금은 0원 보다 많아야 합니다.');
                deposit.value = 500;
            }
        }
        

    });


    //일일요금 0원에 대한 처리
    document.getElementById('price').addEventListener('keyup', function(){
        const price = document.getElementById('price');

        if(price.value.length > 0){
            if(Number(price.value) <= 0){
                alert('일일대여로는 0원 보다 많아야 합니다.');
                price.value = 500;
            }
        }

    });
    
    //책상태 입력에 대한 처리
    function checkBookStatus(){
        const status = $('#status option:selected').val();
        // console.log(status, typeof status);
        if(status == '0'){
            alert('책 상태를 선택해주세요');
        }

    }

    















    // //모달 오픈
    // const open = () => {
    //     document.querySelector(".modal").classList.remove("hidden");
    // }

    // //모달 클로즈
    // const close = () => {
    //     document.querySelector(".modal").classList.add("hidden");
    // }

    // document.querySelector(".btn").addEventListener("click", open);
    // // document.querySelector(".closeBtn").addEventListener("click", close);
    // document.querySelector(".bg").addEventListener("click", close);

    
    //책 검색 클릭
    // document.getElementById('searchBtn').onclick = (() =>{

    //     //모달 창 내부 초기화
    //     $(() =>{
    //         $('#query').text("\"\"");
    //         $('#totalResults').text(0); 
    //     });
    //     // console.log($div.find())

    //     // console.log('test');

    //     // $.ajax({
    //     //     url: `${pageContext.request.contextPath}/booking/bookSearch.do`,
    //     //     method: "GET",
    //     //     data: $('input[name=title]').serialize(),
    //     //     success(result){
    //     //         console.log(result);
    //     //         console.log(result.query);
    //     //         $('#query').text("\"" + result.query + "\"");
    //     //         $('#totalResults').text(result.totalResults);

    //     //         for(let i = 0; i < result.totalResults; i++){
    //     //             $('#resultArea').append(
    //     //                 "<div class='single-blog-post d-flex align-items-center mb-50 wow fadeInUp w-75' data-wow-delay='100ms'>" +
    //     //                     "<div class='post-thumbnail w-25'>" +
    //     //                         "<a href='#'><img src='" + result.list[i].cover +"' alt=''></a>" +
    //     //                     "</div>" +
    //     //                     "<div class='post-content'>" +
    //     //                         "<a href='' class='post-title'>" + + "</a>" +
    //     //                         "<p>${book.author} 저 | ${book.publisher} | <fmt:formatDate value='${book.pubdate }' pattern='yyyy년 MM월'/></p>" +
                                
    //     //                     "</div>" +
    //     //                 "</div>"
    //     //             );
    //     //         }


    //     //     },
    //     //     error: console.log()
    //     // });
    // });



</script>
	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
