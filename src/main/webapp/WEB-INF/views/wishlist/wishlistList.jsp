<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script>
// 찜 목록 삭제 시 전체체크 기능
$(function(){
	var wishlistBoardNo = document.getElementsByName("wishlistBoardNo");
	var count = wishlistBoardNo.length;
	
	$("input[id=checkAll]").click(function(){
		var checkedList = $("input[id=wishlistBoardNo]");
		for(var i = 0; i < checkedList.length; i++){
			checkedList[i].checked = this.checked;
		}
	});
	$("input[id=wishlistBoardNo]").click(function(){
		if($("input[id=wishlistBoardNo]:checked").length == count){
			$("input[id=checkAll]")[0].checked = true;
		}
		else{
			$("input[id=checkAll]")[0].checked = false;
		}
	});
});
// 찜 목록 삭제 기능
function wishlistDelete(){
	var checkedArr = new Array();
	var wishlist = $("input[id=wishlistBoardNo]");
	
	for(var i = 0; i < wishlist.length; i++){
		if(wishlist[i].checked){
			checkedArr.push(wishlist[i].value);
		}
	}
	if(checkedArr.length == 0){
		alert("선택된 항목이 없습니다.");
	}
	else{
		var real = confirm("정말 삭제하시겠습니까?");
		$.ajax({
			url: `${pageContext.request.contextPath}/wishlist/wishlistDelete.do`,
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
					location.replace(`${pageContext.request.contextPath}/wishlist/wishlistList.do`);
				}
				else{
					alert("다시 시도해주세요.");
				}
			},
			error: console.log
		});
	}
}
// 컬렉션 삭제 기능
function collectionDelete(){
	var checkedArr = new Array();
	var collection = $("input[id=collectionNo]");
	
	for(var i = 0; i < collection.length; i++){
		if(collection[i].checked){
			checkedArr.push(collection[i].value);
		}
	}
	if(checkedArr.length == 0){
		alert("선택된 항목이 없습니다.");
	}
	else{
		var real = confirm("정말 삭제하시겠습니까?");
		$.ajax({
			url: `${pageContext.request.contextPath}/wishlist/collectionDelete.do`,
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
					location.replace(`${pageContext.request.contextPath}/wishlist/wishlistList.do`);
				}
				else{
					alert("다시 시도해주세요.");
				}
			},
			error: console.log
		});
	}
}
// 찜 등록. value값 수정 후 게시판에서 사용할 수 있게
function wishlistEnroll() {
	var no = $("input[id=wishlistBoardNo]").val();
	console.log(no);
	$.ajax({
		url: `${pageContext.request.contextPath}/wishlist/wishlistEnroll.do`,
		type: "POST",
		data: {
			no : no
		},
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
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
};
// 찜 목록 누르면 해당 게시글로 이동
$(() => {
	$("td[data-no]").click((e) => {
		const $td = $(e.target);
		const no = $td.data("no");
		console.log(no);
		location.href = `${pageContext.request.contextPath}/booking/bookingDetail.do?bno=\${no}`;
	});
});
$(document).ready(function() {
	$(".modal").css({"display": "none"});
});
// 컬렉션 생성
function collectionInsert(){
	var collectionName = $("input[id=collectionName]").val();
	let f = document.createElement('form');
	let obj1 = document.createElement('input');
	obj1.setAttribute('type', 'hidden');
	obj1.setAttribute('name', 'collectionName');
	obj1.setAttribute('value', collectionName);

	csrf = document.createElement('input');
	csrf.setAttribute('type', 'hidden');
	csrf.setAttribute('name', '${_csrf.parameterName}');
	csrf.setAttribute('value', '${_csrf.token}');
	
	f.appendChild(obj1);
	f.appendChild(csrf);
	f.setAttribute('method', 'post');
	f.setAttribute('action', '${pageContext.request.contextPath}/wishlist/collectionInsert.do');
	document.body.appendChild(f);
	f.submit();
}
</script>

<style>
.selectWishlist:hover {
	cursor: pointer;
	background: #f7fff6;
}
.modal-body p {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 30px;
}
</style>
	<!-- 나의 찜 -->
	<div class="container mb-50 mt-100">
		<div class="row mb-50">
			<div class="col-lg-10 col-md-10 ml-auto mr-auto">
				<div class="section-heading text-center">
					<h5>나의 찜 목록</h5>
				</div>
				<div class="table-responsive">
					<table class="table text-center">
						<thead>
							<tr>
								<th><input type="checkbox" id="checkAll"/></th>
								<th>게시판No</th>
								<th>작성자</th>
								<th>내용</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${wishlistList}" var="wishlistList">
								<tr class="selectWishlist">
									<td><input type="checkbox" name="wishlistBoardNo" id="wishlistBoardNo" value="1"/></td>
									<td>${wishlistList.boardNo}</td>
									<td data-no="${wishlistList.boardNo}">${wishlistList.writer}</td>
									<td data-no="${wishlistList.boardNo}">${wishlistList.content}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty wishlistList}">
								<tr>
									<td colspan="4"><p>찜 목록이 비어있습니다.</p></td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<input type="button" value="삭제" class="btn btn-outline-danger float-right mb-30" onclick="wishlistDelete();"/>
				<input type="button" value="등록" class="btn btn-outline-success float-right mb-30 mr-15" onclick="wishlistEnroll();"/>
			</div>
		</div>
		${pagebar}
	</div>
	<hr />
	<!-- 나의 컬렉션 -->
	<section class="roberto-service-area mb-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-md-10 ml-auto mr-auto">
                    <!-- Section Heading -->
                    <div class="section-heading text-center mt-30">
                        <h5>나의 컬렉션</h5>
                        <button class="btn btn-outline-danger float-right" onclick="collectionDelete();">컬렉션 삭제</button>
                        <button 
                        	class="btn btn-outline-success float-right mr-15" 
                        	data-toggle="modal"
							data-target="#collectionInsertModal">컬렉션 추가
                        </button>
                    </div>
                </div>
            </div>
            <div class="row d-flex align-items-center justify-content-center">
            	<c:forEach items="${collectionList}" var="collectionList">
	                <!-- Single Service Area -->
	                <div class="col-12 col-md-6 col-lg-3" style="cursor: pointer;">
	            		<input type="checkbox" name="collectionNo" id="collectionNo" value="${collectionList.no}"/>
	                    <div class="single-post-area mb-100 wow fadeInUp text-center" data-wow-delay="50ms">
							<a href="${pageContext.request.contextPath}/collection/collectionDetail.do?no=${collectionList.no}" class="post-thumbnail">
								<img class="w-50" 
									src=""
									onerror="this.src='${pageContext.request.contextPath}/resources/img/default_profile.png'">
							</a>
							<h5 class="post-title">${collectionList.nickname}님의</h5>
							<h6>${collectionList.collectionName}</h6>
						</div>
	                </div>
                </c:forEach>
                <c:if test="${empty collectionList}">
					<p class="mb-100">등록한 컬렉션이 없습니다.</p>
				</c:if>
            </div>
        </div>
    </section>
    
    <!-- Modal -->
	<div class="modal fade" id="collectionInsertModal" tabindex="-1"
		role="dialog" aria-labelledby="collectionInsertModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="collectionInsertModalLabel">NEW COLLECTION</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<div>
						<p>컬렉션 제목</p>
						<input type="text" id="collectionName" value="" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" name="success" class="btn btn-success" onclick="collectionInsert();">추가</button>
				</div>
			</div>
		</div>
	</div>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
