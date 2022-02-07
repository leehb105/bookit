<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<jsp:include page="/WEB-INF/views/member/common/sidebar.jsp"/>    
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
	td, th {
		text-align: center;
	}
</style>
<div class="container col-10">
 <div class="col-7">
	<a href="${pageContext.request.contextPath}/member/memberProfile.do">마이페이지</a> > 북토리 관리 > 북토리 충전 
	<h2>북토리 충전</h2>
</div>

<p>
<span>내 북토리: <fmt:formatNumber type="number" maxFractionDigits="3" value="${loginMember.cash}" />토리</span>
</p>

<table class="table table-condensed">
    <thead>
      <tr class="table-success">
        <th>선택</th>
        <th>충전 금액</th>
        <th>추가 지급액</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><input type="radio" id="twoThousand" name="amount" value=2000></td>
        <td><label for="twoThousand">2,000원</label></td>
        <td>+50토리</td>
      </tr>      
      <tr>
        <td><input type="radio" id="fiveThousand" name="amount" value=5000></td>
        <td><label for="fiveThousand">5,000원</label></td>
        <td>+150토리</td>
      </tr>      
      <tr>
        <td><input type="radio" id="tenThousand" name="amount" value=10000></td>
        <td><label for="tenThousand">10,000원</label></td>
        <td>+300토리</td>
      </tr>      
      <tr>
        <td><input type="radio" id="twentyThousand" name="amount" value=20000></td>
        <td><label for="twentyThousand">20,000원</label></td>
        <td>+600토리</td>
      </tr>      
    </tbody>
  </table>
  <div class="text-center">
	  <img src="${pageContext.request.contextPath}/resources/img/payment_icon_yellow_small.png" alt="" onclick="requestPay()"/>
  </div>
</div>

<script>
	const IMP = window.IMP;
	IMP.init("${iamportUid}"); // 가맹점 식별코드
	
	function requestPay() {
		// 결제창 호출
		IMP.request_pay({
			pg: 'kakaopay',
			pay_method: 'kakaopay',
			// merchant_uid: '생략하여 자동발급',
			name: '북토리 ' + ($('input[name="amount"]:checked').val() / 1000) + ',000토리', // 상품이름(회원의 이름 x)
			amount: $('input[name="amount"]:checked').val(),
			buyer_email: '${loginMember.email}',
			buyer_name: '${logimMember.name}',
			buyer_tel: '${loginMember.phone}',
			// buyer_addr:
			// buyer_postcode:
			custom_data: '${loginMember.id}'
		}, function(res) {
			if(res.success) {
				console.log('결제 성공');
				$.ajax({
					url: '${pageContext.request.contextPath}/member/payments/charge.do',
					method: 'POST',
					headers: { 'Content-Type' : 'application/json; charset=utf-8'},
					data: JSON.stringify({
						impUid: res.imp_uid,
						merchantUid: res.merchant_uid,
						pgTid: res.pg_tid,
						chargeCash: res.paid_amount,
						chargeDate: res.paid_at * 1000, // UNIXTIMESTAMP * 1000
						memberId: res.custom_data, // 회원 아이디는 custom_data로 + 추가적인 데이터가 필요한 경우 custom_data에 함께 담아 보내기
						// Content-type: application/json?
						// https://denodo1.tistory.com/322
						
					}),
				}).done(function(data) {
					// 가맹점 서버 결제 api 성공시 로직	
					console.log('가맹정 api 성공');
					console.log(data);
					alert(data + '원 충전 성공')
					// 북토리 총액 표시하기
				}).fail(function() {
					console.log('fail');
				});
			} else {
				console.log('결제 실패' + res.error_msg);
			}
		});	
	}
	
</script>

</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>