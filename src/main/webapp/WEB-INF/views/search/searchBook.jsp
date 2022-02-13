<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<!-- Booking Area Start -->
    <div class="roberto-news-area mt-50">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <!-- Section Heading -->
                    <div class="section-heading text-left wow fadeInUp" data-wow-delay="100ms">
                        <c:if test="${totalResults ne 0}">
                            <h5><span style="color: #1cc3b2;">"${query}"</span> 총 ${totalResults}개의 도서가 검색되었습니다.</h5>
                            <hr class="my-2">
                        </c:if>
                        <c:if test="${totalResults eq 0}">
                            <h5><span style="color: #1cc3b2;">"${query}"</span>의 검색 결과가 없습니다.</h5>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Form -->
                    <div class="">
                        <!-- <form action="${pageContext.request.contextPath}/booking/bookSearch.do" method="get">     -->
                            <div class="col-12 wow fadeInUp" data-wow-delay="100ms">
                                <c:forEach var="book" items="${list }" varStatus="status">    
                                    <!-- index시작 -->
                                    <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp" data-wow-delay="100ms" id="book${status.index}">
                                        <!-- index: [0] -->
                                        <div class="mr-100">
                                            <!-- <input type="hidden" name="bno" value="${booking.boardNo}"> -->
                                            <!-- index: [0][0][0] -->
                                            <a href="#"><img src="${book.cover }" alt="" id="cover"></a>
                                        </div>
                                        <!-- List Content -->
                                        <!-- index: [1] -->
                                        <div class="post-content">
                                            <!-- List Meta -->
                                            <!-- List Title -->
                                            <!-- index: [1][0] -->
                                            <a href="${pageContext.request.contextPath}/search/bookDetail.do?isbn=${book.isbn13}&pageNum=1&amout=5" class="post-title" id="title">${book.title }</a>
                                            <!-- List Author, publisher, pubdate -->
                                            <!-- index: [1][1] -->
                                            <p><span id="author">${book.author}</span> 저 | <span id="publisher">${book.publisher}</span> | <span id="pubdate"><input type="hidden" value="<fmt:formatDate value='${book.pubdate }' pattern='yyyy-MM-dd'/>"><fmt:formatDate value="${book.pubdate }" pattern="yyyy년 MM월"/></span></p>
                                            <!-- index: [1][2][0] -->
                                            <p>ISBN | <span id="isbn">${book.isbn13}</span></p>
                                        </div>
                                    </div>
					            </c:forEach>                                  
                            </div>                         

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Booking Area End -->
<script>
	function toJson(div){

        const cover = div.children[0].children[0].children[0].src;
        const title = div.children[1].children[0].innerText;
        const author = div.children[1].children[1].children[0].innerText;
        const publisher = div.children[1].children[1].children[1].innerText;
        const pubdate = div.children[1].children[1].children[2].children[0].value;
        const isbn = div.children[1].children[2].children[0].innerText;
        const itemPage = div.children[1].children[3].value;
        const categoryName = div.children[1].children[4].value;
        const description = div.children[1].children[5].value;
        // console.log(pubdate, typeof pubdate);
        //json생성
        let book = {
            "cover": cover,
            "title": title,
            "author": author,
            "publisher": publisher,
            "pubdate": pubdate,
            "isbn13": isbn,
            "itemPage": itemPage,
            "categoryName": categoryName,
            "description":description,
        };

        return book;
    }

	








</script>
	

    <!-- Partner Area End -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
