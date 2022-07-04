<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<c:if test="${not empty msg}">
    <script>
        alert(msg);
    </script>
</c:if>
	<!-- 등록 폼 시작 -->
    <div class="roberto-contact-form-area" data-wow-delay="100ms">

        <!-- 검색결과 -->
        <div class="container wow fadeInUp">
            <div class="row align-items-center mt-50">
                <div class="col-12 col-lg-12">
                    <h3>도서 상세 정보</h3>
                    <!-- Single Room Details Area -->
                    <div class="single-room-details-area mb-50">
                        <hr class="my-2">
                        <div class="title mt-40">
                            <h4>${book.title}</h4>
                        </div>
                        <div class="single-blog-post d-flex align-items-center mb-50">

                            <img src="${book.cover}" class="d-block w-40 mx-5" alt="" id="cover">
                            <div class="post-content mx-5">
                                <!-- booking Title -->
                                <!-- <h4>${book.title}</h4> -->
                                <p></p>
                                <!-- 분류 -->
                                <p id="categoryName"></p>
                                <!-- 저자, 출판사, 출판일 -->
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td>분류</td>
                                        <td>${book.categoryName}</td>
                                    </tr>
                                    <tr>
                                        <td>저자</td>
                                        <td>${book.author}</td>
                                    </tr>
                                    <tr>
                                        <td>출판사</td>
                                        <td>${book.publisher}</td>
                                    </tr>
                                    <tr>
                                        <td>출판일</td>
                                        <td><fmt:formatDate value="${book.pubdate}" pattern="yyyy년 MM월"/></td>
                                    </tr>
                                    <tr>
                                        <td>ISBN</td>
                                        <td>${book.isbn13}</td>
                                    </tr>
                                    <tr>
                                        <td>쪽수</td>
                                        <td>${book.itemPage} 쪽</td>
                                    </tr>
                                </table>
                                
                            </div>
                        </div>
                        <h5>간략 소개</h5>
                        <p>${book.description}</p>
                        
                        <div class="review mt-100">
                            <form th:action method="post" id="enrollFrm" action="${pageContext.request.contextPath}/search/bookReviewEnroll.do">
                                <h3>별점 및 100자 평</h3>
                                <hr class="my-2">
                                <div class="star-rating space-x-4 mx-auto mt-40">
                                    <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
                                    <label for="5-stars" class="star pr-4">★</label>
                                    <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
                                    <label for="4-stars" class="star">★</label>
                                    <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
                                    <label for="3-stars" class="star">★</label>
                                    <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
                                    <label for="2-stars" class="star">★</label>
                                    <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
                                    <label for="1-star" class="star">★</label>
                                </div>
                                <div class="col-lg-12 mt-30 mb-30">
                                    <textarea class="form-control" id="content" name="content" aria-label="With textarea" rows="3" placeholder="100자 평을 남겨주세요 :-)" style="resize: none;"></textarea>
                                    <div class="float-right mt-2">
                                        <span id="count">0</span><span>/100</span>
                                    </div>
                                    
                                    <div class="col-12 mt-30 p-0">
                                        <button type="button" class="btn roberto-btn" id="enrollBtn" onclick="enrollBooking();">리뷰 등록</button>
                                    </div>
                                </div>
                                <input type="hidden" name="isbn" value="">
                                <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
                            </form>
                            <div class="comment_area mt-50 clearfix">
                                <ol>
                                    <h2>
                                        리뷰평점  &nbsp; <span style="color: #1cc3b2;">${avg}</span> 점
                                    </h2>
                                    <hr class="my-2">
                                    <!-- Single Comment Area -->
                                    <c:forEach var="review" items="${list}" varStatus="status">
                                        <li class="single_comment_area mt-30">
                                            <!-- Comment Content -->
                                            <div class="comment-content d-flex">
                                                <!-- Comment Author -->
                                                <div class="comment-author ml-40">
                                                    <c:if test="${review.member.profileImage eq null}">
                                                        <img src="${pageContext.request.contextPath}/resources/img/profile/default_profile.png" alt="author">
                                                    </c:if>
                                                    <c:if test="${review.member.profileImage ne null}">
                                                        <img src="${pageContext.request.contextPath}/resources/img/profile/${review.member.profileImage}" alt="author">
                                                    </c:if>
                                                    
                                                </div>
                                                <!-- Comment Meta -->
                                                <div class="comment-meta col-3">
                                                    <a href="#" class="post-date"><fmt:formatDate value="${review.regDate}" pattern="yyyy년 MM월 dd일"/></a>
                                                    <h5>${review.member.nickname}(${review.member.id})
                                                    
                                                        
                                                    </h5> 
                                                    <!-- 리뷰 별점처리 -->
                                                    <div class="star-ratings">
                                                        <div 
                                                        class="star-ratings-fill space-x-2 text-lg"
                                                        :style="{ width: ratingToPercent + '%' }"
                                                        >
                                                        <c:choose>
                                                            <c:when test="${review.rating == 1}">
                                                                <span>★</span>
                                                            </c:when>
                                                            <c:when test="${review.rating == 2}">
                                                                <span>★</span><span>★</span>
                                                            </c:when>
                                                            <c:when test="${review.rating == 3}">
                                                                <span>★</span><span>★</span><span>★</span>
                                                            </c:when>
                                                            <c:when test="${review.rating == 4}">
                                                                <span>★</span><span>★</span><span>★</span><span>★</span>
                                                            </c:when>
                                                            <c:when test="${review.rating == 5}">
                                                                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                                            </c:when>
                                                        </c:choose>
                                                        </div>
                                                        <div class="star-ratings-base space-x-2 text-lg">
                                                            <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                                        </div>
                                                    </div>


                                                    <p>${review.content}</p>
                                                    
                                                </div>
                                                <c:if test="${review.member.id eq loginMember.id}">
                                                    <form:form method="post" id="delReviewFrm" action="${pageContext.request.contextPath}/search/bookReviewDelete.do">
                                                        <button type="submit" class="btn btn-outline-success mt-25">삭제</button>
                                                        <input type="hidden" name="reviewNo" value="${review.reviewNo}">
                                                        <input type="hidden" name="isbn" value="${book.isbn13}">
                                                    </form:form>
                                                </c:if>
                                            </div>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${empty list}">
                                        <li class="single_comment_area mt-30">
                                            <h4>리뷰가 없습니다. 리뷰를 작성해보세요!</h4>
                                        </li>
                                    </c:if>
                                </ol>
                                <nav class="roberto-pagination wow fadeInUp mb-100" data-wow-delay="100ms">
                                    <ul class="pagination">
                                        <c:if test="${page.prev}"> 
                                            <li class="page-item"><a class="page-link" href="${page.startPage - 1}"> 이전 <i class="fa fa-angle-left"></i></a></li>
                                        </c:if>
                                        <c:forEach var="num" begin="${page.startPage }" end="${page.endPage }">
                                            <li class="page-item ${page.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${num}">${num}</a></li>
                                        </c:forEach>
                                        <c:if test="${page.next}">
                                            <li class="page-item"><a class="page-link" href="${page.endPage + 1}"> 다음 <i class="fa fa-angle-right"></i></a></li>
                                        </c:if>
            
                                    </ul>
                                </nav>
                                <form id='actionForm' action="${pageContext.request.contextPath}/search/bookDetail.do" method="get"> 
                                    <input type="hidden" name="isbn" value="">  
                                    <input type="hidden" name="pageNum" value="${page.cri.pageNum}"> 
                                    <input type="hidden" name="amount" value="${page.cri.amount}"> 
                                </form>
                            </div>
                        </div>

                    </div>

                    
                </div>

                
            </div>
        </div>
    </div>

    <!-- Rooms Area End -->
