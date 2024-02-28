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
<link rel="stylesheet" href="${path}/template/vendors/mdi/css/materialdesignicons.min.css"/>
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
<script>
	var id = "${member.member_id}"
	var sessId = "${loginMem.member_id}"
	var role = "${loginMem.member_role}"
	if(id != "") {
		if(sessId != ""  && role == "EMP"){
			alert("로그인 성공\n메인페이지로 이동")
			location.href="${path}/userIndex"
		} else if(sessId != "" && role != "EMP") {
			alert("로그인 성공\n관리자페이지로 이동")
			location.href = "${path}/adMain"
		} else{
			alert("로그인 실패\n다시 로그인하세요")
		}
		
	}
	$(document).ready(function() {
		// 이전화면에서 요청된 내용을 선택하게 하게, 선택할 때, 서버에 언어 선택 내용 전달.
		$("#dropdownMenuIconButton1").val("${param.lang}").change(function() {
			var chVal = $(this).val()
			if (chVal != '') {
				location.href = "${path}/multiLang?lang=" + chVal
			}
		})
	});
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
							<div style="display: flex;">
								<h3 style="width:100px; line-height:normal;">로그인</h3>
								<button class="btn btn-outline-info dropdown-toggle" type="button" 
									id="dropdownMenuIconButton1" data-toggle="dropdown" 
									aria-haspopup="true" aria-expanded="false"
									>
	                            	<i class="typcn mdi mdi-translate"></i>
	                          	</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuIconButton1">
		                            <h6 class="dropdown-header">언어선택</h6>
		                            <a class="dropdown-item" href="#">한국어</a>
		                            <!-- <a class="dropdown-item" href="#">日本語</a> -->
		                            <a class="dropdown-item" href="#">English</a>
	                          	</div>
                          	</div>
							<!-- <h6 class="font-weight-light">Sign in to continue.</h6> -->
							<form class="pt-3" method="post">
								<div class="form-group">
									<input type="text" class="form-control form-control-lg"
										id="memberId" name="member_id" placeholder='<spring:message code="id"/>' autocomplete="off">
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-lg"
										id="memberPwd" name="member_pwd" placeholder="Password">
								</div>
								<div class="mt-3">
									<input type="submit" class="btn btn-block btn-lg font-weight-medium auth-form-btn"
										style="background-color: #198CFF; color: white;" value="로그인" />
								</div>
								<div class="text-center mt-2 font-weight-light">
									<a href="${path}/findAccount" class="auth-link text-black">계정 찾기</a>
								</div>
								<div class="text-center mt-4 font-weight-light">
									 <a href="register"
										style="color: #198CFF;">계정이 없으신가요?</a>
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
	
	<!-- endinject -->
</body>

</html>