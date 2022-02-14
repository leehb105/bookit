<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- spring-webmvc의존 : security의 xss대비 csrf토큰 생성 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 인증객체의 principal속성을 pageContext 속성으로 저장 -->
<sec:authentication property="principal" var="loginMember"/>

<script src="${pageContext.request.contextPath}/resources/js/curreny.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>


<jsp:include page="/WEB-INF/views/member/common/sidebar.jsp"/>    

<!-- <div class="container mx-3"> -->
    <!-- <div class="roberto-contact-form-area wow fadeInUp section-padding-100" data-wow-delay="100ms">
        <div class="container-fluid"> -->
                <!-- <div class="roberto-news-area section-padding-30-0"> -->
                <div class="col-10">
                    <table class="table align-middle table-hover" style="text-align: center;">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th colspan="2">제목</th>
                                <th>작가</th>
                                <th>별점</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="bookReview" varStatus="status">
                                <tr onclick="openModal('${bookReview.content}', '${bookReview.reviewNo}');" style="cursor:pointer;">
                                    <td class="align-middle">${page.total - ((page.cri.pageNum - 1) * page.cri.amount) - status.index}</td>
                                    <td class="align-middle"><img src="${bookReview.bookInfo.cover}" alt="" style="width: 30%;"></td>
                                    
                                    <td class="title align-middle" style="text-align: left;">${bookReview.bookInfo.title}</td>
                                    <td class="author align-middle">
                                        ${bookReview.bookInfo.author}
                                    </td>
                                    <td class="rating align-middle">
                                        <div class="star-ratings">
                                            <div 
                                            class="star-ratings-fill space-x-2 text-lg"
                                            :style="{ width: ratingToPercent + '%' }"
                                            >
                                            <c:choose>
                                                <c:when test="${bookReview.rating == 1}">
                                                    <span>★</span>
                                                </c:when>
                                                <c:when test="${bookReview.rating == 2}">
                                                    <span>★</span><span>★</span>
                                                </c:when>
                                                <c:when test="${bookReview.rating == 3}">
                                                    <span>★</span><span>★</span><span>★</span>
                                                </c:when>
                                                <c:when test="${bookReview.rating == 4}">
                                                    <span>★</span><span>★</span><span>★</span><span>★</span>
                                                </c:when>
                                                <c:when test="${bookReview.rating == 5}">
                                                    <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                                </c:when>
                                            </c:choose>
                                            </div>
                                            <div class="star-ratings-base space-x-2 text-lg">
                                                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                            </div>
                                        </div>

                                    </td>
                                    <!-- <input type="hidden" id="content" value=""> -->
    
                                </tr>
                                <!-- 모달 -->
                                <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">100자 평</h5>
                                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">X</span>
                                                </button>
                                            </div>
                                            <div class="modal-body" id="modalContent"></div>
                                            <div class="modal-footer">
                                                <form:form method="post" id="deleteFrm">
                                                    <button class="btn" type="button" onclick="deleteReview();" data-dismiss="modal">리뷰 삭제</button>
                                                    <input type="hidden" name="reviewNo" id="reviewNo" value="">
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
    
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="5"><p>작성하신 도서 리뷰가 없습니다.</p></td>
                                </tr>
                            </c:if>
                        </tbody>
                        
                    </table>
                    <!-- Pagination -->
                    <nav class="roberto-pagination mb-100">
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
        
                    <form id='actionForm' action="${pageContext.request.contextPath}/member/reviewList.do" method="get"> 
                        <input type="hidden" name="pageNum" value="${page.cri.pageNum}"> 
                        <input type="hidden" name="amount" value="${page.cri.amount}"> 
                    </form>
                </div>
                
            </div>	
            
        </div>

        <!-- Booking Area End -->
    <script>

        window.onload = function(){
        const title = document.getElementsByClassName('title');
        const author = document.getElementsByClassName('author');
        console.log(title.length);
        for(let i = 0; i < title.length; i++){
            if(title[i].innerHTML.includes('-')){
                //- 하이픈(부제) 있을시에 자르기
                title[i].innerHTML = title[i].innerHTML.substr(0, title[i].innerHTML.indexOf('-'));
            }
            if(author[i].innerHTML.includes('(지은이)')){
                //작가명 (지은이)뒤로 자름 -> 뒤는 엮은이임
                author[i].innerHTML = author[i].innerHTML.substr(0, author[i].innerHTML.indexOf('(지은이)'));
            }
            
        }

    };
    var actionForm = $('#actionForm'); 
	$('.page-item a').on('click', function(e) { e.preventDefault(); 
		//걸어둔 링크로 이동하는 것을 일단 막음 
		actionForm.find('input[name="pageNum"]').val($(this).attr('href')); 
		actionForm.submit(); 
	});
    
    //모달에 리뷰 상세내용 출력
    function openModal(content, no){
        console.log(content);
        console.log(no);
        // e.preventDefault();
        $('#reviewModal').modal("show");
        document.getElementById('modalContent').innerHTML = content;
        document.getElementById('reviewNo').value = no;
    }
    
    //리뷰 삭제
    function deleteReview(){

        const url = `${pageContext.request.contextPath}/member/bookReviewDelete.do`;
        $('#deleteFrm').attr("action", url);
        $('#deleteFrm').submit();


    }
    
    </script>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
