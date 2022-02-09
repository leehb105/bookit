<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
<script>
function goRequestForm(){
	location.href = "${pageContext.request.contextPath}/board/requestForm.do";
}
</script>
<style>
div#board-container{width:400px; margin:100px auto; text-align:center;}
div#board-container input{margin-bottom:15px;}
div#board-container label.custom-file-label{text-align:left;}

</style>
<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 15px 0 15px;}
tr[data-no] {cursor: pointer;}
</style>
<section id="board-container" class="container">
	<input 
		type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" 
		onclick="goRequestForm();"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>요청 도서 목록</th>
		</tr>
	</table>
			<div class="search-container">
 	<select id="searchType">
	<option value="title" name="title" ${"title".equals(searchType) ? searchKeyword : ""}>제목</option>		
	<option value="category" name="category" ${"category".equals(searchType) ? searchKeyword : ""}>말머리</option>
	</select>
	
	<div id="search-title" class="search-type">
	<form class="example" action="/action_page.php" style="margin:auto;max-width:300px">
	 <input type="hidden" name="searchType" value="title" >
 	 <input type="text" name="searchKeyword" value=${"title".equals(searchType) ? searchKeyword : "" || "category".equals(searchType) ? searchKeyword : ""}>
  	<button type="button" class="btn btn-primary btn-icon-split" style="padding: 2px" onclick="searchCommunity()">검색
  	<i class="fa fa-search" aria-hidden="true"></i></button>			
	</form>
	</div>
	</div>
	
	<br>
	<div class="pagebar"  style="margin-bottom: 2%;">
	${pagebar}
	</div>

</section> 


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
