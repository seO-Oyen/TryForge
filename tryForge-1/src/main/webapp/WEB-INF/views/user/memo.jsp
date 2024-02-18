<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
.card-body > button {
	margin-top : 20px;
}

#profile{
	width: 150px;
	margin-bottom: 20px;
	border-radius: 70%;
}

#userName {
	border: 1px solid #7FBFFF;
	width: 500px;
	margin: 0 auto;
	padding: 10px;
	border-radius: 10px;
}
#userId {
	border: 1px solid #7FBFFF;
	width: 500px;
	margin: 0 auto;
	padding: 10px;
	border-radius: 10px;
}
#userEmail {
	border: 1px solid #7FBFFF;
	width: 500px;
	margin: 0 auto;
	padding: 10px;
	border-radius: 10px;
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

#pwdModal input {
	margin : 10px;
}
</style>
<script>
$(document).ready(function() {
	
})

</script>
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="row">
						<div class="col-md-6" style="flex: 0 0 100%; max-width: 100%;">
							<div class="card-body">
								<form class="forms-sample">
									<div class="form-group">
										<label for="comment" style="margin-top: 20px;">메모</label>

										<textarea type="text" class="form-control" id="comment"
											rows="5"></textarea>

										<div style="text-align: center;">
											<button id="requestBtn" type="button"
												class="btn btn-info btn-lg" style="margin-top: 20px;">
												메모 등록</button>
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
				<h5 class="mb-2 text-titlecase mb-4">메모 목록</h5>
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
											
										</tbody>
									</table>
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