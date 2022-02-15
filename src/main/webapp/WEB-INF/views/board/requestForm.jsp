<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/community.css" />
	
	
<script>
function goRequestList(){
	location.href = "${pageContext.request.contextPath}/board/request.do";
}
//검색어 value값 체크
function checkTitle(){
	const title = $('input[id=title]').val();
	const searchBtn = document.getElementById("searchBtn");
	if(title != ""){
		searchBtn.disabled = false;
	    return true;
	}
	else {
	    //입력값 없을 시 다시 버튼 비활성화
		searchBtn.disabled = true;
	    return false;
	}
}
$(() => {
	$(".searchResult").css({"visibility": "hidden"});
	const searchBtn = document.getElementById("searchBtn");
	searchBtn.disabled = true;
	
	document.getElementById('wishPrice').addEventListener('keyup', function(){
	    const price = document.getElementById('wishPrice');
	    if(price.value.length > 0){
	        if(Number(price.value) <= 0){
	            alert('일일대여로는 0원 보다 많아야 합니다.');
	            price.value = 500;
	        }
	    }
	});
})
//책 등록 여부 변수
let inputBookFlag = false;

let childWin;
function openSearchWindow(){
    // window.name = "부모창 이름"; 
    window.name = "parentForm";
    let url = `${pageContext.request.contextPath}/booking/bookSearch.do`;
    var option = "width=1000, height=700, resizable = no, scrollbars = no";
    
    //새탭으로 열기
    childWin = window.open('', "result", option);
    $("#searchFrm").attr("action", url);
    $("#searchFrm").attr("target", "result");
    $("#searchFrm").submit();
}
let book;
//자식창에서 호출할 json 페이지적용 함수
window.getJson = function(){
    book = JSON.parse(localStorage.getItem("book"));
    console.log(book);
    if(isEmptyObj(book)){
        alert("책정보 없음 - 도서를 다시 선택해주세요.");
    }else if(!checkAllElement(book)){
        alert("해당 도서는 등록할 수 없습니다.");
    }else{
    	$(".searchResult").css({"visibility": "visible"});
        const date = new Date(book.pubdate);
        const newDate = date.getFullYear() + '년 ' + (date.getMonth()+1) + '월';
        document.getElementById('cover').src = book.cover;
        document.getElementById('bookTitle').innerHTML = book.title;
        document.getElementById('author').innerHTML = book.author;
        document.getElementById('publisher').innerHTML = book.publisher;
        document.getElementById('pubdate').innerHTML = newDate;
        document.getElementById('isbn13').value = book.isbn13;
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
// 요청글 등록
function enrollRequest(){
	const isbn13 = $("input[id=isbn13]").val();
	const wishPrice = $("input[id=wishPrice]").val();
	const bookCondition = $('input[name=bookCondition]:checked').val();
	let f = document.createElement('form');
	
	let obj1 = document.createElement('input');
	obj1.setAttribute('type', 'hidden');
	obj1.setAttribute('name', 'isbn13');
	obj1.setAttribute('value', isbn13);
	
	let obj2 = document.createElement('input');
	obj2.setAttribute('type', 'hidden');
	obj2.setAttribute('name', 'wishPrice');
	obj2.setAttribute('value', wishPrice);
	
	let obj3 = document.createElement('input');
	obj3.setAttribute('type', 'hidden');
	obj3.setAttribute('name', 'bookCondition');
	obj3.setAttribute('value', bookCondition);

	csrf = document.createElement('input');
	csrf.setAttribute('type', 'hidden');
	csrf.setAttribute('name', '${_csrf.parameterName}');
	csrf.setAttribute('value', '${_csrf.token}');
	
	f.appendChild(obj1);
	f.appendChild(obj2);
	f.appendChild(obj3);
	f.appendChild(csrf);
	f.setAttribute('method', 'post');
	f.setAttribute('action', '${pageContext.request.contextPath}/board/requestEnroll.do');
	document.body.appendChild(f);
	f.submit();
}
</script>
<!-- 등록 폼 시작 -->
<div class="roberto-contact-form-area section-padding-100">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Section Heading -->
				<div class="section-heading text-left wow fadeInUp" data-wow-delay="100ms">
					<h3>책을 검색해주세요</h3>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<!-- Form -->
				<div class="roberto-contact-form mb-50">
					<form method="get" id="searchFrm">
						<div class="col-12 wow fadeInUp form-inline form-group"
							data-wow-delay="100ms">
							<div class="col-lg-6">
								<input type="text" class="form-control" name="title" id="title" onkeyup="checkTitle()" placeholder="책 이름을 입력하세요">
							</div>
							<div class="col-lg-3">
								<button type="button" class="btn roberto-btn" id="searchBtn" onclick="openSearchWindow();">검색</button>
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
					<form:form method="post" action="" id="enrollFrm">
						<h3>책 정보</h3>
						<hr class="my-2">
						<div class="d-flex align-items-center mt-5 mb-50 searchResult">
							<img src="${pageContext.request.contextPath}/resources/img/book-photo.png" class="d-block w-40 mx-5" alt="" id="cover">
							<div class="post-content mx-5">
								<table class="table table-borderless table-sm">
									<tr>
										<td>제목</td>
										<td id="bookTitle"></td>
									</tr>
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
										<td id="pubdate"></td>
									</tr>
								</table>
								<input type="hidden" id="isbn13" value=""/>
							</div>
						</div>
						<div class="room-features-area d-flex flex-wrap mb-50 ">
							<table class="table text-center">
								<tr>
									<td>상태</td>
									<td>일당 대여료</td>
								</tr>
								<tr>
									<td>
										<input type="radio" name="bookCondition" id="best" value="최상">
										<label for="best">최상</label>&nbsp;
										<input type="radio" name="bookCondition" id="good" value="상">
										<label for="good">상</label>&nbsp;
										<input type="radio" name="bookCondition" id="soso" value="중">
										<label for="soso">중</label>&nbsp;
										<input type="radio" name="bookCondition" id="bad" value="하">
										<label for="bad">하</label>&nbsp;
										<input type="radio" name="bookCondition" id="worst" value="최하">
										<label for="worst">최하</label>&nbsp;
									</td>
									<td>
										<div class="form-inline form-group" style="justify-content:center;">
											<input type="number" class="form-control" placeholder="일일 대여료를 입력하세요" id="wishPrice" name="wishPrice" min="0" step="500" onKeyup="this.value=this.value.replace(/[^0-9]/g,'500');" required> &nbsp; <span> 원</span>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<div class="col-12 mt-30 p-0">
							<button type="button" class="btn roberto-btn" id="enrollBtn" onclick="enrollRequest();">요청 등록</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Rooms Area End -->



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>