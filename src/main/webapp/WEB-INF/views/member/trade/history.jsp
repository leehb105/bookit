<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<jsp:include page="/WEB-INF/views/member/common/sidebar.jsp"/>    
<style>
	td, th {
		text-align: center;
	}
</style>
<div class="container col-10">
 <div class="col-7">
	<a href="${pageContext.request.contextPath}/member/memberProfile.do">마이페이지</a> > 북토리 관리 > 거래 내역 
	<h2>거래 내역</h2>
</div>

<table class="table table-condensed">
    <thead>
      <tr class="table-success">
        <th>거래 일자</th>
        <th>대여비</th>
        <th>잔액</th>
        <th>추가 지급액</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${borrowList}" var="history">
		  <tr>
			  <td><fmt:formatDate value="${history.tradeDate}" pattern="yyyy.MM.dd HH:mm"/></td>
			  <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${history.price}" />원</td>
			  <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${history.borrowerCash}" />원</td>
			 <!-- <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${history.deposit}" />원</td> -->
		  </tr>      
      </c:forEach>
    </tbody>
  </table>
  <script>console.log("${borrowList}")</script>

<table class="table table-condensed">
    <thead>
      <tr class="table-success">
        <th>거래 일자</th>
        <th>대여비</th>
        <th>잔액<th>
        <th>추가 지급액</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${lendList}" var="history2">
		  <tr>
			  <td><fmt:formatDate value="${history2.tradeDate}" pattern="yyyy.MM.dd HH:mm"/></td>
			  <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${history2.price - history2.deposit}" />원</td>
			  <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${history2.lenderCash}" />원</td>
		  </tr>      
      </c:forEach>
    </tbody>
  </table>
  <script>console.log("${lendList}")</script>
</div>


</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>