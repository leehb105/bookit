<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/collectionImage.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script>
// 게시글 목록 삭제 시 전체체크 기능
$(function(){
	var no = document.getElementsByName("no");
	var count = no.length;
	
	$("input[id=checkAll]").click(function(){
		var checkedList = $("input[id=no]");
		for(var i = 0; i < checkedList.length; i++){
			checkedList[i].checked = this.checked;
		}
	});
	
	$("input[id=no]").click(function(){
		if($("input[id=no]:checked").length == count){
			$("input[id=checkAll]")[0].checked = true;
		}
		else{
			$("input[id=checkAll]")[0].checked = false;
		}
	});
});


//$("input[id=postsNo]").click(function(){
//	const radioVal = $('input[id="postsNo"]:checked').val();
//	const tableName = $('input[id="postsTableName"]').val();
	

	//console.log(radioVal, tableName);
//});

// 게시글 목록 삭제 기능
function wishlistDelete(){
	// var checkedArr = new Array();
	

	const radioVal = $('input[id="postsNo"]:checked').val();
	const tableName = $('input[id="postsTableName"]').val();
	var isCommunity = tableName=='커뮤니티';
	
	if(isCommunity == '커뮤니티'){
	
	var real = confirm("정말 삭제하시겠습니까?");
	$.ajax({
		url: `${pageContext.request.contextPath}/member/postDelete.do`,
		type: "POST",
		// traditional: true,
		data: {
			no : radioVal,
			isCommunity : isCommunity
		},
		beforeSend : function(xhr){
			/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success: function(res){
		//	if(res = 1){
				alert("삭제되었습니다.");
				location.replace(`${pageContext.request.contextPath}/member/myPosts.do`);
			//}
			//else{
			//	alert("다시 시도해주세요.");
			//}
		},
		error: console.log
	});
	}
	
}

function viewPost(t, n){
	
	//if(t == '중고'){
	//	location.href = `${pageContext.request.contextPath}/used/usedContent.do?no=`+n;
	//}else{
		//location.href = `${pageContext.request.contextPath}/community/communityContent.do?no=`+n;
	//}
	
	
}

// 찜 목록 누르면 해당 게시글로 이동
//$(() => {
//	$("tr[data-no]").click((e) => {
//		const $tr = $(e.target);
//		const no = $tr.data("no");
//		console.log(no);
//		location.href = `${pageContext.request.contextPath}/booking/bookingDetail.do?bno=\${no}`;
//	});
//});

$(document).ready(function() {
	$(".modal").css({"display": "none"});
});

</script>

<style>
table {
	table-layout: fixed;
}
.detail{
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

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
	<!-- 나의 게시글 -->
	<div class="container mb-50 mt-100">
		<div class="row mb-50">
			<div class="col-lg-10 col-md-10 ml-auto mr-auto">
				<div class="section-heading text-center">
					<h5>나의 게시글</h5>
				</div>
				<div class="table-responsive">
					<table class="table text-center">
						<thead>
							<tr>
								<th style="width:10%"></th>
								<th style="width:20%">게시판</th>
								<th style="width:20%">게시글 번호</th>
								<th style="width:20%">제목</th>
								<th style="width:20%">작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${posts}" var="posts">
								<tr data-no="${posts.no}" onClick="viewPost( )" class="selectPosts">
									<td><input type="radio" name="postsNo" id="postsNo" value="${posts.no}"/>
									<input type="hidden" name="postTableName" id="postsTableName" value="${posts.tableName}"/>
									</td>
									<td>${posts.tableName}</td>
									<td >${posts.no}</td>
									<td class="category" >${posts.category}</td>
									<td class="title" >${posts.title}</td>
									<td><fmt:formatDate value="${posts.regDate}" pattern="yy/MM/dd HH:mm"/> </td>
								</tr>
							</c:forEach>
							<c:if test="${empty posts}">
								<tr>
									<td colspan="4"><p>작성한 글이 없습니다</p></td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<input type="button" value="삭제" class="btn btn-outline-danger float-right mb-30" onclick="wishlistDelete();"/>
			</div>
		</div>
		${pagebar}
	</div>
	<hr />

	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
