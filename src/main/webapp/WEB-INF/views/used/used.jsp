<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
/*글쓰기버튼*/
input#btn-add {
	float: right;
	margin: 0 0 15px;
}

tr[data-no] {
	cursor: pointer;
}
</style>
<script>
var category = "titleAndContent";
var keyword = "파일";

function searchUsed(){
	var searchType = $("select[name=searchType]").val();
	var keyword = $("input[name=keyword]").val();
		
	console.log("searchType: "+ searchType, " keyword: ", keyword);	
	
	location.href = "${pageContext.request.contextPath}/used/search.do?searchType="+searchType+"&keyword="+keyword
}
function goCommunityForm(){
	location.href = "${pageContext.request.contextPath}/used/usedForm.do";
}


function goUsedForm(){
	location.href = "${pageContext.request.contextPath}/used/usedForm.do";
}
$(() => {
	$("tr[data-no]").click((e) => {
		const $tr = $(e.target).parent();
		const no = $tr.data("no");
		location.href = `${pageContext.request.contextPath}/used/usedContent.do?no=\${no}`;
	});
});
</script>
<section id="board-container" class="container">
	<input 
		type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" 
		onclick="goUsedForm();" style="margin-top: 2%;"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr class="table-success">
			<th>번호</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${list}" var="used">
			<tr data-no="${used.usedBoardNo}">
				<td>${used.usedBoardNo}</td>
				<td>[${used.category}]</td>
				<td>${used.title}</td>
				<td>${used.nickname}</td>
				<td><fmt:formatDate value="${used.regDate}"
						pattern="yy/MM/dd HH:mm" /></td>
				<td>${used.readCount}</td>
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
                   		<button type="submit" class="btn btn-outline-info" onClick="searchUsed()" id="searchBtn">검색</button>
				      	</div>
				      </form>

	<br>
	<div class="pagebar" style="margin-bottom: 2%;">${pagebar}</div>

</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>