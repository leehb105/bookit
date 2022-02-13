<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
// 상단 배너에 닉네임과 컬렉션이름 출력
$(() => {
	var nickname = $("input[id=nickname]").val();
	var collectionName = $("input[id=collectionName]").val();
	
	var title = document.getElementsByClassName('breadcrumb-content')[0];	
	var h2Tag = document.createElement('h2');
	h2Tag.innerHTML = nickname + '님의 ' + collectionName;
	h2Tag.className = 'page-title';
	title.prepend(h2Tag);
	
	var subTitle = document.getElementsByClassName('breadcrumb')[0];
	var liTag = document.createElement('li');
	liTag.innerHTML = nickname + '님의 ' + collectionName;
	liTag.className = 'breadcrumb-item active';
	subTitle.append(liTag);
	
});

// 책 삭제
function deleteBook(){
	var no = $("input[id=bookCollectionNo]").val();
	var checkedArr = new Array();
	var list = $("input[id=checkListNo]");
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){
			checkedArr.push(list[i].value);
		}
	}
	if(checkedArr.length == 0){
		alert("선택된 항목이 없습니다.");
	}
	else{
		var confitm = confirm("정말 삭제하시겠습니까?");
		$.ajax({
			url: `${pageContext.request.contextPath}/collection/collectionDetailDelete.do`,
			method: "POST",
			traditional: true,
			data: {
				checkedArr : checkedArr
			},
			beforeSend : function(xhr){
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success: function(res){
				if(res = 1){
					alert("삭제되었습니다.");
					location.replace(`${pageContext.request.contextPath}/collection/collectionDetail.do?no=\${no}`);
				}
				else{
					alert("다시 시도해주세요.");
				}
			},
			error: console.log
		});
	}
}

$(document).ready(function () {
	// 페이지 로드되자마자 나오는 modal창 안보이게 설정
	$(".modal").css({"display": "none"});
	
	// 책 검색결과 섹션 숨기기 + 검색 버튼 비활성화
	$("#addBookModal").on('show.bs.modal', function(event) {
		$(".searchResult").css({"visibility": "hidden"});
		const searchBtn = document.getElementById("searchBtn");
		searchBtn.disabled = true;
	});
	
	// modal창 끄고 다시 켰을 때 검색어 리셋
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset()
	});
});

// 검색어 value값 체크
function checkTitle(){
	const $title = $('input[name=title]').val();
	if($title != ""){
	    $('#searchBtn').attr("disabled", false);
	    return true;
	}
	else{
	    //입력값 없을 시 다시 버튼 비활성화
	    $('#searchBtn').attr("disabled", true);
	    return false;
	}
}

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

