<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
.title {cursor: pointer;}
.writer{
		cursor: pointer;
	}
	
	#modal_no_btn {
		margin-left: 50px;
	}
	.modal_chat form{
		display: inline-block;
	}
	.modal_chat{
		display:none;
		position: relative;
		width: 100%;
		height: 100%;
		z-index: 1;
		bottom: 400px;
		margin-bottom: -170px;
	}
	
	.modal_chat h2{
		margin:0;
		
	}
	.modal_chat button {
		display: inline-block;
		width: 100px;
	}
	.modal_chat .modal_content{
		width: 300px;
		margin: 10px auto;
		padding: 20px 10px;
		background: #fff;
		border: 2px solid #666;
		
	}
	.modal_chat .modal_layer{
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0,0,0,0.5);
		z-index: -1;
	}
	
</style>

<script>


var category = "titleAndContent";
var keyword = "파일";

function searchCommunity(){
	var searchType = $("select[name=searchType]").val();
	var keyword = $("input[name=keyword]").val();
		
	console.log("searchType: "+ searchType, " keyword: ", keyword);	
	
	location.href = "${pageContext.request.contextPath}/board/search.do?searchType="+searchType+"&keyword="+keyword
}
function goCommunityForm(){
	location.href = "${pageContext.request.contextPath}/board/communityForm.do";
}
$(() => {
	$(".title").click((e) => {
		const $tr = $(e.target).parent();
		const no = $tr.data("no");
		location.href = `${pageContext.request.contextPath}/board/communityContent.do?no=\${no}`;
	});
	
	$(".writer").click((e) => {
		writer = e.target.id;
		var str = "<p>"+writer+"님과 대화하시겠습니까?</p>";
		
		$("#input_writer").val(writer);
		$(".modal_content h3").append(str);
		
		$(".modal_chat").css("display","block");
	});
	
	$("#modal_no_btn").click((e) => {
		
		$(".modal_chat").css("display","none");
		$(".modal_content p").remove();
	});

});


</script>
<section id="board-container" class="container">
	<input 
		type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" 
		onclick="goCommunityForm();" style="margin-top: 2%;"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr class="table-success">
			<th>번호</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th> 
			<th>조회수</th> 
			<th>좋아요</th>
		</tr>
		<c:forEach items="${list}" var="community">
			<tr data-no="${community.communityNo}">
				<td>${community.communityNo}</td>
				<td>[${community.category}]</td>
				<td class = "title">${community.title}&nbsp;[${community.commentCount}]</td>
				<td class="writer" id="${community.nickname}">${community.nickname}</td>
				<td><fmt:formatDate value="${community.regDate}" pattern="yy/MM/dd HH:mm"/> </td>
				<td>${community.readCount}</td>
				<td>${community.likeCount}</td>
			</tr>
		</c:forEach>
	</table>
	
				      <form method="get" id="searchFrm">
				      	<div >
				      	    <select name = "searchType" >
                            <option ${(param.searchType == "titleAndContent")? "selected" : ""} value = "titleAndContent">제목/내용</option>
                            <option ${(param.searchType == "writer")? "selected" : ""} value = "writer">작성자</option>
                        </select>
				        <input type = "text" name = "keyword" value = "${param.keyword}" style="margin: 5px;"/>
                   		<button type="submit" class="btn btn-outline-info" onClick="searchCommunity()" id="searchBtn">검색</button>
				      	</div>
				      </form>
	
	<br>
	<div class="pagebar" style="margin-bottom: 2%;" >
	${pagebar}
	</div>
	<div class="modal_chat">
   		
	    <div class="modal_content">
	        <h3>채팅방 생성</h3>
	        <hr />

	       <form:form
	       		action="${pageContext.request.contextPath}/chatroom/create" 
                method="POST">
				<input type="hidden" name = "writer" id = "input_writer"/>
	       		<button class="btn btn-primary" id="modal_yes_btn">네</button>
	       </form:form>
	        <button type="button" class="btn btn-danger" id="modal_no_btn">아니요</button>
	       
	    </div>
	   
	    <div class="modal_layer"></div>
	</div>

	
</section> 


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>