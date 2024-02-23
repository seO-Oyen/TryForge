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
	$(document).on('click', '.btn-open', function() {
		var btnType = $(this).attr("id")
		
		$("#pwdChkFrm [name=btnType]").val(btnType)
		
		// 모달 열기
		$("#myModal").modal('show');
	})
	$("#profile").on('click', function(){
		$('#fileInput').click();
	})
	$("#fileInput").change(function() {
		fileUpload();
		var fileList = this.files;
		var fileListDisplay = $('#fileText');
		fileListDisplay.empty();

	});

	$("#pwdChangeFrm [name=memberPwd]").keyup(function() {
		if ($("#pwdChangeFrm [name=memberPwd]").val() == '') {
			$("#pwdComent").html('')
			$("#pwdchecked").val("false")
			return false
		}
		
		if ($("[name=passwordChk]").val() == $("[name=memberPwd]").val()) {
			$("#pwdComent").html("비밀번호가 일치합니다.")
			$("#pwdComent").css("color", "green")
			$("#changeBtn").attr("disabled", false)
		} else {
			if ($("[name=passwordChk]").val() != '') {
				$("#pwdComent").html("비밀번호가 일치하지 않습니다.")
				$("#changeBtn").attr("disabled", true)
				$("#pwdComent").css("color", "red")
			}
		}
	})
	
	$("#pwdChangeFrm [name=passwordChk]").keyup(function() {
		if ($("#pwdChangeFrm [name=passwordChk]").val() == '') {
			$("#pwdComent").html('')
			$("#changeBtn").attr("disabled", true)
			return false
		}
		if ($("[name=passwordChk]").val() == $("[name=memberPwd]").val()) {
			$("#pwdComent").html("비밀번호가 일치합니다.")
			$("#pwdComent").css("color", "green")
			$("#changeBtn").attr("disabled", false)
		} else {
			$("#pwdComent").html("비밀번호가 일치하지 않습니다.")
			$("#changeBtn").attr("disabled", true)
			$("#pwdComent").css("color", "red")
		}
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
						$("#pwdModal").modal('show');
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

// 비밀번호 수정
function changePwd() {
	var memKeyVal = "${loginMem.member_key}"
	var pwdVal = $("[name=memberPwd]").val()
	
	// 기존 비밀번호와 일치시
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
					title : "기존 비밀번호와 일치합니다.",
					text : '기존 비밀번호와 다르게 설정해주세요.',
					icon : 'warning'
				}).then(function() {
					$("#pwdComent").html("기존 비밀번호와 다르게 설정해주세요.")
					$("#changeBtn").attr("disabled", true)
					$("#pwdComent").css("color", "red")
				})
			} else {
				updatePwd()
			}
		},
		error : function(err) {
			console.log(err)
		}
	})

}

function updatePwd() {
	var memKeyVal = "${loginMem.member_key}"
	var pwdVal = $("[name=memberPwd]").val()
	
	$.ajax({
		url : "${path}/changePwd",
		type : "POST",
		data : {
			memKey : memKeyVal,
			pwd : pwdVal
		},
		dataType : "json",
		success : function(data) {
			if (data) {
				Swal.fire({
					position: "center-center",
					title : "수정 성공",
					text : '',
					showConfirmButton: false,
					icon: "success",
					timer: 1500
				}).then((result) => {
					location.href = "${path}/myPage"
				})
			}
		},
		error : function(err) {
			console.log(err)
		}
	})
}

function fileUpload(){
	var formData = new FormData();
	var files = $("#fileInput")[0].files;
	$.each(files, function(index, file) {
		formData.append('files[]', file);

	})
	formData.append('description', $("input[name='description']").val());
	formData.append('member_key', "${loginMem.member_key}");
	console.log(formData)
	//formData.append('project_key', $("input[name='project_key']").val());
	console.log($("[name=description]").val())
	//console.log(formData.get('description'));

	$.ajax({
		url: "${path}/upload",
		type: "POST",
		data: formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function(response) {
			msg("success", "파일 업로드 성공!", response.msg)

		},
		error: function(error) {
			msg("error", "업로드에러", error)
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
								<form method="post" enctype="multipart/form-data" action="upload">
									<img src="${path}/template/images/faces/face5.jpg" alt="profile" id ="profile"/>
									<input type="file" id="fileInput" name="files" multiple="multiple" style="display: none;" accept="image/*" />
									<input type="hidden" name="description" value="프로필 사진"/>
								</form>
								
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

<!-- 비밀번호 수정 모달 -->		
<div class="modal" id="pwdModal" style="margin-top: 200px; margin-left: 125px;">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h5 class="modal-title">비밀번호 수정</h5>

				<button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
			</div>
			
			<!-- Modal body -->
			<form class="forms-sample" id="pwdChangeFrm">
				<div class="form-group">
					<label for="exampleInputUsername1">수정할 비밀번호를 입력해주세요</label> 
					<div id="pwdComent"></div>
					<input type="password" class="form-control form-control-lg" id="password" name="memberPwd" placeholder="수정할 비밀번호">
					<input type="password" class="form-control form-control-lg" id="passwordChk" name="passwordChk" placeholder="비밀번호 확인">
				</div>
			</form>


			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="mx-auto">
					<button type="button" disabled class="btn btn-" id="changeBtn" onclick="changePwd()"
						style="background-color: #007FFF; color: white;">변경</button>
					
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