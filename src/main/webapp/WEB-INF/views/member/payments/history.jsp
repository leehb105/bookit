<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<jsp:include page="/WEB-INF/views/member/common/sidebar.jsp"/>    
<style>
	td, th {
		text-align: center;
	}
</style>
<div class="container col-10">
 <div class="col-7">
	<a href="${pageContext.request.contextPath}/member/memberProfile.do">마이페이지</a> > 북토리 관리 > 결제 내역 
	<h2>결제 내역</h2>
</div>

<p>
<span>내 북토리: </span><span id="myCash">${loginMember.cash}원</span><button type="button" onclick="location.href='${pageContext.request.contextPath}/member/payments/charge.do'">북토리 충전</button>
</p>

<table class="table table-condensed">
    <thead>
      <tr class="table-success">
        <th>충전 일자</th>
        <th>충전 금액</th>
        <th>추가 지급액</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="history">
		  <tr>
			  <td><fmt:formatDate value="${history.chargeDate}" pattern="yyyy.MM.dd HH:mm"/></td>
			  <td>${history.chargeCash}</td>
			  <td>${history.bonusCash}</td>
		  </tr>      
      </c:forEach>
    </tbody>
  </table>
  <script>console.log("${list}")</script>
</div>


</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>