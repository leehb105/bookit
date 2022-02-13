<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="loginMember" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title" />
</jsp:include>
<script>
console.log("${loginMember.id}");
</script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<div class="container">
	<!-- Outer Row -->
	<div class="row justify-content-center">
		<div class="col-xl-10 col-lg-12 col-md-9">
			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<div class="p-5">
						<br />

						<div class="mx-auto" style="width: 150px;">자유 게시판 수정</div>

						<br />
						<!-- boardEnrollForm -->
						<form id="boardUpdateForm" class="user"
							action="${pageContext.request.contextPath}/board/updateCommunityContent.do"
							method="POST" enctype="multipart/form-data">

							<input type="text" class="form-control" name="title" id="title"
								value="${community.title}"> <br>
							<div class="row">
								<div class="form-group col-12">
									<label for="textContent">내용</label>
									<textarea name="content" id="textContent" cols="30" rows="12"
										placeholder="내용을 입력해주세요." class="form-control"
										style="resize: none;">"${community.content}"</textarea>
									<div class="counter" style="float: right;">
										<span id="count">0</span><span>/1000</span>
									</div>
								</div>
							</div>
							<!-- 아이디 -->
							<input type="hidden" name="Id" value="${loginMember.id}" />
							<!-- 게시물 번호 -->
							<input type="hidden" name="no"
								value="${community.communityNo}" />
							<hr />
							<div class="row justify-content-between">
								<div class="col-10">기존 첨부파일</div>
								<div class="col-1">삭제</div>
							</div>
							<br />
							
							

							<!-- 기존 첨부파일 -->
								<c:forEach items="${community.file}" var="file" varStatus="vs">
	<a href="${pageContext.request.contextPath}/board/fileDownload.do?fileNo=${file.no}"
	role="button"
	class="btn btn-outline-success btn-block">
	첨부파일 ${vs.count} - ${file.originalFilename}</a>
	<hr>
	</c:forEach>

<c:forEach items="${community.file}"  var="file" varStatus="vs">
	<img src="${pageContext.request.contextPath}/resources/img/board/${file.renamedFilename}">
								
	</c:forEach>
							
							<hr />
							<!-- 새 첨부파일 -->
							<div>첨부파일 추가</div>
							<span id="createInputFileByButton">
								<div class="form-group">
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<button class="btn btn-primary" type="button"
												onclick="createInputFile()" style="width: 50px;"
												id="button-addon1">+</button>
										</div>
										<div class="custom-file">
											<input type="file" name="upFile1"
												class="w-70 custom-file-input" id="inputGroupFile01"
												aria-describedby="button-addon1" style="cursor: pointer;" />
											<label class="custom-file-label" for="inputGroupFile01">클릭해서
												파일 추가하기</label>
										</div>
									</div>
								</div>
							</span>
							<div style="color: red;" id="fileMessage"></div>


							<br /> <br />
							<div class="form-group">
								<div class="row justify-content-around">
									<div class="col-4">
										<input type="button" value="수정 취소" id="cancelWriting"
											class="btn btn-primary btn-block" onclick="cancel();" />
									</div>
									<div class="col-4">
										<input type="submit" value="수정 완료" id="submitButton"
											class="btn btn-primary btn-block" />
									</div>
								</div>
							</div>

						</form>
						<br /> <br />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
