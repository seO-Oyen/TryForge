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
	background-color: #7FBFFF;
	border: 1px solid #7FBFFF;
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
								<input id="userName" value="${loginMem.member_name}" autocomplete="off" />
								
								<div style="color: #4CA5FF; margin-top: 20px; font-weight: bold;">아이디</div>
								<input id="userId" name="member_id" value="${loginMem.member_id}" autocomplete="off" />
								<input type="hidden" id="idchecked" value="true" disabled>
								
								<input type="button" disabled class="btn btn-primary btn-lg font-weight-medium auth-form-btn" id="idChkBtn" value="중복체크">
								
								<div style="color: #4CA5FF; margin-top: 20px; font-weight: bold;">이메일</div>
								<input id="userEmail" readonly value="${loginMem.member_email}" name="email" />
								<br>
								
								<button type="button"
									class="btn btn-md mr-3 btn-open btn-primary" id="changePwd" style="color: white; background-color: #7FBFFF; border: 1px solid #7FBFFF;"
									data-toggle="modal" data-target="#myModal" data-member-key="${loginMem.member_key}">저장
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