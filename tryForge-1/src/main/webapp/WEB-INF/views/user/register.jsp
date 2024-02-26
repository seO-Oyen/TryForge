<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="shortcut icon" type="image/x-icon"
	href="${path}/template/images/logo_backDelete.png">
<link rel="stylesheet" href="${path}/template/alert/sweetalert2.min.css">
<title>TryForge</title>
<!-- base:css -->
<link rel="stylesheet"
	href="${path}/template/vendors/typicons/typicons.css">
<link rel="stylesheet"
	href="${path}/template/vendors/css/vendor.bundle.base.css">
<!-- endinject -->
<!-- plugin css for this page -->
<!-- End plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet"
	href="${path}/template/css/vertical-layout-light/style.css">
<!-- endinject -->
<!-- base:js -->
<script src="${path}/template/vendors/js/vendor.bundle.base.js"></script>
<script src="${path}/template/alert/sweetalert2.min.js"></script>
<!-- endinject -->
<!-- inject:js -->
<script src="${path}/template/js/off-canvas.js"></script>
<script src="${path}/template/js/hoverable-collapse.js"></script>
<script src="${path}/template/js/template.js"></script>
<script src="${path}/template/js/settings.js"></script>
<script src="${path}/template/js/todolist.js"></script>
<!-- endinject -->
<script type="text/javascript">
$(document).ready(function(){
	// 회원가입 성공 여부
	var result = "${insertResult}"
	if(result != "" && result == "true") {
		alert("가입완료\n로그인창으로 이동합니다.")
		location.href = "${path}/login"
	} else if (result != "" && result == "false") {
		alert("가입 실패")
	}
	
	// 엔터키 막기
	document.addEventListener('keydown', function(event) {
		if(event.keyCode === 13) {
			event.preventDefault()
		}
	}, true)
		
	$("#regBtn").click(register)
	
	// 아이디 수정하면 문구 사라지게
	$("[name=member_id]").keyup(function() {
		$("#coment").html('')
		$("#idchecked").val("false")
	})
	$("[name=member_email]").keyup(function() {
		$("#emailchecked").val("false")
	})
	
	// 아이디 중복 체크
	$("#idChkBtn").click(function() {
		var userIdVal = $("[name=member_id]").val()
		if (userIdVal == "") {
			$("#coment").html("아이디를 입력해주세요")
			$("#coment").css("color", "red")
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
					$("#coment").html("사용 가능한 아이디입니다.")
					$("#coment").css("color", "green")
					$("#idchecked").val("true")
				} else {
					$("#coment").html("이미 존재하는 아이디입니다.")
					$("#idchecked").val("false")
					$("#coment").css("color", "red")
				}
			},
			error : function(err) {
				console.log(err)
			}
		})
	})
	
	// 이메일 중복 체크
	$("#emailChkBtn").click(function() {
		var emailVal = $("[name=member_email]").val()
		if (emailVal == "") {
			const Toast = Swal.mixin({
			    toast: true,
			    position: 'top-end',
			    showConfirmButton: false,
			    timer: 1500,
			    timerProgressBar: false
			})
			
			Toast.fire({
			    icon: 'error',
			    title: '입력창이 비어있습니다.'
			})
			return false;
		}
		$.ajax({
			url : "${path}/emailCheck",
			type : "GET",
			data : {
				email: emailVal
			},
			dataType : "json",
			success : function(data) {
				if(data.emailChk) {
					const Toast = Swal.mixin({
					    toast: true,
					    position: 'top-end',
					    showConfirmButton: false,
					    timer: 1500,
					    timerProgressBar: false
					})
					
					Toast.fire({
					    icon: 'success',
					    title: '초대받은 이메일입니다.'
					})
					$("#emailchecked").val("true")
				} else {
					const Toast = Swal.mixin({
					    toast: true,
					    position: 'top-end',
					    showConfirmButton: false,
					    timer: 2000,
					    timerProgressBar: false
					})
					
					Toast.fire({
					    icon: 'error',
					    title: '초대받지 않은 메일이거나\n이미 가입한 이메일입니다.',
					    text: '관리자에게 문의해주세요.'
					})
				}
			},
			error : function(err) {
				console.log(err)
			}
		})
	})
	
	// 비밀번호 일치 확인 (체크가 변하지 않고 비밀번호가 바뀌었을때)
	$("[name=member_pwd]").keyup(function() {
		if ($("[name=member_pwd]").val() == '') {
			$("#pwdComent").html('')
			$("#pwdchecked").val("false")
			return false
		}
		
		if ($("[name=passwordChk]").val() == $("[name=member_pwd]").val()) {
			$("#pwdComent").html("비밀번호가 일치합니다.")
			$("#pwdComent").css("color", "green")
			$("#pwdchecked").val("true")
		} else {
			if ($("[name=passwordChk]").val() != '') {
				$("#pwdComent").html("비밀번호가 일치하지 않습니다.")
				$("#pwdchecked").val("false")
				$("#pwdComent").css("color", "red")
			}
		}
	})
	
	// 비밀번호 일치 확인
	$("[name=passwordChk]").keyup(function() {
		if ($("[name=passwordChk]").val() == '') {
			$("#pwdComent").html('')
			$("#pwdchecked").val("false")
			return false
		}
		if ($("[name=passwordChk]").val() == $("[name=member_pwd]").val()) {
			$("#pwdComent").html("비밀번호가 일치합니다.")
			$("#pwdComent").css("color", "green")
			$("#pwdchecked").val("true")
		} else {
			$("#pwdComent").html("비밀번호가 일치하지 않습니다.")
			$("#pwdchecked").val("false")
			$("#pwdComent").css("color", "red")
		}
	})
	
	
});

