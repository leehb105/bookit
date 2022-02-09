<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css"/>
<script>
function goCommunityList(){
	location.href = "${pageContext.request.contextPath}/board/community.do";
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
	$("[name=upFiles]").change((e) => {
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
  		name="communityFrm" 
		action="${pageContext.request.contextPath}/board/communityEnroll.do" 
		method="post"
		enctype="multipart/form-data" 
<<<<<<< HEAD
=======

>>>>>>> branch 'didwpsl' of https://github.com/jinmae1/bookit.git
		onsubmit="return boardValidate();">
     <div class="row">
       	<h2>글 쓰기</h2>
        <hr>
      <input type="submit" value="등록" >
      <input type="button" value="취소" onclick="goCommunityList();">
    </div>
<<<<<<< HEAD
        <input type="text" id="title" name="title" placeholder="제목">
=======
    <div name="form-body" style="margin-left: 2%;">
        <input type="text" id="title" name="title" placeholder="제목" style="margin-left: 6%;" required>
     
        
>>>>>>> branch 'didwpsl' of https://github.com/jinmae1/bookit.git
        
        <select id="category" name="category">
          <option value="chat">잡담</option>
          <option value="meet">독서모임</option>
          <option value="recommendation">독서추천</option>
        </select>
        <textarea id="content" name="content" placeholder="내용" style="height:250px"></textarea>
        		<div class="input-group mb-3" style="padding:0px;" >
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFiles" id="upFiles" multiple>
		    <label class="custom-file-label" for="upFiles">파일을 선택하세요</label>
		  </div>
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일2</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile2"" >
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
		  </div>
		</div>
  </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
