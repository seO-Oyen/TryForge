<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <!--vue, axios-->
    <script src="https://unpkg.com/vue" type="text/javascript"></script>
    <script type="text/javascript" src="https://unpkg.com/axios"></script>
    <script type="text/javascript" src="https://unpkg.com/moment@2.30.1/moment.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.min.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page-->
    <script src="${path}/template/js/dashboard.js"></script>
    <script src="${path}/template/calendar/index.global.js"></script>
    <script src="${path}/template/gantt/codebase/dhtmlxgantt.js"></script>
    <script src="${path}/template/alert/sweetalert2.min.js"></script>
    <!--chart.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.min.js"></script>
    <!-- End custom js for this page-->
    <script>
        $(document).ready(function () {
            var sessId = "${loginMem.member_id}"
            if (sessId == "") {
                alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
                location.href = "${path}/login"
            } else if ("${loginMem.member_role}" != "EMP") {
                $("#admin").css("display", "")
            } else if ("${loginMem.member_role}" == "EMP") {
                alert("일반 유저는 어드민 페이지로 올 수 없습니다.")
                location.href = "${path}/userIndex"
            }
            function updateNavigation() {
                var currentPage = window.location.pathname;
                var titleElement = $('.navbar-menu-wrapper #titleText');
                var detailElement = $('#detailText');

                switch (currentPage) {
                    case '/adMain':
                        titleElement.text('Adminmain')
                        detailElement.text('관리자페이지  >  메인페이지')
                        break;
                    case '/projList':
                        titleElement.text('Project')
                        detailElement.text('관리자페이지  >  프로젝트관리')
                        break;
                    case '/task':
                        titleElement.text('Task')
                        detailElement.text('관리자페이지  >  업무할당관리')
                        break;
                    case '/noticeList':
                        titleElement.text('Notice')
                        detailElement.text('관리자페이지  >  공지사항조회')
                        break;
                    case '/getNotice':
                        titleElement.text('Notice')
                        detailElement.text('관리자페이지  >  공지사항상세')
                        break;
                    case '/insertNotice':
                        titleElement.text('Notice')
                        detailElement.text('관리자페이지  >  공지사항등록')
                        break;
                    case '/updateNoticeFrm':
                        titleElement.text('Notice')
                        detailElement.text('관리자페이지  >  공지사항수정')
                        break;
                    case '/updateNotice':
                        titleElement.text('Notice')
                        detailElement.text('관리자페이지  >  공지사항수정')
                        break;
                    case '/deleteNotice':
                        titleElement.text('Notice')
                        detailElement.text('관리자페이지  >  공지사항삭제')
                        break;
                    case '/taskManage':
                        titleElement.text('Task')
                        detailElement.text('관리자페이지  >  리스크관리')
                        break;
                    case '/adUser':
                        titleElement.text('UserManage')
                        detailElement.text('관리자페이지  >  사용자관리')
                        break;
                    case '/adApprovalPlist':
                        titleElement.text('Approval')
                        detailElement.text('관리자페이지  >  결재관리')
                        break;
                    case '/adApproval':
                        titleElement.text('Approval')
                        detailElement.text('관리자페이지  >  결재관리')
                        break;
                    case '/errorList':
                        titleElement.text('Error')
                        detailElement.text('시스템관리자  >  에러관리')
                        break;
                    case '/acceptRole':
                        titleElement.text('AcceptRole')
                        detailElement.text('관리자페이지  >  권한요청관리')
                        break;
                    case '/adRiskApprovalPlist':
                        titleElement.text('RIsk')
                        detailElement.text('관리자페이지  >  리스크 관리')
                        break;

                    default:
                        titleElement.text('Manage')
                        detailElement.text('관리자페이지  >  관리페이지')
                        break;
                }
            }

            updateNavigation();
        })
    </script>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <!-- 상단바 -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row" style="border-bottom:none;">
        <!-- 왼쪽 상단 로고 -->
        <div class="navbar-brand-wrapper d-flex justify-content-center" style="background:white;">
            <div class="navbar-brand-inner-wrapper d-flex justify-content-between align-items-center w-100">
                <a class="navbar-brand brand-logo" href="${path}/adMain">
                    <img src="${path}/template/images/try_forge01.jpg" alt="logo" style="width:100%"/>
                    <!-- <span>TryForge</span> -->
                </a>
                <a class="navbar-brand brand-logo-mini" href="index.jsp">
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
                        <a class="dropdown-item" href="${path}/myPage">
                            <i class="typcn typcn-cog-outline text-primary"></i> 마이페이지
                        </a>
                        <a class="dropdown-item" href="${path}/login">
                            <i class="typcn typcn-eject text-primary"></i> 로그아웃
                        </a>
                    </div>
                </li>
                <!-- <li class="nav-item nav-user-status dropdown">
                    <p class="mb-0">(마지막 로그인 시간)</p>
                </li> -->
            </ul>
            <ul class="navbar-nav navbar-nav-right">
                <!-- 달력 -->
                <li class="nav-item nav-date dropdown">
                    <a class="nav-link d-flex justify-content-center align-items-center"
                       href="javascript:;">
                        <h6 class="date mb-0" id="currentDate"></h6>
                        <i class="typcn typcn-calendar"></i>
                    </a>
                </li>


            </ul>
            <!-- 무슨 버튼인지 모르겠음. 화면상으론 안뜸 -->
            <!-- <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center"
                type="button" data-toggle="offcanvas">
                <span class="typcn typcn-th-menu"></span>
            </button> -->
        </div>
    </nav>

    <!-- 기존 민트색 상단바-->
    <!-- partial -->
    <nav class="navbar-breadcrumb col-xl-12 col-12 d-flex flex-row p-0" style="background:#007FFF;">

        <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
            <ul class="navbar-nav mr-lg-2">
                <li class="nav-item ml-0">
                    <h3 class="mb-0" id="titleText"></h3>

                </li>
                <li class="nav-item">
                    <div class="d-flex align-items-baseline">
                        <i class="typcn typcn-chevron-right" style="font-size:23px;"></i>
                        <p id="detailText" class="mb-0" style="font-size: 20px; margin-left: 10px;"></p>
                    </div>
                </li>
            </ul>
            <!-- 검색창 => <ul>은 공간때문에 냅둠 -->
            <ul class="navbar-nav navbar-nav-right">
                <!-- <li class="nav-item nav-search d-none d-md-block mr-0">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search..."
                            aria-label="search" aria-describedby="search">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="search"> <i
                                class="typcn typcn-zoom"></i>
                            </span>
                        </div>
                    </div>
                </li> -->
            </ul>
        </div>
        <!-- 아이콘 버튼 -->
        <div class="navbar-links-wrapper d-flex align-items-stretch">
            <div class="nav-link" style="border-right:none; flex-grow:0.1; margin-left:60%;">
                <a onclick="location.href='${path}/adMain'">
                    <i class="mdi mdi-desktop-mac"></i></a>
            </div>


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
        <div id="right-sidebar" class="settings-panel">
            <i class="settings-close typcn typcn-times"></i>
            <ul class="nav nav-tabs" id="setting-panel" role="tablist">
                <li class="nav-item"><a class="nav-link active" id="todo-tab"
                                        data-toggle="tab" href="#todo-section" role="tab"
                                        aria-controls="todo-section" aria-expanded="true">TO DO LIST</a></li>
                <li class="nav-item"><a class="nav-link" id="chats-tab"
                                        data-toggle="tab" href="#chats-section" role="tab"
                                        aria-controls="chats-section">CHATS</a></li>
            </ul>
            <div class="tab-content" id="setting-content">
                <div class="tab-pane fade show active scroll-wrapper"
                     id="todo-section" role="tabpanel" aria-labelledby="todo-section">
                    <div class="add-items d-flex px-3 mb-0">
                        <form class="form w-100">
                            <div class="form-group d-flex">
                                <input type="text" class="form-control todo-list-input"
                                       placeholder="Add To-do">
                                <button type="submit"
                                        class="add btn btn-primary todo-list-add-btn" id="add-task">Add
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="list-wrapper px-3">
                        <ul class="d-flex flex-column-reverse todo-list">
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label"> <input
                                            class="checkbox" type="checkbox"> Team review meeting
                                        at 3.00 PM
                                    </label>
                                </div>
                                <i class="remove typcn typcn-delete-outline"></i>
                            </li>
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label"> <input
                                            class="checkbox" type="checkbox"> Prepare for
                                        presentation
                                    </label>
                                </div>
                                <i class="remove typcn typcn-delete-outline"></i>
                            </li>
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label"> <input
                                            class="checkbox" type="checkbox"> Resolve all the low
                                        priority tickets due today
                                    </label>
                                </div>
                                <i class="remove typcn typcn-delete-outline"></i>
                            </li>
                            <li class="completed">
                                <div class="form-check">
                                    <label class="form-check-label"> <input
                                            class="checkbox" type="checkbox" checked> Schedule
                                        meeting for next week
                                    </label>
                                </div>
                                <i class="remove typcn typcn-delete-outline"></i>
                            </li>
                            <li class="completed">
                                <div class="form-check">
                                    <label class="form-check-label"> <input
                                            class="checkbox" type="checkbox" checked> Project
                                        review
                                    </label>
                                </div>
                                <i class="remove typcn typcn-delete-outline"></i>
                            </li>
                        </ul>
                    </div>
                    <div class="events py-4 border-bottom px-3">
                        <div class="wrapper d-flex mb-2">
                            <i class="typcn typcn-media-record-outline text-primary mr-2"></i>
                            <span>Feb 11 2018</span>
                        </div>
                        <p class="mb-0 font-weight-thin text-gray">Creating component
                            page</p>
                        <p class="text-gray mb-0">build a js based app</p>
                    </div>
                    <div class="events pt-4 px-3">
                        <div class="wrapper d-flex mb-2">
                            <i class="typcn typcn-media-record-outline text-primary mr-2"></i>
                            <span>Feb 7 2018</span>
                        </div>
                        <p class="mb-0 font-weight-thin text-gray">Meeting with Alisa</p>
                        <p class="text-gray mb-0 ">Call Sarah Graves</p>
                    </div>
                </div>
                <!-- To do section tab ends -->
                <div class="tab-pane fade" id="chats-section" role="tabpanel"
                     aria-labelledby="chats-section">
                    <div
                            class="d-flex align-items-center justify-content-between border-bottom">
                        <p
                                class="settings-heading border-top-0 mb-3 pl-3 pt-0 border-bottom-0 pb-0">Friends</p>
                        <small
                                class="settings-heading border-top-0 mb-3 pt-0 border-bottom-0 pb-0 pr-3 font-weight-normal">See
                            All</small>
                    </div>
                    <ul class="chat-list">
                        <li class="list active">
                            <div class="profile">
                                <img src="${path}/template/images/faces/face1.jpg" alt="image"><span
                                    class="online"></span>
                            </div>
                            <div class="info">
                                <p>Thomas Douglas</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">19 min</small>
                        </li>
                        <li class="list">
                            <div class="profile">
                                <img src="${path}/template/images/faces/face2.jpg" alt="image"><span
                                    class="offline"></span>
                            </div>
                            <div class="info">
                                <div class="wrapper d-flex">
                                    <p>Catherine</p>
                                </div>
                                <p>Away</p>
                            </div>
                            <div class="badge badge-success badge-pill my-auto mx-2">4</div>
                            <small class="text-muted my-auto">23 min</small>
                        </li>
                        <li class="list">
                            <div class="profile">
                                <img src="${path}/template/images/faces/face3.jpg" alt="image"><span
                                    class="online"></span>
                            </div>
                            <div class="info">
                                <p>Daniel Russell</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">14 min</small>
                        </li>
                        <li class="list">
                            <div class="profile">
                                <img src="${path}/template/images/faces/face4.jpg" alt="image"><span
                                    class="offline"></span>
                            </div>
                            <div class="info">
                                <p>James Richardson</p>
                                <p>Away</p>
                            </div>
                            <small class="text-muted my-auto">2 min</small>
                        </li>
                        <li class="list">
                            <div class="profile">
                                <img src="${path}/template/images/faces/face5.jpg" alt="image"><span
                                    class="online"></span>
                            </div>
                            <div class="info">
                                <p>Madeline Kennedy</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">5 min</small>
                        </li>
                        <li class="list">
                            <div class="profile">
                                <img src="${path}/template/images/faces/face6.jpg" alt="image"><span
                                    class="online"></span>
                            </div>
                            <div class="info">
                                <p>Sarah Graves</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">47 min</small>
                        </li>
                    </ul>
                </div>
                <!-- chat tab ends -->
            </div>
        </div>

        <!-- 사이드바 -->
        <!-- partial -->
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <ul class="nav">
                <li class="nav-item"><a class="nav-link" href="${path}/projList">
                    <i class="tpycn mdi mdi-airplay menu-icon"></i> <span
                        class="menu-title">프로젝트관리</span>
                    <!-- <div class="badge badge-danger">new</div> -->
                </a></li>


                <li class="nav-item">
                    <a class="nav-link" href="${path}/adUser">

                        <i class="tpycn mdi mdi-account-check menu-icon"></i>

                        <span class="menu-title">사용자관리</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/task">
                        <i class="tpycn mdi mdi-file-export menu-icon"></i>
                        <span class="menu-title">업무할당관리</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/taskManage">
                        <i class="tpycn mdi mdi-checkbox-marked-circle menu-icon"></i>
                        <span class="menu-title">리스크관리</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/adApprovalPlist">
                        <i class="tpycn mdi mdi-file-check menu-icon"></i>
                        <span class="menu-title">결재관리</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/noticeList">
                        <i class="tpycn mdi mdi-tooltip-text menu-icon"></i>
                        <span class="menu-title">공지사항관리</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/acceptRole">
                        <i class="tpycn mdi mdi-account-plus menu-icon"></i>
                        <span class="menu-title">권한요청관리</span>
                    </a>
                </li>
                <li class="nav-item"><a class="nav-link" href="${path}/insertUser">
                    <i class="tpycn mdi mdi-account-multiple-plus menu-icon"
                       style="width: 20px; height: 20px;"></i> <span class="menu-title">사용자 초대</span>
                </a>
                </li>


                <li class="nav-item"><a class="nav-link"
                                        href="${path}/userIndex"> <i
                        class="tpycn mdi mdi-account-convert menu-icon">

                </i> <span class="menu-title">일반유저페이지</span>
                    <!-- <i class="menu-arrow"></i> -->
                </a> <!-- <div class="collapse" id="auth">
						</div> -->
                </li>

                <li class="nav-item"><a class="nav-link"
                                        href="${path}/errorList"> <i
                        class="tpycn mdi mdi-window-close menu-icon">

                </i> <span class="menu-title">에러관리</span>
                    <!-- <i class="menu-arrow"></i> -->
                </a> <!-- <div class="collapse" id="auth">
						</div> -->
                </li>


            </ul>
        </nav>

        <script>
            // 현재 날짜를 가져오는 함수
            function getCurrentDate() {
                var currentDate = new Date();
                var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                var month = monthNames[currentDate.getMonth()];
                var day = currentDate.getDate();

                return month + ' ' + day;
            }

            // 페이지 로딩 시 현재 날짜로 업데이트
            document.addEventListener("DOMContentLoaded", function () {
                document.getElementById('currentDate').innerText = 'Today: ' + getCurrentDate();
            });
        </script>