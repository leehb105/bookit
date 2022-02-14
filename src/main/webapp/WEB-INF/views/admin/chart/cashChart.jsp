<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<div class="container member-profile">
       		<div class="row">
               <div class="col-2">
                   <div class="profile-work">
                       <a href="#"><p>회원목록</p></a>
                       <p>통계</p>	
 				 	   <a href="${pageContext.request.contextPath}/admin/chart/chart.do">-가입 회원</a><br />
 				 	   <a href="${pageContext.request.contextPath}/admin/chart/cashChart.do">-북토리 충전</a>
                   </div>
               </div>
               <div class="container-chart">

					<div class ="main-chart">
			  			<canvas id="myChart" style="width : 800px;"></canvas>
					</div>
				</div>
		   </div>           
	</div>
	
<script>
$(document).ready(function() {
	  var labels = [
		    '1월',
		    '2월',
		    '3월',
		    '4월',
		    '5월',
		    '6월'
		  ];
	const data = {
	  labels: labels,
	  datasets: [{
	    label: '2022년 북토리 충전 금액',
	    data: [${cash[0]},${cash[1]}],
	    backgroundColor: [
	      'rgba(255, 99, 132, 0.2)',
	      'rgba(255, 159, 64, 0.2)',
	      'rgba(255, 205, 86, 0.2)',
	      'rgba(75, 192, 192, 0.2)',
	      'rgba(54, 162, 235, 0.2)',
	      'rgba(153, 102, 255, 0.2)',
	      'rgba(201, 203, 207, 0.2)'
	    ],
	    borderColor: [
	      'rgb(255, 99, 132)',
	      'rgb(255, 159, 64)',
	      'rgb(255, 205, 86)',
	      'rgb(75, 192, 192)',
	      'rgb(54, 162, 235)',
	      'rgb(153, 102, 255)',
	      'rgb(201, 203, 207)'
	    ],
	    borderWidth: 1
	  }]
	};
	
	const config = {
			  type: 'bar',
			  data: data,
			  options: {
			    scales: {
			      y: {
			        beginAtZero: true
			      }
			    }
			  },
			};
	
	  var myChart = new Chart(
			    document.getElementById('myChart'),
			    config
			  );
	
	
});

</script>
	
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>