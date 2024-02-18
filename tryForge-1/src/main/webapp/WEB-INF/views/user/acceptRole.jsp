<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_admain.jsp" flush="true" />
<style>
.modal{
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.modal .modal-dialog {
	max-width: 30%; /* 모달의 최대 너비를 80%로 설정 */
}

/* 입력 요소 여백 조절 */
.modal .form-group {
	margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
	margin-left: 3%;
	margin-right: 8%;
}

.modal .form-control {
	margin-right: 3%; /* 입력 요소 오른쪽 여백 조절 */
	margin-left: 3%; /* 입력 요소 왼쪽 여백 조절 */
}
</style>
<script>
	$(document).ready(function() {
		$("#regBtn").click(function() {
			cancelPost()
		})
	})
	
	function openModal(requestNum) {
		$("#myModal").modal('show');
		
		$.ajax({
				url : "${path}/requestRoleDetail",
				type : "GET",
				data : {
					requestNum : requestNum
				},
				dataType : "json",
				success : function(data) {
					var request = data.request
					$("[name=member_name]").text(data.memInfo.member_name)
					$("[name=comment]").text(request.request_comment)
					$("[name=admin_comment]").text(request.admin_comment)
					$("[name=time]").text(request.request_date)
				},
				error : function(err) {
					console.log(err)
				}
			})
	}
	
	function accept(requestNum) {
		$.ajax({
			url : "${path}/roleAccept",
			type : "POST",
			data : {
				requestNum : requestNum
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					Swal.fire({
						title : "수락 완료",
						icon : 'success',
					}).then(function() {
						window.location.reload();
					})
				} else {
					alert("수락 실패")
				}
			},
			error : function(err) {
				console.log(err)
			}
		})
	}
	
	function cancel(requestNum) {
		$("#cancelModal").modal('show');
		$("#requestNum").val(requestNum)
	}
	
	function cancelPost() {
		var requestNumVal = $("#requestNum").val()
		var commentVal = $("#adminComment").val()
		
		$.ajax({
			url : "${path}/roleCancel",
			type : "POST",
			data : {
				requestNum : requestNumVal,
				comment : commentVal
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					Swal.fire({
						title : "반려 완료",
						icon : 'success',
					}).then(function() {
						window.location.reload();
					})
				} else {
					alert("요청 실패")
				}
			},
			error : function(err) {
				console.log(err)
			}
		})
	}
	
</script>
<!-- main 대시보드 내용 -->
<!-- partial -->
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-xl-12 grid-margin stretch-card flex-column">
				<h5 class="mb-2 text-titlecase mb-4">요청 기록</h5>
				<div class="row">
					<div class="col-md-12 stretch-card">
						<div class="card">
							<div class="card-body d-flex flex-column justify-content-between"
								style="height: 500px;">
								<div class="table-responsive">
									<table class="table">
										<col width="10%">
										<col width="35%">
										<col width="20%">
										<col width="10%">
										<thead>
											<tr>
												<th>요청한 사람</th>
												<th>요청날짜</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="request" items="${requestList}" varStatus="status">
												<tr>
													<td>${requestMem[status.index].member_name}</td>
													<td>${request.request_date}</td>
													<c:choose>
														<c:when test="${request.request_state eq 'request'}">
															<td><label class="badge badge-warning">요청중</label></td>
														</c:when>
														<c:when test="${request.request_state eq 'cancel'}">
															<td><label class="badge badge-danger">반려</label></td>
														</c:when>
														<c:when test="${request.request_state eq 'approval'}">
															<td><label class="badge badge-success">승인</label></td>
														</c:when>
													</c:choose>
													<td>
														<c:if test="${request.request_state eq 'request'}">
															<button class="btn btn-success requestinfo" 
																onclick="accept(${request.request_key})">수락</button>
															<button class="btn btn-danger requestinfo" 
																onclick="cancel(${request.request_key})">반려</button>
														</c:if>
														<button class="btn btn-info requestinfo" 
															onclick="openModal(${request.request_key})">상세정보</button>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

							</div>
						</div>
					</div>
				</div>


			</div>
		</div>

	</div>
	
<!-- 모달 -->		
<div class="modal" id="myModal" style="margin-top: 150px;">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h5 class="modal-title">상세 정보</h5>
				<button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
			</div>
			
			
			<!-- Modal body -->
			<input type="hidden" name="btnType"/>
			<div class="form-group">
				<label for="exampleInputUsername1">요청하신 분</label> 
				<div name="member_name" class="form-control" id="name"
					value=""></div>
				<label for="exampleInputUsername1">요청 코멘트</label> 
				<div name="comment" class="form-control" id="comment" style="height: 100px; overflow: auto;"
					value=""></div>
				<label for="exampleInputUsername1">처리 코멘트</label> 
				<div name="admin_comment" class="form-control" id="adComment" style="height: 100px; overflow: auto;"
					value=""></div>
				<label for="exampleInputUsername1">요청 시간</label> 
				<div name="time" class="form-control" id="time"
					value=""></div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="mx-auto">
					
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						id="clsBtn">닫기</button>
				</div>
			</div>

		</div>
	</div>
</div>

<!-- 반려 모달 -->
<div class="modal" id="cancelModal" style="margin-top: 150px;">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h5 class="modal-title">요청 반려</h5>
				<button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
			</div>
			
			<!-- Modal body -->
			<form class="form-group">
				<input type="hidden" id="requestNum" value="" />
				<label for="exampleInputUsername1">처리 코멘트</label> 
				<textarea class="form-control" id="adminComment"
					rows="5"></textarea>
			</form>

			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="mx-auto">
					<button type="button" class="btn btn-success" data-dismiss="modal"
						id="regBtn">전송</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						id="clsBtn">닫기</button>
				</div>
			</div>

		</div>
	</div>
</div>


	<!-- 이 밑은 복붙할때 알아서 붙이쇼 -->
</div>
<!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->


</body>

</html>