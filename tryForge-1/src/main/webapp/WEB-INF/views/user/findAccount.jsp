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
<script>
$(document).ready(function(){
	$("#findId").click(findId())
})

function findId() {
	
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
							<h3>아이디 찾기</h3>
							<div class="pt-3">
								<div class="form-group">
									<input type="text" class="form-control form-control-lg"
										id="memberId" name="member_email" placeholder="회원가입 하신 이메일"
										autocomplete="off">
								</div>
								<div class="mt-3">
									<input type="button" id="findId" class="btn btn-block btn-lg font-weight-medium auth-form-btn"
										style="background-color: #198CFF; color: white;" value="아이디 찾기" />
								</div>
							</div>
							<br>
							<h3>비밀번호 찾기</h3>
							<div class="pt-3">
								<div class="form-group">
									<input type="text" class="form-control form-control-lg"
										id="memberEmail" name="member_email" placeholder="회원가입 하신 이메일"
										autocomplete="off">
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-lg"
										id="memberId" name="member_id" placeholder="회원가입 아이디"
										autocomplete="off">
								</div>
								<div class="mt-3">
									<input type="button" class="btn btn-block btn-lg font-weight-medium auth-form-btn"
										style="background-color: #198CFF; color: white;" value="비밀번호 찾기" />
								</div>
							</div>
								<div class="text-center mt-2 font-weight-light">
									<a href="${path}/login" class="auth-link text-black">로그인화면으로</a>
								</div>
								<div class="text-center mt-4 font-weight-light">
									 <a href="register"
										style="color: #198CFF;">계정이 없으신가요?</a>
								</div>
							
						</div>
					</div>
				</div>
			</div>
			<!-- content-wrapper ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->
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
</body>

</html>