// 회원가입 => 안적힌 것 있음 체크해서 폼 보내지 못하게
function register() {
	if($("#idchecked").val() == 'false') {
		const Toast = Swal.mixin({
		    toast: true,
		    position: 'top-end',
		    showConfirmButton: false,
		    timer: 1500,
		    timerProgressBar: false
		})
		
		Toast.fire({
		    icon: 'error',
		    title: '아이디 체크를 해주세요.'
		})
		return false
	}
	if($("#pwdchecked").val() == 'false') {
		const Toast = Swal.mixin({
		    toast: true,
		    position: 'top-end',
		    showConfirmButton: false,
		    timer: 1500,
		    timerProgressBar: false
		})
		
		Toast.fire({
		    icon: 'error',
		    title: '비밀번호가 일치하지 않습니다.'
		})
		
		return false
	}
	if($("#name").val() == '') {
		const Toast = Swal.mixin({
		    toast: true,
		    position: 'top-end',
		    showConfirmButton: false,
		    timer: 1500,
		    timerProgressBar: false
		})
		
		Toast.fire({
		    icon: 'error',
		    title: '이름을 입력해주세요.'
		})
		return false
	}
	if($("#emailchecked").val() == 'false') {
		const Toast = Swal.mixin({
		    toast: true,
		    position: 'top-end',
		    showConfirmButton: false,
		    timer: 1500,
		    timerProgressBar: false
		})
		
		Toast.fire({
		    icon: 'error',
		    title: '이메일 체크를 해주세요.'
		})
		
		return false
	}
	
	$("#registerFrm").attr("method", "post")
}

</script>

<style>
.btn {
	background-color: #198CFF;
	color: white;
}

</style>
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo">
                <img src="${path}/template/images/try_forge01.jpg" alt="logo">
              </div>
              <h4>회원가입</h4>
              <form class="pt-3" id="registerFrm">
              	<div id="coment" style="color: red;"></div>
                <div class="form-group" style="display: flex;">
                	<input type="hidden" id="idchecked" value="false" disabled>
                  <input type="text" class="form-control form-control-lg" id="id" name="member_id" placeholder="ID" autocomplete="off">
                  <input type="button" class="btn btn-block btn-lg font-weight-medium auth-form-btn" id="idChkBtn" value="중복체크" 
                  	style="padding-left: 10px; padding-right: 10px;
							width: 122px; margin-left: 10px; margin-top: 3px;">
                </div>
                <input type="hidden" id="pwdchecked" value="false" disabled>
                <div id="pwdComent"></div>
                <div class="form-group">
                  <input type="password" class="form-control form-control-lg" id="password" name="member_pwd" placeholder="PassWord">
                </div>
                <div class="form-group">
                  <input type="password" class="form-control form-control-lg" id="passwordChk" name="passwordChk" placeholder="PasswordCheck">
                </div>
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="name" name="member_name" placeholder="Name" autocomplete="off">
                </div>
                <div class="form-group">
                  <input type="hidden" id="emailchecked" value="false" disabled>
                  <input type="email" class="form-control form-control-lg" id="email" name="member_email" placeholder="Email" autocomplete="off">
                </div>
                <div class="form-group">
                  <input type="button" class="btn btn-block btn-lg font-weight-medium auth-form-btn"
                  	style="color: #198CFF; border: 1px solid #198CFF; background-color: white;" 
                  	id="emailChkBtn" value="이메일 체크">
                </div>
                <div class="mt-3">
					<input type="submit" class="btn btn-block btn-lg font-weight-medium auth-form-btn"
						id="regBtn" value="회원가입" />
				</div>
                <div class="text-center mt-4 font-weight-light">
                  이미 계정이 있으신가요? <a href="login" style="color: #198CFF;">로그인</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
</body>

</html>
