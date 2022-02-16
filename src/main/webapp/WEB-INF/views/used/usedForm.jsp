<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used.css"/>
<script>
function goUsedList(){
	location.href = "${pageContext.request.contextPath}/used/used.do";
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
<div class="roberto-contact-form-area section-padding-100">       
<div class="container">
  <form 		
  		name="usedFrm" 
		action="${pageContext.request.contextPath}/used/usedEnroll?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return boardValidate();">
  <div class="row" >    
     <div class="col-12">
         <div class="section-heading text-left wow fadeInUp" data-wow-delay="100ms">
       	     <input type="submit" class="btn btn-outline-success float-right" value="등록">
       	<h2>글쓰기</h2>
                    </div>
    <div name="form-body" style="margin-left: 2%;">
            <input type="text" id="title" name="title" placeholder="제목" 
        style="margin-bottom: 3%; padding: 7px;   margin-left: 10px; width:80%;   border-radius: 4px;   border: 1px solid #ccc; margin-bottom: 10px;"
        required>
        <select id="category" name="category">
          <option value="팝니다">팝니다</option>
          <option value="삽니다">삽니다</option>
        </select>
        

        <div class="price">
        <h5>판매 가격 : <input type="text" id="price" name="price" placeholder="가격" 
        style="margin-bottom: 3%; padding: 5px;   margin-left: 5px; width:30%;   border-radius: 4px;   border: 1px solid #ccc; margin-bottom: 10px;"
        required></h5>
           
         </div>
         
         <div class="trade_method">
           <h5><label for="method">거래 방법 : </label>
          <input type="checkbox" id="direct" name="tradeMethod" value="직거래" checked>
  		  <label for="direct">직거래</label>
  		  <input type="checkbox" id="post" name="tradeMethod" value="택배" checked>
  		  <label for="post">택배</label></h5>
        </div>
        
        <div class="book-state">
       <h5><label for="method">책 상태 :&nbsp; &nbsp;</label>
  		<input type="radio" id="A" name="bookState" value="최상" checked>
  		<label for="최상">최상</label>
  		<input type="radio" id="B" name="bookState" value="상" checked>
  		<label for="상">상</label>
  		<input type="radio" id="C" name="bookState" value="중" checked>
  		<label for="중">중</label>
  		<input type="radio" id="D" name="bookState" value="하" checked>
  		<label for="하">하</label></h5>
		</div>
		      <textarea rows="12" cols="130" id="content" name="content" placeholder="내용" style="margin-bottom: 3%; padding: 7px;  border-radius: 4px;  border: 1px solid #ccc; margin-bottom: 10px;"></textarea>
		</div>
        

		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFiles" id="upFile1" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		  <br>
  <br>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFiles" id="upFile2" multiple>
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
		  </div>
		</div>
  </div>
  </form>

  </div>
</div>
  <br>  <br>  <br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
