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
	width: 364px;
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
	background-color: #D9ECFF;
	cursor: default;
}

#idChkBtn {
	padding-left: 10px;
	padding-right: 10px;
	width: 122px; 
	margin-left: 10px;
	background-color: #198CFF;
	border: 1px solid #198CFF;
}
</style>
<script>
$(document).ready(function() {
	// 이메일 클릭시 => 이메일 수정 안됨
	$("[name=email]").click(function() {
		const Toast = Swal.mixin({
		    toast: true,
		    position: 'top-end',
		    showConfirmButton: false,
		    timer: 3000,
		    timerProgressBar: true,
		    didOpen: (toast) => {
		        toast.addEventListener('mouseenter', Swal.stopTimer)
		        toast.addEventListener('mouseleave', Swal.resumeTimer)
		    }
		})
		
		Toast.fire({
		    icon: 'error',
		    title: '이메일은 수정이 불가능합니다.'
		})
	})
	
	// 안에 내용이 변경되면 버튼 활성화 + 무조건 체크해야되게
	$("[name=member_id]").keyup(function() {
		if ($("[name=member_id]").val() == "${loginMem.member_id}") {
			$("#idchecked").val("true")
			$("#idChkBtn").attr("disabled", true)
		} else{
			$("#idchecked").val("false")
			$("#idChkBtn").attr("disabled", false)
		}
	})
	
	// 아이디 체크
	$("#idChkBtn").click(function() {
		var userIdVal = $("[name=member_id]").val()
		if (userIdVal == "") {
			const Toast = Swal.mixin({
			    toast: true,
			    position: 'top-end',
			    showConfirmButton: false,
			    timer: 2000,
			    timerProgressBar: true,
			    didOpen: (toast) => {
			        toast.addEventListener('mouseenter', Swal.stopTimer)
			        toast.addEventListener('mouseleave', Swal.resumeTimer)
			    }
			})
			
			Toast.fire({
			    icon: 'error',
			    title: '아이디를 입력해주세요'
			})
			return false;
		}
		$.ajax({
			url : "${path}/idCheck",
			type : "GET",
			data : {
				userId: userIdVal
			},
			dataType : "json",
			success : function(data) {
				if(data.userIdChk) {
					const Toast = Swal.mixin({
					    toast: true,
					    position: 'top-end',
					    showConfirmButton: false,
					    timer: 2000,
					    timerProgressBar: true,
					    didOpen: (toast) => {
					        toast.addEventListener('mouseenter', Swal.stopTimer)
					        toast.addEventListener('mouseleave', Swal.resumeTimer)
					    }
					})
					
					Toast.fire({
					    icon: 'success',
					    title: '사용가능한 아이디입니다.'
					})
					$("#idchecked").val("true")
					$("#idChkBtn").attr("disabled", true)
				} else {
					const Toast = Swal.mixin({
					    toast: true,
					    position: 'top-end',
					    showConfirmButton: false,
					    timer: 2000,
					    timerProgressBar: true,
					    didOpen: (toast) => {
					        toast.addEventListener('mouseenter', Swal.stopTimer)
					        toast.addEventListener('mouseleave', Swal.resumeTimer)
					    }
					})
					
					Toast.fire({
					    icon: 'error',
					    title: '사용 불가능한 아이디입니다.'
					})
					$("#idchecked").val("false")
				}
			},
			error : function(err) {
				console.log(err)
			}
		})
	})
	
})

// 수정 저장
function saveInfo() {
	var userNameVal = $("[name=userName]").val()
	var userIdVal = $("[name=member_id]").val()
	
	// 수정 사항이 없다면 한번 확인
	if (userIdVal == "${loginMem.member_id}" && userNameVal == "${loginMem.member_name}") {
		Swal.fire({
			title: "변경사항이 없습니다",
			text: "변경된 내용이 없습니다.\n마이페이지로 돌아가겠습니까?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: "#3085d6",
			cancelButtonColor: "#d33",
			confirmButtonText: "마이페이지",
			cancelButtonText : "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				location.href = "${path}/myPage"
			}
		});
	} else {
		if (userNameVal == "") {
			const Toast = Swal.mixin({
			    toast: true,
			    position: 'top-end',
			    showConfirmButton: false,
			    timer: 2000,
			    timerProgressBar: true,
			    didOpen: (toast) => {
			        toast.addEventListener('mouseenter', Swal.stopTimer)
			        toast.addEventListener('mouseleave', Swal.resumeTimer)
			    }
			})
			
			Toast.fire({
			    icon: 'error',
			    title: '이름을 입력해주세요.'
			})
			return false;
		}
		if ($("#idchecked").val() == 'false') {
			const Toast = Swal.mixin({
			    toast: true,
			    position: 'top-end',
			    showConfirmButton: false,
			    timer: 2000,
			    timerProgressBar: true,
			    didOpen: (toast) => {
			        toast.addEventListener('mouseenter', Swal.stopTimer)
			        toast.addEventListener('mouseleave', Swal.resumeTimer)
			    }
			})
			
			Toast.fire({
			    icon: 'error',
			    title: '아이디 중복체크를 해주세요.'
			})
			return false;
		}
		
		$.ajax({
			url: "${path}/userInfo",
			type : "POST",
			data : {
				name : userNameVal,
				memberId : userIdVal,
				memKey : "${loginMem.member_key}"
			},
			dataType : "json",
			success : function(data) {
				if (data) {
					console.log("수정성공")
				} else {
					console.log("수정 실패")
				}
			}
		})
		
	}
	
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
								<input id="userName" value="${loginMem.member_name}" autocomplete="off" name="userName" />
								
								<div style="color: #4CA5FF; margin-top: 20px; font-weight: bold;">아이디</div>
								<input id="userId" name="member_id" value="${loginMem.member_id}" autocomplete="off" />
								<input type="hidden" id="idchecked" value="true" disabled>
								
								<input type="button" disabled class="btn btn-primary btn-lg font-weight-medium auth-form-btn" id="idChkBtn" value="중복체크">
								
								<div style="color: #4CA5FF; margin-top: 20px; font-weight: bold;">이메일</div>
								<input id="userEmail" readonly value="${loginMem.member_email}" name="email" />
								<br>
								
								<button type="button"
									class="btn btn-md mr-3 btn-open btn-primary" id="changePwd" onclick="saveInfo()"
									style="color: white; background-color: #198CFF; border: 1px solid #198CFF;">저장
								</button>
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