<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp"/> 


<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
	

<br /><br />



    <div class="container">
        <div class="row">
			<div class="col-md-5 mx-auto">
			<div id="first">
				<div class="myform form ">
					 <div class="logo mb-3">
						 <div class="col-md-12 text-center">
							<h1>로그인</h1>
								<c:if test="${param.error != null}">
									<span class="text-danger"> 아이디 또는 비밀번호가 일치하지 않습니다.</span>
								</c:if>
						 </div>
					</div>
                   <form:form 
                   		action="${pageContext.request.contextPath}/member/memberLogin.do" 
                   		method="POST" 
                   		name="login" 
                   		id="login" 
                   		novalidate="novalidate">
                       <div class="form-group">
                          <label for="id">아이디</label>
                          <input type="text" name="id" class="form-control" id="id" aria-describedby="idHelp" placeholder="아이디를 입력하세요">
                                                    
                       </div>
                       <div class="form-group">
                          <label for="password">비밀번호</label>
                          <input type="password" name="password" id="password" class="form-control" aria-describedby="passwordHelp" placeholder="비밀번호를 입력하세요">
                       </div>
                       
                       <div class="col-md-12 text-center ">
                          <input type="submit" class="btn roberto-btn w-100" value="로그인">
                       </div>
                       </form:form>
                       <div class="col-md-12 ">
                          <div class="login-or">
                             <hr class="hr-or">
                             <span class="span-or">or</span>
                          </div>
                       </div>
                       <div class="col-md-12 mb-3">
                          <p class="text-center">
                             <a href="javascript:void();" class="google btn mybtn"><i class="fa fa-google-plus">
                             </i> Signup using Google
                             </a>
                          </p>
                       </div>
                       <div class="col-md-12 mb-3" id="kakaologin">
                       <div class="kakaobtn">
                          <p class="text-center">
                          	 <input type="hidden" name="kakaoemail" id="kakaoemail" />
							 <input type="hidden" name="kakaonickname" id="kakaonickname" />
                             <a href="javascript:kakaoLogin();" class="kakao btn mybtn"><i class="fa fa-comment">
                             </i> Signup using KaKao
                             </a>
                          </p>
                       </div>
                       </div>
                       <div class="form-group">
                          <p class="text-center">Bookit이 처음이신가요? <a href="${pageContext.request.contextPath}/member/memberEnroll.do" id="signup">회원가입</a></p>
                       </div>

                 
				</div>
			</div>
			</div>
		</div>
      </div>   
         

<br /><br /><br /><br /><br /><br />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
  //카카오로그인
  function kakaoLogin() {

    $.ajax({
        url: '/bookit/member/login/getKakaoAuthUrl',
        type: 'get',
        async: false,
        dataType: 'text',
        success: function (res) {
            location.href = res;
        }
    });

  }

  $(document).ready(function() {

      var kakaoInfo = '${kakaoInfo}';

      if(kakaoInfo != ""){
          var data = JSON.parse(kakaoInfo);

          alert("카카오로그인 성공 \n accessToken : " + data['accessToken']);
          alert(
          "user : \n" + "email : "
          + data['email']  
          + "\n nickname : " 
          + data['nickname']);
      }
  });  

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