//자식창에서 호출할 json 페이지적용 함수
window.getJson = function(){

    book = JSON.parse(localStorage.getItem("book"));
    if(isEmptyObj(book)){
        alert("책정보 없음 - 도서를 다시 선택해주세요.");
    }else if(!checkAllElement(book)){
        alert("해당 도서는 등록할 수 없습니다.");
    }else{
    	$(".searchResult").css({"visibility": "visible"});
        document.getElementById('cover').src = book.cover;
        document.getElementById('title').innerHTML = book.title;
        document.getElementById('author').innerHTML = book.author;
        document.getElementById('publisher').innerHTML = book.publisher;
        document.getElementById('isbn').value = book.isbn13;
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

function insertBook(){
	var collectionNo = $("input[id=no]").val();
	var isbn = $("input[id=isbn]").val();
	console.log(collectionNo);
	console.log(isbn);
	let f = document.createElement('form');
	
	let obj1 = document.createElement('input');
	obj1.setAttribute('type', 'hidden');
	obj1.setAttribute('name', 'collectionNo');
	obj1.setAttribute('value', collectionNo);
	
	let obj2 = document.createElement('input');
	obj2.setAttribute('type', 'hidden');
	obj2.setAttribute('name', 'isbn');
	obj2.setAttribute('value', isbn);

	csrf = document.createElement('input');
	csrf.setAttribute('type', 'hidden');
	csrf.setAttribute('name', '${_csrf.parameterName}');
	csrf.setAttribute('value', '${_csrf.token}');
	
	f.appendChild(obj1);
	f.appendChild(obj2);
	f.appendChild(csrf);
	f.setAttribute('method', 'post');
	f.setAttribute('action', '${pageContext.request.contextPath}/collection/insertBook.do');
	document.body.appendChild(f);
	f.submit();
}
</script>

<!-- Breadcrumb Area Start -->
<div class="breadcrumb-area bg-img bg-overlay jarallax" style="background-image: url(img/bg-img/16.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcrumb-content text-center">
                    <!-- javascript:h2생성 -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Collection</li>
                            <!-- javascript:li생성 -->
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb Area End -->

<!-- Rooms Area Start -->
<div class="roberto-rooms-area section-padding-100-0">
    <div class="container">
        
        <div class="row">
            <div class="col-12 col-lg-8 mb-50">
                <c:forEach items="${collectionDetailList}" var="collectionDetailList">
		                <div 
		                	class="single-room-area d-flex align-items-center mb-50 wow fadeInUp" 
		                	data-wow-delay="100ms">
		                    <!-- Room Thumbnail -->
		                    <c:set var="memberId" value="${collectionDetailList.memberId}"/>
		                    <input type="hidden" id="nickname" value="${collectionDetailList.nickname}"/>
		                    <input type="hidden" id="collectionName" value="${collectionDetailList.collectionName}"/>
		                   	<input type="hidden" id="bookCollectionNo" value="${collectionDetailList.bookCollectionNo}"/>
		                   	<input type="hidden" id="no" value="${collectionDetailList.no}"/>
		                   	<c:if test="${collectionDetailList.listNo ne null}">
		                   		<c:if test="${collectionDetailList.memberId eq loginMember.id}">
			                		<input type="checkbox" id="checkListNo" value="${collectionDetailList.listNo}"/>
			                    </c:if>
			                    <div class="room-thumbnail text-center">
			                        <img class="w-25" src="${collectionDetailList.cover}" alt="">
			                    </div>
			                    <!-- Room Content -->
			                    <div class="room-content">
			                        <h5>${collectionDetailList.title}</h5>
			                        <div class="room-feature">
			                            <h6>저자<span><small>${collectionDetailList.author}</small></span></h6>
			                            <h6><span></span></h6>
			                            <h6>출판사<span><small>${collectionDetailList.publisher}</small></span></h6>
			                        </div>
			                        <a 
			                        	href="${pageContext.request.contextPath}/collection/aaaa.do?ibsn13=${collectionDetailList.isbn13}"
			                        	class="btn view-detail-btn">상세정보 <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
			                        </a>
			                    </div>
		                    </c:if>
		                </div>
                </c:forEach>
				<c:if test="${empty bookList}">
					<p class="text-right mb-100 mr-100">추가하신 책 목록이 없습니다.</p>
				</c:if>
            </div>
            <c:if test="${memberId eq loginMember.id}">
	            <div class="col-12 col-lg-2">
					<div class="hotel-reservation--area mb-100 ml-100">
				        <div class="form-group">
				            <button 
				            	data-toggle="modal" 
	                        	data-target="#addBookModal" 
	                        	class="btn roberto-btn w-100">책 추가
	                        </button>
	                        <button class="btn roberto-btn w-100 mt-30" onclick="deleteBook();">선택 삭제</button>
				        </div>
					</div>
				</div>
			</c:if>
			
			<!-- Modal -->
			<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="addBookModalModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="addBookModalModalLabel">추가하실 책을 검색하세요.</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">×</span>
			        </button>
			      </div>
			      <div class="modal-body">
				      <form method="get" id="searchFrm">
				      	<div>
				      		<input type="text" name="title" onkeyup="checkTitle()" value="" placeholder="책 이름을 입력하세요"/>
				      		<button type="button" class="btn btn-outline-info" id="searchBtn" onclick="openSearchWindow();">검색</button>
				      	</div>
				      </form>
					  <hr />
				      <div class="d-flex align-items-center searchResult">
				      	<img id="cover" class="d-block w-25" src="" alt="" />
				      	<table class="table table-borderless table-sm ml-4">
				      		<tr>
				      			<td class="w-25">제목</td>
				      			<td id="title"></td>
				      		</tr>
				      		<tr>
								<td>저자</td>
							    <td id="author"></td>
							</tr>
							<tr>
							    <td>출판사</td>
							    <td id="publisher"></td>
							</tr>
				      	</table>
						<input type="hidden" id="isbn" value=""/>
				      </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" name="success" class="btn btn-success" onclick="insertBook()">추가</button>
			      </div>
			    </div>
			  </div>
			</div>
        </div>
    </div>
</div>
<div class="mb-100">${pagebar}</div>


<!-- Rooms Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
