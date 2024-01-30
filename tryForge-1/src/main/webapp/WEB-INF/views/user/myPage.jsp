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
	border: 1px solid #aab2bd;
	/* display:inline-block; */
	width: 500px;
	margin: 0 auto;
	padding: 10px;
}
#userId {
	border: 1px solid #aab2bd;
	/* display:inline-block; */
	width: 500px;
	margin: 0 auto;
	padding: 10px;
}
#userEmail {
	border: 1px solid #aab2bd;
	/* display:inline-block; */
	width: 500px;
	margin: 0 auto;
	padding: 10px;
}

#myModal .modal-dialog {
	max-width: 30%; /* 모달의 최대 너비를 80%로 설정 */
}

/* 입력 요소 여백 조절 */
#myModal .form-group {
	margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
	margin-left: 3%;
	margin-right: 8%;
}

#myModal .form-control {
	margin-right: 3%; /* 입력 요소 오른쪽 여백 조절 */
	margin-left: 3%; /* 입력 요소 왼쪽 여백 조절 */
}

</style>
<script>
$(document).ready(function() {
	$(document).on('click', '.btn-open', function() {
		var memberKey = $(this).data("member-key")
		$("#modalFrm [name=member_key]").val(memberKey)
		
		// 모달 열기
		$("#myModal").modal('show');
	})
})

function chkPwd() {
	$.ajax({
		
	})
}

</script>
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="row">
						<div class="col-md-6" style="flex: 0 0 100%; text-align: center; max-width: 100%;">
							<div class="card-body">
								<img src="${path}/template/images/faces/face5.jpg" alt="profile" id ="profile"/>
								<div style="color: gray; margin-top: 10px;">이름</div>
								<div id="userName">${loginMem.member_name}</div>
								<div style="color: gray; margin-top: 10px;">아이디</div>
								<div id="userId">${loginMem.member_id}</div>
								<div style="color: gray; margin-top: 10px;">이메일</div>
								<div id="userEmail">${loginMem.member_email}</div>
								
								<button type="button"
									class="btn btn-info btn-md mr-3 btn-open" id="changePwd"
									data-toggle="modal" data-target="#myModal" data-member-key="${loginMem.member_key}">비밀번호 수정
								</button>
								<button type="button"
									class="btn btn-secondary btn-md btn-icon-text">개인정보 수정
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
<!-- 모달 -->		
<div class="modal" id="myModal" style="margin-top: 200px; margin-left: 125px;">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h5 class="modal-title">비밀번호 확인</h5>

				<button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
			</div>
			
			
			<!-- Modal body -->
			<form class="forms-sample" id="pwdChkFrm">
				<input type="hidden" name="member_key"/>
				<div class="form-group">
					<label for="exampleInputUsername1">현재 비밀번호를 입력해주세요</label> 
					<input name="member_pwd" type="password" class="form-control" id="pwd"
						placeholder="password">
				</div>

			</form>


			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="mx-auto">
					<button type="button" class="btn btn-" id="regBtn" 
						style="background-color: #007FFF; color: white;">확인</button>
					
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