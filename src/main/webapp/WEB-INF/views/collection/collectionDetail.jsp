<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
function deleteBook(){
	var no = $("input[id=bookCollectionNo]").val();
	var checkedArr = new Array();
	var list = $("input[id=checkListNo]");
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){
			checkedArr.push(list[i].value);
		}
	}
	if(checkedArr.length == 0){
		alert("선택된 항목이 없습니다.");
	}
	else{
		var confitm = confirm("정말 삭제하시겠습니까?");
		$.ajax({
			url: `${pageContext.request.contextPath}/collection/collectionDetailDelete.do`,
			method: "POST",
			traditional: true,
			data: {
				checkedArr : checkedArr
			},
			success: function(res){
				if(res = 1){
					alert("삭제되었습니다.");
					location.replace(`${pageContext.request.contextPath}/collection/collectionDetail.do?no=\${no}`);
				}
				else{
					alert("다시 시도해주세요.");
				}
			},
			error: console.log
		});
	}
}

// 책추가 모달창
/* $(document).ready(function () {
    $("#reportDetailModal").on('show.bs.modal', function (event) {
    	
    });
}); */
$(() => {
	var nickname = $("input[id=nickname]").val();
	var collectionName = $("input[id=collectionName]").val();
	
	var title = document.getElementsByClassName('breadcrumb-content')[0];	
	var h2Tag = document.createElement('h2');
	h2Tag.innerHTML = nickname + '님의 ' + collectionName;
	h2Tag.className = 'page-title';
	title.prepend(h2Tag);
	
	var subTitle = document.getElementsByClassName('breadcrumb')[0];
	var liTag = document.createElement('li');
	liTag.innerHTML = nickname + '님의 ' + collectionName;
	liTag.className = 'breadcrumb-item active';
	subTitle.append(liTag);
	
});
</script>

<!-- Breadcrumb Area Start -->
<div class="breadcrumb-area bg-img bg-overlay jarallax" style="background-image: url(img/bg-img/16.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcrumb-content text-center">
                    <!-- javascript:h2생성 -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Collection</li>
                            <!-- javascript:li생성 -->
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb Area End -->

<!-- Rooms Area Start -->
<div class="roberto-rooms-area section-padding-100-0">
    <div class="container">
        
        <div class="row">
            <div class="col-12 col-lg-8 mb-50">
                <c:forEach items="${collectionDetailList}" var="collectionDetailList">
		                <div 
		                	class="single-room-area d-flex align-items-center mb-50 wow fadeInUp" 
		                	data-wow-delay="100ms">
		                    <!-- Room Thumbnail -->
		                    <c:set var="memberId" value="${collectionDetailList.memberId}"></c:set>
		                    <input type="hidden" id="nickname" value="${collectionDetailList.nickname}"/>
		                    <input type="hidden" id="collectionName" value="${collectionDetailList.collectionName}"/>
		                   	<input type="hidden" id="bookCollectionNo" value="${collectionDetailList.bookCollectionNo}"/>
		                   	<c:if test="${collectionDetailList.listNo ne null}">
		                   		<c:if test="${memberId eq loginMember.id}">
			                		<input type="checkbox" id="checkListNo" value="${collectionDetailList.listNo}"/>
			                    </c:if>
			                    <div class="room-thumbnail text-center">
			                        <img class="w-25" src="${collectionDetailList.cover}" alt="">
			                    </div>
			                    <!-- Room Content -->
			                    <div class="room-content">
			                        <h5>${collectionDetailList.title}</h5>
			                        <div class="room-feature">
			                            <h6>저자<span><small>${collectionDetailList.author}</small></span></h6>
			                            <h6><span></span></h6>
			                            <h6>출판사<span><small>${collectionDetailList.publisher}</small></span></h6>
			                        </div>
			                        <a 
			                        	href="${pageContext.request.contextPath}/collection/aaaa.do?ibsn13=${collectionDetailList.isbn13}"
			                        	class="btn view-detail-btn">상세정보 <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
			                        </a>
			                    </div>
		                    </c:if>
		                </div>
                </c:forEach>
				<c:if test="${empty bookList}">
					<p class="text-right mb-100 mr-100">추가하신 책 목록이 없습니다.</p>
				</c:if>
            </div>
            <c:if test="${memberId eq loginMember.id}">
	            <div class="col-12 col-lg-2">
					<div class="hotel-reservation--area mb-100 ml-100">
				        <div class="form-group">
				            <button 
				            	data-toggle="modal" 
	                        	data-target="#addBookModal" 
	                        	class="btn roberto-btn w-100">책 추가
	                        </button>
	                        <button class="btn roberto-btn w-100 mt-30" onclick="deleteBook();">선택 삭제</button>
				        </div>
					</div>
				</div>
			</c:if>
			
			<!-- Modal -->
			<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="addBookModalModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="addBookModalModalLabel">책추가</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">×</span>
			        </button>
			      </div>
			      <div class="modal-body">
			      	<div>
			      		<p>책책책책책</p>
			      		<input type="text" id="" value=""/>
			      	</div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" name="success" class="btn btn-success" onclick="">추가</button>
			      </div>
			    </div>
			  </div>
			</div>
        </div>
    </div>
</div>
<div class="mb-100">${pagebar}</div>


<!-- Rooms Area End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
