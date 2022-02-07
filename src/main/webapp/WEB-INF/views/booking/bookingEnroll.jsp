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
                    <div class="roberto-contact-form mb-30">
                        <!-- <form action="${pageContext.request.contextPath}/booking/bookSearch.do" method="get">        -->
                        <form method="get" id="searchFrm">       
                            <div class="col-12 wow fadeInUp form-inline form-group" data-wow-delay="100ms">
                                <div class="col-lg-6">
                                    <input type="text" class="form-control" name="title" placeholder="책 이름을 입력하세요">
                                </div>
                                <div class="col-lg-3">
                                    <button type="button" class="btn roberto-btn" id="searchBtn" onclick="openSearchWindow()">책 검색</button>
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
                <div class="col-12 col-lg-8">
                    <!-- Single Room Details Area -->
                    <div class="single-room-details-area mb-50">
                        <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="100ms">
                            
                            <!-- <form action="" class="nl-form">
                                <input type="text" class="form-control" id="testInput">
        
                            </form> -->
                            
                            <img src="${pageContext.request.contextPath}/resources/img/book-photo.png" class="d-block w-40 mx-5" alt="" id="cover">
                            <div class="post-content mx-5">
                                <!-- booking Title -->
                                <a href="#" class="title"></a>
                                <!-- 분류 -->
                                <p class="categoryName"></p>
                                <!-- 저자, 출판사, 출판일 -->
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td>저자</td>
                                        <td class="author"></td>
                                    </tr>
                                    <tr>
                                        <td>출판사</td>
                                        <td class="publisher"></td>
                                    </tr>
                                    <tr>
                                        <td>출판일</td>
                                        <td class="pubdate"><fmt:formatDate value="" pattern="yyyy년 MM월"/></td>
                                    </tr>
                                    <tr>
                                        <td>ISBN</td>
                                        <td class="isbn"></td>
                                    </tr>
                                    <tr>
                                        <td>쪽수</td>
                                        <td class="itemPage"></td>
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
    // 검색 input
    const $title = $('input[name=title]');

    //책 검색 버튼 비활성화
    window.onload = function(){
        $('#searchBtn').attr("disabled", true);
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
        
        childWin = window.open('', "result", option);
        $("#searchFrm").attr("action", url);
        $("#searchFrm").attr("target", "result");
        $("#searchFrm").submit();

    }

    window.getJson = function(){
        // console.log('자식창에서 열었음');

        book = JSON.parse(localStorage.getItem("book"));
        // console.log(isEmptyObj(book));
        if(isEmptyObj(book)){
            // console.log("null입니다.");
            alert("책정보 없음 - 도서를 다시 선택해주세요.");
        }else if(!checkAllElement(book)){
            alert("해당 도서는 등록할 수 없습니다.");
        }else{
            document.getElementById('cover').src = book.cover;
            document.getElementById('title').html(book.title);
            document.getElementById('author').text(book.author);


        }
    }


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
