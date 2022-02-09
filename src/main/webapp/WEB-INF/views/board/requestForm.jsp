<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css"/>
<script>
function goRequestList(){
	location.href = "${pageContext.request.contextPath}/board/request.do";
}
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(() => {
	$("[name=upFile]").change((e) => {
		const file = $(e.target).prop('files')[0];
		const $label = $(e.target).next();
		
		if(file != undefined)
			$label.html(file.name);
		else
			$label.html("파일을 선택하세요.");
	});
});
</script>
<div class="container">
  <form 		
  		name="requestFrm" 
		action="${pageContext.request.contextPath}/board/requestEnroll.do" 
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return boardValidate();">
     <div class="row" style="margin-left: 2%;">
       	<h2>요청서 작성</h2>
        <hr>
      <input type="submit" value="등록" style="margin-left: 65%;">
      <input type="button" value="취소" onclick="goRequestList();">
    </div>
    		<div class="custom-file" style="margin-left: 2%;">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		  
		  <div class="price" style="margin: 2%;"> 
         <label for="price">희망 대여가격(일) : </label>
        <input type="text" id="price" name="price" placeholder="가격을 입력해주세요">
         </div>
         
         <div class="expected-quality" style="margin: 2%;">
          <label for="quality">희망 도서 상태 : </label>
          <input type="checkbox" id="A" name="quality" checked>
  		  <label for="A">상</label>
  		  <input type="checkbox" id="B" name="quality" checked>
  		  <label for="B">중</label>
  		   <input type="checkbox" id="C" name="quality" checked>
  		  <label for="C">하</label>
        </div>
	
        <input type="text" id="title" name="title" placeholder="제목" style="margin-left: 2%;" required>
        
        <textarea id="content" name="content" placeholder="내용" style="height:250px; margin: 2%;"></textarea>

  </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