<script>

    //사용자 댓글 여부 코드
    let idResult = `${idResult}`;
    const content = document.getElementById('content');
    const enrollBtn = document.getElementById('enrollBtn');
    let starValue = 1;

    

    $(document).ready(function() {
        enrollBtn.disabled = 'false'; 

        //글내용 글자갯수 제한 코드
        $('#content').on('keyup', function() {
            
            $('#count').html($(this).val().length);
            
            if($(this).val().length > 100) {
                alert("100자까지만 입력할 수 있습니다.");
                $(this).val($(this).val().substring(0, 100));
                $('#count').html("100");
            }

            //리뷰 입력 0글자일경우, 별점입력 안할시 버튼 제출 금지
            if(content.value.length == 0 || !$('input:radio[name=rating]').is(':checked')){
                enrollBtn.disabled = true;
            }else{
                enrollBtn.disabled = false; 
            }

        });
        //별점 입력 체크
        $('input:radio[name=rating]').on('input', function() {

            //리뷰 입력 0글자일경우, 별점입력 안할시 버튼 제출 금지
            if(content.value.length == 0 || !$('input:radio[name=rating]').is(':checked')){
                enrollBtn.disabled = true;
            }else{
                enrollBtn.disabled = false; 
            }
        });
        
        //이미 로그인한 사용자가 리뷰작성을 했으면
        if(idResult > 0){
            content.placeholder = '이미 리뷰를 작성하셨습니다!';
            content.readOnly = 'true';
        }

        let input = document.querySelectorAll('input[type=radio]');

        // let input = document.getElementById('1-star');
        console.log(input);

     

        

    });

    //댓글 페이징 관련
    var actionForm = $('#actionForm'); 
	$('.page-item a').on('click', function(e) { e.preventDefault(); 
		//걸어둔 링크로 이동하는 것을 일단 막음 
		actionForm.find('input[name="pageNum"]').val($(this).attr('href')); 

		const url = new URL(window.location.href);
		const urlParams = url.searchParams;

		const isbn = urlParams.get('isbn');

		$('input[name=isbn').attr('value', isbn);

		actionForm.submit(); 
	});

    $('input[type=radio]').change(function(){
        starValue = this.value;
        // console.log(starValue);
    });

   
    var enrollFrm = $('#enrollFrm'); 
	$('#enrollBtn').on('click', function(e) { 
        e.preventDefault(); 
		//걸어둔 링크로 이동하는 것을 일단 막음 
		// actionForm.find('input[name="pageNum"]').val($(this).attr('href')); 

		const url = new URL(window.location.href);
		const urlParams = url.searchParams;

		const isbn = urlParams.get('isbn');

		$('input[name=isbn').attr('value', isbn);

		enrollFrm.submit(); 
	});

    




</script>
	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
