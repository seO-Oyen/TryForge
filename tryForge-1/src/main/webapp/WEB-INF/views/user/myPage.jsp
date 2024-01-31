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
		var btnType = $(this).attr("id")
		
		$("#pwdChkFrm [name=btnType]").val(btnType)
		
		// 모달 열기
		$("#myModal").modal('show');
	})
})

// 비밀번호 확인
function chkPwd() {
	var pwdVal = $("#pwdChkFrm [name=member_pwd]").val()
	var btnType = $("#pwdChkFrm [name=btnType]").val()
	var memKeyVal = "${loginMem.member_key}"
	if (pwdVal == "") {
		Swal.fire({
			title : "값이 없습니다",
			text : '값을 입력해주세요',
			icon : 'error',
		})
		return false;
	}
	$.ajax({
		url : "${path}/chkPwd",
		type : "GET",
		data : {
			memKey : memKeyVal,
			pwd : pwdVal
		},
		dataType : "json",
		success : function(data) {
			if (data) {
				Swal.fire({
					title : "비밀번호 일치",
					text : '화면 이동합니다.',
					icon : 'success',
				}).then(function() {
					$("#pwdChkFrm [name=member_pwd]").val("")
					$("#clsBtn").click();
					if (btnType == 'changeInfo') {
						location.href="${path}/userInfo"
					} else if (btnType == 'changePwd') {
						console.log("비번 수정")
					}
				})
			} else {
				Swal.fire({
					title : "비밀번호가 일치하지 않습니다",
					text : '다시한번 확인해주세요',
					icon : 'error',
				})
			}
		},
		error : function(err) {
			console.log(err)
		}
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
								<div style="color: #4CA5FF; margin-top: 10px; font-weight: bold;">이름</div>
								<div id="userName">${loginMem.member_name}</div>
								<div style="color: #4CA5FF; margin-top: 20px; font-weight: bold;">아이디</div>
								<div id="userId">${loginMem.member_id}</div>
								<div style="color: #4CA5FF; margin-top: 20px; font-weight: bold;">이메일</div>
								<div id="userEmail">${loginMem.member_email}</div>
								
								<button type="button"
									class="btn btn-md mr-3 btn-open" id="changePwd" style="color: white; background-color: #198CFF;"
									data-toggle="modal" data-target="#myModal" data-member-key="${loginMem.member_key}">비밀번호 수정
								</button>
								<button type="button"
									class="btn btn-md btn-open" id="changeInfo" style="color: #198CFF; border: 1px solid #198CFF;"
									data-toggle="modal" data-target="#myModal" data-member-key="${loginMem.member_key}">개인정보 수정
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
				<input type="hidden" name="btnType"/>
				<div class="form-group">
					<label for="exampleInputUsername1">현재 비밀번호를 입력해주세요</label> 
					<input name="member_pwd" type="password" class="form-control" id="pwd"
						placeholder="password">
				</div>

			</form>


			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="mx-auto">
					<button type="button" class="btn btn-" id="regBtn" onclick="chkPwd()"
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