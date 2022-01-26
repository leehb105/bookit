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
 				 	   <a href="${pageContext.request.contextPath}/admin/chart.do">-가입 회원</a><br />
 				 	   <a href="#">-회원 주소</a><br />
 				 	   <a href="#">-리뷰 작성</a><br />
 				 	   <a href="#">-북토리 충전</a>
                   </div>
               </div>
        
				<div class ="container-chart">
		  			<canvas id="myChart" style="width : 800px;"></canvas>
				</div>
		   </div>           
	</div>


<script>



const labels = [
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
      label: '가입 회원수',
      backgroundColor: 'rgb(255, 99, 132)',
      borderColor: 'rgb(255, 99, 132)',
      data: [${arr[0]}, ${arr[1]}, ${arr[2]}, ${arr[3]}, ${arr[4]}, ${arr[5]},${arr[6]}],
    }]
  };

  const config = {
    type: 'line',
    data: data,
    options: {}
  };
  const myChart = new Chart(
		    document.getElementById('myChart'),
		    config
		  );

</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>