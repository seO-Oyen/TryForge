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
		location.href = "${path}/login.do"
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
	
	// 아이디 중복 체크
	$("#idChkBtn").click(function() {
		var userIdVal = $("[name=member_id]").val()
		if (userIdVal == "") {
			$("#coment").html("아이디를 입력해주세요")
			$("#coment").css("color", "red")
			return false;
		}
		$.ajax({
			url : "${path}/idCheck.do",
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
		alert("아이디 중복체크를 해주세요.")
		return false
	}
	if($("#pwdchecked").val() == 'false') {
		alert("비밀번호가 일치하지 않습니다.")
		return false
	}
	if($("#name").val() == '') {
		alert("이름을 입력해주세요")
		return false
	}
	if($("#email").val() == '') {
		alert("이메일을 입력해주세요")
		return false
	}
	
	$("#registerFrm").attr("method", "post")
}

</script>
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
                  <input type="button" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" id="idChkBtn" value="중복체크" 
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
                  <input type="email" class="form-control form-control-lg" id="email" name="member_email" placeholder="Email" autocomplete="off">
                </div>
                <div class="mt-3">
					<input type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
						id="regBtn" value="회원가입" />
				</div>
                <div class="text-center mt-4 font-weight-light">
                  이미 계정이 있으신가요? <a href="login.do" class="text-primary">로그인</a>
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
