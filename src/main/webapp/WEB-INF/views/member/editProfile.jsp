<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>


<jsp:include page="/WEB-INF/views/common/header.jsp"/>


	<div class="container member-profile">
    	<form method="get" action="${pageContext.request.contextPath}/member/editProfile.do">
               <!-- <div class="row">
				<div class="col-2">
				</div>
				<div class="col-9">
				<br /><br />
				마이페이지 > 정보수정
				</div>
               </div> -->
       		<div class="row">
               <div class="col-2">
                   <div class="profile-work">
                       <a href="${pageContext.request.contextPath}/member/mypageMain.do"><p>마이페이지HOME</p></a>
                       <a href="${pageContext.request.contextPath}/member/editProfile.do">정보 수정</a><br/>
                       <p>북토리 관리</p>
                       <a href="">결제 내역</a><br/>
                       <a href="">거래 내역</a><br/>
                       <a href="">북토리 충전</a>
                       <p>나의 게시글</p>
                       <a href="">게시글 작성목록</a><br/>
                       <a href="">리뷰 작성목록</a><br/>
                       <p>1:1 문의</p>
                       <a href="${pageContext.request.contextPath}/inquire/inquireForm.do">1:1 문의하기</a><br/>
                       <a href="${pageContext.request.contextPath}/inquire/inquireList.do">1:1 문의내역</a><br/>
                       <p>신고내역</p>
                       <a href="">나의 신고목록</a><br/>
                   </div>
               </div>
               <div class="col-1">
               </div>
                    <div class="col-3">
                       	<a href="${pageContext.request.contextPath}/member/memberProfile.do">마이페이지</a> > 정보수정
                        <div class="profile-img"><br /><br />
                            <img src="${pageContext.request.contextPath}/resources/img/default_profile.png" alt=""/>
                       		<div class="file btn btn-lg">
                          		사진 변경<input type="file" name="file"/>
                       		</div>
                        </div>
                    </div>
                    
	                        
	                <div class="col-6">
	                    <div class="row">
	                        <div class="col-md-4"><br /><br />
	                            <label>아이디</label>
	                        </div>
	                        <div class="col-md-4"><br /><br />
	                            <p>honggd</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>닉네임</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>길동이이잉</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>비밀번호</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>1234</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>비밀번호 확인</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>1234</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>이메일</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>h@gmail.com</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>주소</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>주소...</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>연락처</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>01012341234</p>
	                        </div>
	                    </div>
                            <input type="submit" class="btn roberto-btn w-10 mt-30" value="수정">
                    </div>
                            
                </div>
            </form>           
        </div>






<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
