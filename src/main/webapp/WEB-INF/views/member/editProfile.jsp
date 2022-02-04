<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>


<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
$(() => {
	$(memberUpdateFrm).submit((e) => {
    	// nickname
    	if(!/^[가-힣]{2,}$/.test($(nickname).val())){
    		alert("닉네임은 한글 2글자 이상이어야 합니다.");
    		return false;
    	}
    	/* // password
    	if(!/^[a-zA-Z0-9]{8,16}$/.test($(password).val())){
    		alert("비밀번호는 숫자와 영문 조합으로 8~16자리만 사용 가능합니다.")
    		return false;
    	} */
    	// email
    	if(!/^[\w]{3,}@[\w]+(\.[\w]+){1,3}$/.test($(email).val())){
    		alert("올바르지 않은 이메일 형식입니다.")
    		return false;
    	}
    	// phone
    	if(!/^010[0-9]{8}$/.test($(phone).val())){
    		alert("유효한 전화번호가 아닙니다.");
    		return false;
    	}
    	return true;
    });
});
</script>

	<div class="container member-profile">
    	<form name="memberUpdateFrm" method="POST" action="${pageContext.request.contextPath}/member/memberUpdate.do">
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
	                            <label>이름</label>
	                        </div>
	                        <div class="col-md-4"><br /><br />
	                            <p>${loginMember.name}</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>아이디</label>
	                        </div>
	                        <div class="col-md-4">
	                            <p>${loginMember.id}</p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>닉네임</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="text" name="nickname" id="nickname" value="${loginMember.nickname}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>비밀번호</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="password" name="password" id="password" value="${loginMember.password}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>비밀번호 확인</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="password" name="passwordCheck" id="passwordCheck" value="${loginMember.password}" required>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-4">
	                            <label>이메일</label>
	                        </div>
	                        <div class="col-md-4">
	                            <input type="email" name="email" id="email" value="${loginMember.email}" required>
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
	                            <input type="tel" name="phone" id="phone" maxlength="11" value="${loginMember.phone}">
	                        </div>
	                    </div>
                            <input type="submit" class="btn roberto-btn w-10 mt-30" value="수정">
                    </div>
                            
                </div>
            </form>           
        </div>






<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
