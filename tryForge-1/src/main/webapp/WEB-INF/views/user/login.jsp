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
	var id = "${member.member_id}"
	var sessId = "${loginMem.member_id}"
	var role = "${loginMem.member_role}"
	if(id != "") {
		if(sessId != ""  && role == ""){
			alert("로그인 성공\n메인페이지로 이동")
			location.href="${path}/userIndex.do"
		} else if(sessId != "" && role != "") {
			alert("로그인 성공\n관리자페이지로 이동")
			location.href = "${path}/adMain.do"
		} else{
			alert("로그인 실패\n다시 로그인하세요")
		}
		
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
							<h3>로그인</h3>
							<!-- <h6 class="font-weight-light">Sign in to continue.</h6> -->
							<form class="pt-3" method="post">
								<div class="form-group">
									<input type="text" class="form-control form-control-lg"
										id="memberId" name="member_id" placeholder="ID" autocomplete="off">
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-lg"
										id="memberPwd" name="member_pwd" placeholder="Password">
								</div>
								<div class="mt-3">
									<input type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
										value="로그인" />
								</div>
								<div class="text-center mt-2 font-weight-light">
								<!-- 나중에 로그인 기억 같은거 하면 쓸 코드 -->
									<!-- <div class="form-check">
										<label class="form-check-label text-muted"> 
										<input type="checkbox" class="form-check-input"> Keep me signed in
										</label>
									</div> -->
									<a href="#" class="auth-link text-black">비밀번호 찾기</a>
								</div>
								<div class="text-center mt-4 font-weight-light">
									 <a href="register.do"
										class="text-primary">계정이 없으신가요?</a>
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