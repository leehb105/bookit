<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


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
						 </div>
					</div>
                   <form action="${pageContext.request.contextPath}/member/memberLogin.do" method="post" name="login" id="login">
                       <div class="form-group">
                          <label for="id">아이디</label>
                          <input type="text" name="id"  class="form-control" id="id" aria-describedby="emailHelp" placeholder="아이디를 입력하세요">
                                                    
                       </div>
                       <div class="form-group">
                          <label for="password">비밀번호</label>
                          <input type="password" name="password" id="password" class="form-control" aria-describedby="passwordHelp" placeholder="비밀번호를 입력하세요">
                       </div>
                       
                       <div class="col-md-12 text-center ">
                          <input type="submit" class="btn roberto-btn w-100" value="로그인">
                       </div>
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
                       <div class="col-md-12 mb-3">
                          <p class="text-center">
                             <a href="javascript:void();" class="kakao btn mybtn"><i class="fa fa-comment">
                             </i> Signup using KaKao
                             </a>
                          </p>
                       </div>
                       <div class="form-group">
                          <p class="text-center">Bookit이 처음이신가요? <a href="${pageContext.request.contextPath}/member/memberEnroll.do" id="signup">회원가입</a></p>
                       </div>
                    </form>
                 
				</div>
			</div>
			</div>
		</div>
      </div>   
         

<br /><br /><br /><br /><br /><br />
<script>
/* $("#signup").click(function() {
	$("#first").fadeOut("fast", function() {
	$("#second").fadeIn("fast");
	});
	});

	$("#login").click(function() {
	$("#second").fadeOut("fast", function() {
	$("#first").fadeIn("fast");
	});
	}); */

	        /*   $(function() {
	           $('#login').validate({
	             rules: {
	               
	               id: {
	                 required: true,
	                 
	               },
	               password: {
	                 required: true,
	                 
	               }
	             },
	              messages: {
	               id: {
	            	   required: "아이디를 입력해주세요",
	            	   
	               },
	              
	               password: {
	                 required: "비밀번호를 입력해주세요",
	                
	               }
	               
	             },
	             submitHandler: function(form) {
	               form.submit();
	             }
	           });
	         });
	          */


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
