<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색결과</title>
    <!-- Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/roberto/style.css">


</head>
<body>
    
    <div class="roberto-news-area section-padding-100-0">
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
                    <div class="roberto-contact-form">
                        <!-- <form action="${pageContext.request.contextPath}/booking/bookSearch.do" method="get">     -->
                            <div class="col-12 wow fadeInUp form-inline form-group" data-wow-delay="100ms">
                                <c:forEach var="book" items="${list }" varStatus="status">    
                                    <!-- index시작 -->
                                    <div class="single-blog-post d-flex align-items-center mb-50 wow fadeInUp w-75" data-wow-delay="100ms" id="book${status.index}">
                                        <!-- index: [0] -->
                                        <div class="post-thumbnail w-25">
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
                                            <a href="${pageContext.request.contextPath}/booking/bookingEnroll.do" class="post-title" id="title">${book.title }</a>
                                            <!-- List Author, publisher, pubdate -->
                                            <!-- index: [1][1] -->
                                            <p><span id="author">${book.author}</span> 저 | <span id="publisher">${book.publisher}</span> | <span id="pubdate"><input type="hidden" value="<fmt:formatDate value='${book.pubdate }' pattern='yyyy-MM-dd'/>"><fmt:formatDate value="${book.pubdate }" pattern="yyyy년 MM월"/></span></p>
                                            <!-- index: [1][2][0] -->
                                            <p>ISBN | <span id="isbn">${book.isbn13}</span></p>
                                            <!-- index: [1][3] -->
                                            <input type="hidden" value="${book.itemPage}">
                                            <!-- index: [1][4] -->
                                            <input type="hidden" value="${book.categoryName}">
                                            <!-- index: [1][5] -->
                                            <input type="hidden" value="${book.description}">
                                            <!-- <input type="hidden"> -->
                                        </div>
                                        <button type="button" class="btn roberto-btn" onclick="setBookInfo(this)">선택</button>
                                    </div>
					            </c:forEach>                                    
                            </div>                         
                        <!-- </form> -->
                    </div>
                </div>
            </div>
        </div>
    </div>








</body>


<script>
    //부모창으로 값 전달
    function setBookInfo(btn){
        // console.log(btn);
        // console.log(document.getElementById('title').innerText);
        // console.log(this.document.getElementById('title'));
        const div = btn.parentNode;
        book = toJson(div);
        console.log(book);
        

        // //json 데이터 전달
        localStorage.setItem("book", JSON.stringify(book));
        // opener.document.getElementById('testInput').value = book;
        opener.getJson();
        window.close();

        
    }

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
            "isbn": isbn,
            "itemPage": itemPage,
            "categoryName": categoryName,
            "description":description,
        };

        return book;
    }
</script>
</html>