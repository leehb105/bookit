<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>
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
	  var bubbleData = {
			  datasets: [{
				    label: 'First Dataset',
				    data: [{
				      x: 20,
				      y: 30,
				      r: 15
				    }],
				    backgroundColor: 'rgb(255, 99, 132)'
				  },
				  {
					label: 'Second Dataset',
					data: [{
						x: 25,
					    y: 25,
					    r: 10
					  }],
					backgroundColor: 'rgb(255, 100, 22)'
					}
				  
				  
				  ]
				};
	  var config = {
	    type: 'bubble',
	    data: bubbleData,
	    options: {}
	  };
	  var myChart = new Chart(
			    document.getElementById('myChart'),
			    config
			  );
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>