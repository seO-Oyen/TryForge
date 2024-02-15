<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_user.jsp" flush="true" />
<script>
	$(document).ready(function() {
		document.addEventListener('keydown', function(event) {
			if (event.keyCode === 13) {
				event.preventDefault()
			}
		}, true)

		$("#requestBtn").click(function() {
			console.log("클릭")
			var memberIdVal = $("#member_id").val()
			var commentVal = $("#comment").val()
			$.ajax({
				url : "${path}/requestRole",
				type : "POST",
				data : {
					member_id : memberIdVal,
					comment : commentVal
				},
				dataType : "json",
				success : function(data) {
					if (data.result) {
						Swal.fire({
							title : "요청완료",
							icon : 'success',
						}).then(function() {
							$("#comment").val("")
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
		})

	})
</script>
<!-- main 대시보드 내용 -->
<!-- partial -->
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-xl-12 grid-margin stretch-card flex-column">
				<h5 class="mb-2 text-titlecase mb-4">권한요청</h5>
				<div class="row">
					<div class="col-md-12 stretch-card">
						<div class="card">
							<div class="card-body d-flex flex-column justify-content-between"
								style="height: 350px;">

								<form class="forms-sample">
									<div class="form-group">
										<label for="member_id">아이디</label> <input type="text"
											class="form-control" id="member_id" readonly
											value="${loginMem.member_id}" /> <label for="comment"
											style="margin-top: 20px;">요청 사유</label>

										<textarea type="text" class="form-control" id="comment"
											rows="5"></textarea>

										<div style="text-align: center;">
											<button id="requestBtn" type="button"
												class="btn btn-info btn-lg" style="margin-top: 20px;">
												요청하기</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>


		<div class="row">
			<div class="col-xl-12 grid-margin stretch-card flex-column">
				<h5 class="mb-2 text-titlecase mb-4">요청 기록</h5>
				<div class="row">
					<div class="col-md-12 stretch-card">
						<div class="card">
							<div class="card-body d-flex flex-column justify-content-between"
								style="height: 350px;">
								<div class="table-responsive">
									<table class="table">
										<col width="40%">
										<col width="40%">
										<col width="10%">
										<thead>
											<tr>
												<th>요청날짜</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>12 May 2017</td>
												<td><label class="badge badge-danger">Pending</label></td>
												<td><button class="btn btn-info">상세정보</button>
											</tr>
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


	<!-- 이 밑은 복붙할때 알아서 붙이쇼 -->
</div>
<!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->


</body>

</html>