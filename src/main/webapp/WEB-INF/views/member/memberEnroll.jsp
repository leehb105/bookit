<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>



<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/kakaoPostcode.js"></script>
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrit6="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<br /><br />



    <div class="container">
        <div class="row">
			<div class="col-md-5 mx-auto">
			
			<div id="second">
			      <div class="myform form">
                        <div class="logo mb-3">
                           <div class="col-md-12 text-center">
                              <h1 >회원가입</h1>
                           </div>
                        </div>                        
                        <form action="${pageContext.request.contextPath}/member/memberEnroll.do" method="post" name="registration">
                           <div class="form-group">
                              <label for="exampleInputEmail1">아이디</label>
                              <input type="text"  name="id" class="form-control" id="id" aria-describedby="emailHelp" placeholder="아이디를 입력하세요">
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">비밀번호</label>
                              <input type="password" name="password" id="password" class="form-control" aria-describedby="idHelp" placeholder="비밀번호를 입력하세요">
                              <!-- <span id="idHelp">영문, 숫자가 하나 이상 포함된 8-16자리의 암호를 입력하세요.</span> -->
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">비밀번호 확인</label>
                              <input type="password" id="passwordCheck" class="form-control" aria-describedby="passwordHelp" placeholder="비밀번호를 한번 더 입력하세요">
                              <!-- <span id="passwordHelp">8-16자리의 암호를 입력하세요.영문, 숫자가 하나 이상 포함되어야하며, 영문 중 하나 이상은 반듯이 대문자여야 합니다.</span> -->
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">이름</label>
                              <input type="text"  name="name" class="form-control" id="name" aria-describedby="emailHelp" placeholder="이름을 입력하세요">
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">닉네임</label>
                              <input type="text"  name="nickname" class="form-control" id="nickname" aria-describedby="emailHelp" placeholder="닉네임을 입력하세요">
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">이메일</label>
                              <input type="email" name="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="이메일을 입력하세요">
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">휴대폰</label>
                              <input type="tel" name="phone" id="phone" class="form-control" aria-describedby="emailHelp" placeholder="숫자만 입력하세요">
                           </div>
                           <div class="form-group">
							  <label for="postcode">주소</label>
							  <div class="row">
								<input type="text" onclick="execDaumPostcode()" name="postcode" id="postcode" class="form-control col-6" placeholder="우편번호" readonly required>
								<input type="button" onclick="execDaumPostcode()" class="btn roberto-btn w-10 col-4" value="우편번호 찾기"><br>
							  </div>
							  <div class="row">
							    <input type="text" name="roadAddress" id="roadAddress" class="form-control col-6" placeholder="도로명주소" readonly required>
							    <input type="text" name="jibunAddress" id="jibunAddress" class="form-control col-6" placeholder="지번주소" readonly required>
							  </div>
							  <span id="guide" style="color:#999;display:none"></span>
						      <div class="row">
						  	    <input type="text" name="detailAddress" id="detailAddress" class="form-control col-8" placeholder="상세주소">
						 	    <input type="text" name="extraAddress" id="extraAddress" class="form-control col-4" placeholder="참고항목" readonly>
						      </div>
                           </div>
                           <div class="col-md-12 text-center mb-3">
                              <button type="submit" class="btn roberto-btn w-100">가입하기</button>
                           </div>
                           <div class="col-md-12 ">
                              <div class="form-group">
                                 <p class="text-center"><a href="${pageContext.request.contextPath}/member/memberLogin.do" id="login">이미 Bookit 회원이신가요?</a></p>
                              </div>
                           </div>
                        </form>
                            </div>
                     </div>
			</div>
		</div>
      </div>   
         

<br /><br /><br /><br /><br /><br />
<script>


	/* $(function() {
	  
	  $("form[name='registration']").validate({
	    rules: {
	      id: "required",
	      name: "required",
	      nickname: "required",
	      email: {
	        required: true,
	        email: true
	      },
	      password: {
	        required: true
	      }
	    },
	    
	    messages: {
	      id: "아이디를 입력하세요",
	      name: "이름을 입력하세요",
	      nickname: "닉네임을 입력하세요",
	      password: {
	        required: "비밀번호를 입력하세요"
	      },
	      email: "이메일을 입력하세요"
	    },
	  
	    submitHandler: function(form) {
	      form.submit();
	    }
	  });
	});
 */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
