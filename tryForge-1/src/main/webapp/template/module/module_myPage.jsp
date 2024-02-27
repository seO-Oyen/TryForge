<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html>

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="shortcut icon" type="image/x-icon" href="${path}/template/images/logo_backDelete.png">
<title>TryForge</title>
<!-- base:css -->
<link rel="stylesheet" href="${path}/template/vendors/typicons/typicons.css">
<link rel="stylesheet" href="${path}/template/vendors/css/vendor.bundle.base.css">
<!-- endinject -->
<!-- plugin css for this page -->
<!-- End plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet" href="${path}/template/css/vertical-layout-light/style.css">
<link rel="stylesheet" href="${path}/template/vendors/mdi/css/materialdesignicons.min.css"/>
<link rel="stylesheet" href="${path}/template/gantt/codebase/skins/dhtmlxgantt_material.css"/>
<link rel="stylesheet" href="${path}/template/alert/sweetalert2.min.css">

<!-- base:js -->
<script src="${path}/template/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page-->
<script src="${path}/template/vendors/chart.js/Chart.min.js"></script>
<!-- End plugin js for this page-->
<!-- inject:js -->
<script src="${path}/template/js/off-canvas.js"></script>
<script src="${path}/template/js/hoverable-collapse.js"></script>
<script src="${path}/template/js/template.js"></script>
<script src="${path}/template/js/settings.js"></script>
<script src="${path}/template/js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="${path}/template/js/dashboard.js"></script>
<script src="${path}/template/calendar/index.global.js"></script>
<script src="${path}/template/gantt/codebase/dhtmlxgantt.js"></script>
<script src="${path}/template/alert/sweetalert2.min.js"></script>
<!-- End custom js for this page-->
<script>
$(document).ready(function(){
	var sessId = "${loginMem.member_id}"
	if(sessId==""){
		alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
		location.href="${path}/login"
	} else if ("${loginMem.member_role}" != "EMP") {
		$("#mainPage").attr("href", "${path}/adMain")
	}
	
	var startChat = setInterval(function() {
		$.ajax({
			url : "${path}/chatSave",
			type : "POST",
			dataType : "json",
			success : function(data) {
				console.log(data)
			},
			error : function(err) {
				console.log(err)
			}
		})
	}, 120000)
})
</script>
<style>
.sidebar {
	height: 180px;
	min-height: auto;
}
.sidebar-icon-only .sidebar{
	height: 190px;
}
</style>
</head>
<body>
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
		<!-- 상단바 -->
		<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row" style="border-bottom:none;" >
			<!-- 왼쪽 상단 로고 -->
			<div class="navbar-brand-wrapper d-flex justify-content-center" style="background:white;">
				<div class="navbar-brand-inner-wrapper d-flex justify-content-between align-items-center w-100" >
					<a class="navbar-brand brand-logo" href="${path}/userIndex" >
					<img src="${path}/template/images/try_forge01.jpg" alt="logo" style="width:100%"/>
					<!-- <span>TryForge</span> -->
					</a> 
					<a class="navbar-brand brand-logo-mini" href="${path}/userIndex">
					<img src="${path}/template/images/try_logo.jpg" alt="logo" style="width:100%;"/></a>
					<button class="navbar-toggler navbar-toggler align-self-center"
						type="button" data-toggle="minimize" style="color:black; margin-left:10px;">
						<span class="typcn typcn-th-menu"></span>
					</button>
				</div>
			</div>
			
			<!-- 유저 -->
			<div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
				<ul class="navbar-nav mr-lg-2">
					<li class="nav-item nav-profile dropdown">
					<a class="nav-link" href="#" data-toggle="dropdown" id="profileDropdown">
						<c:if test="${profile ne ''}">
							<img src="${path}/FileStorage/${profile}" alt="profile"/>
						</c:if>
						<c:if test="${profile eq ''}">
							<img src="${path}/template/images/faces/face5.jpg" alt="profile"/>
						</c:if>
						<span class="nav-profile-name">${loginMem.member_name} 님</span>
					</a>
					<div class="dropdown-menu dropdown-menu-right navbar-dropdown"
						aria-labelledby="profileDropdown">
						<a class="dropdown-item" href="${path}/userIndex" id="mainPage">
							<i class="typcn typcn-device-desktop text-info"></i> 메인페이지
						</a>
						<a class="dropdown-item" href="${path}/login"> 
							<i class="typcn typcn-eject text-info"></i> 로그아웃
						</a>
					</div>
					</li>
				</ul>
				<ul class="navbar-nav navbar-nav-right">
					<!-- 달력 -->
					<li class="nav-item nav-date dropdown">
					<a class="nav-link d-flex justify-content-center align-items-center"
						href="javascript:;">
						<h6 class="date mb-0">Today : Mar 23</h6> 
						<i class="typcn typcn-calendar"></i>
					</a>
					</li>
					
				</ul>
			</div>
		</nav>
		
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_settings-panel.html -->
			<div class="theme-setting-wrapper">
				<!--  -->
				<!-- <div id="settings-trigger">
					<i class="typcn typcn-cog-outline"></i>
				</div> -->
				<div id="theme-settings" class="settings-panel">
					<i class="settings-close typcn typcn-times"></i>
					<p class="settings-heading">SIDEBAR SKINS</p>
					<div class="sidebar-bg-options selected" id="sidebar-light-theme">
						<div class="img-ss rounded-circle bg-light border mr-3"></div>
						Light
					</div>
					<div class="sidebar-bg-options" id="sidebar-dark-theme">
						<div class="img-ss rounded-circle bg-dark border mr-3"></div>
						Dark
					</div>
					<p class="settings-heading mt-2">HEADER SKINS</p>
					<div class="color-tiles mx-0 px-4">
						<div class="tiles success"></div>
						<div class="tiles warning"></div>
						<div class="tiles danger"></div>
						<div class="tiles info"></div>
						<div class="tiles dark"></div>
						<div class="tiles default"></div>
					</div>
				</div>
			</div>
			
			<!-- 사이드바 -->
			<!-- partial -->
			<!-- partial:partials/_sidebar.html -->
			<nav class="sidebar" id="sidebar" style="">
				<ul class="nav">
					<li class="nav-item">
						<a class="nav-link" href="${path}/myPage">
							<i class="typcn mdi mdi-account menu-icon"></i> <span
							class="menu-title">마이페이지</span>
							<!-- <div class="badge badge-danger">new</div> -->
					</a></li>
					
					<li class="nav-item">
						<a class="nav-link" href="${path}/memo">
							<i class="typcn mdi mdi-clipboard-text menu-icon"></i>
							<span class="menu-title">메모</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link"  href="${path}/chatHome">
							<i class="typcn mdi mdi-forum menu-icon"></i>
							<span class="menu-title">채팅</span>
						</a>
					</li>
					
					
				</ul>
			</nav>