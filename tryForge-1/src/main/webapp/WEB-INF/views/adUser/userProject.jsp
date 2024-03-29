<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${path}/template/module/module_admain.jsp" flush="true"/>

<style>
    #myModal .modal-dialog {
        max-width: 50%; /* 모달의 최대 너비를 80%로 설정 */
    }

    #myModal02 .modal-dialog {
        max-width: 45%; /* 모달의 최대 너비를 80%로 설정 */
    }

    #myModal02 .modal-content {
        border: 1px solid #000; /* 검정색 테두리 */
    }

    /* 입력 요소 여백 조절 */
    #myModal .form-group {
        margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
        margin-left: 3%;
        margin-right: 8%;
    }

    #myModal .form-control {
        margin-right: 3%; /* 입력 요소 오른쪽 여백 조절 */
        margin-left: 3%; /* 입력 요소 왼쪽 여백 조절 */
    }
</style>
<script>
    $(document).ready(function () {
        $("#clsBtn").click(function () {
            $("#myModal form")[0].reset()

        })
        $("#xBtn").click(function () {
            $("#myModal form")[0].reset()

        })
        $("#clsBtn02").click(function () {
            $("#modalFrm02")[0].reset()

        })
        $("#xBtn02").click(function () {
            $("#modalFrm02")[0].reset()

        })

        $("#insBtn").click(function () {
            schMem();
            $("#myModal02").modal('show');
        })
        $("[name=member_name]").keyup(function () {
            schMem();
        });

    });

    function openpage(key) {
        $("[name=project_key]").val(key);
        $.ajax({
            url: "${path}/userdetail?project_key=" + key,
            dataType: "json",
            success: function (data) {
                var projectInfo = data.projectInfo;
                var teamInfo = data.teamInfo;
                var tmInfo = data.tmInfo;
                var memberInfo = data.memberInfo;

                $("#myModal").modal('show');
                $("[name=title]").val(projectInfo.title);
                $("[name=team_name]").val(teamInfo.team_name);
                $("#modalFrm02 [name=team_key]").val(teamInfo.team_key);

                var startDate = new Date(projectInfo.start_date);
                startDate.setDate(startDate.getDate() + 1);
                var formattedStartDate = startDate.toISOString().split('T')[0];
                var endDate = new Date(projectInfo.end_date);
                endDate.setDate(endDate.getDate() + 1);
                var formattedEndDate = endDate.toISOString().split('T')[0];
                $("[name=start_date]").val(formattedStartDate);
                $("[name=end_date]").val(formattedEndDate);

                $("[name=detail]").val(projectInfo.detail);
                $("[name=left]").hide();
                $("#tm").text("프로젝트 구성원 확인");
                $("#right").removeClass("col-6");
                $("#right").addClass("col-12");
                $("#searchResults").css("height", "0px");

                // 각 회원에 대한 정보 처리
                $.each(memberInfo, function (index, member) {
                    // getTeamInfo 함수 호출
                    $("#selectMem").empty();
                    getTeamInfo(member.member_key, function (role, team_Member_key) {
                        var addhtml = ""; // 각 회원에 대한 HTML 행을 초기화
                        addhtml += "<tr><td>" + member.member_name + "</td>";
                        addhtml += "<td>" + member.member_email + "</td>";
                        addhtml += "<td class='tmInfoRow" + member.member_key + "'>" + role + "</td>";
                        addhtml += "<td><button type='button' class='btn btn-danger' onclick='deleteTm(" + team_Member_key + ")'>구성원 삭제</button></td>";
                        addhtml += "<td><button type='button' class='btn btn-' style='background-color: #007FFF; color: white;' onclick='changePL(" + team_Member_key + ")'>PL지정</button></td></tr>";

                        // 기존의 내용을 비우고 새로운 행을 추가
                        
                        $("#selectMem").append(addhtml);
                        $("#uptBtn").show();
                        $("#detailBtn").show();
                    });
                });
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    function getTeamInfo(member_key, callback) {
        var projectKey = $("[name=project_key]").val();
        $("[name=member_key1]").val(member_key)
        console.log(projectKey);
        $.ajax({
            url: "${path}/tmInfo",
            data: $("#roleForm").serialize(),
            dataType: "json",
            success: function (data) {
                var tmInfo = data.tmInfo;

                var team_member_key = tmInfo.team_Member_key;
                console.log("###"+tmInfo)
                console.log("###팀맴버키"+tmInfo.team_Member_key)
                console.log("###팀맴버키"+tmInfo.role)
                console.log("###팀맴버키"+tmInfo.member_key1)
                var role = tmInfo.role; // tmInfo에서 role 속성을 가져옴
                $(".tmInfoRow" + member_key).html(role); // role을 HTML에 적용
                callback(role, team_member_key);
            },
            error: function (err) {
                console.log(err);
                callback("Error retrieving role");
            }
        });
    }
    function deleteTm(team_member_key) {
    	console.log(team_member_key)
        $.ajax({
            url: "${path}/userDelete",
            dataType: "json",
            data: "team_Member_key=" + team_member_key,
            success: function (data) {
                var delMsg = data.delMsg;
                Swal.fire({
                    title: '구성원 삭제',
                    text: '구성원을 삭제하시겠습니까?',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: '확인',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        if (delMsg != null) {
                            // 삭제 메시지 표시
                            Swal.fire({
                                title: '성공',
                                text: delMsg,
                                icon: 'success'
                            }).then(() => {
                                // 확인 버튼 클릭 후 동작
                                $("#clsBtn").click();
                                window.location.reload();
                            });
                        } else {
                            // 삭제 실패 메시지 표시
                            Swal.fire({
                                title: '실패',
                                text: '구성원 삭제 실패',
                                icon: 'error'
                            });
                        }
                    }
                });
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    // PL변경  Ajax
    function changePL(team_member_key) {
        $.ajax({
            url: "${path}/assignPL",
            dataType: "json",
            data: "team_Member_key=" + team_member_key,
            success: function (data) {
                var uptMsg = data.uptMsg;
                Swal.fire({
                    title: '직책 변경',
                    text: '해당 구성원을 PL로 지정하시겠습니까?',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: '확인',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        if (uptMsg != null) {
                            // 삭제 메시지 표시
                            Swal.fire({
                                title: '성공',
                                text: uptMsg,
                                icon: 'success'
                            }).then(() => {
                                // 확인 버튼 클릭 후 동작
                                $("#clsBtn").click();
                                window.location.reload();
                            });
                        } else {
                            // 삭제 실패 메시지 표시
                            Swal.fire({
                                title: '실패',
                                text: '구성원 직책변경 실패',
                                icon: 'error'
                            });
                        }
                    }
                });
            },
            error: function (err) {
                console.log(err)
            }
        })
    }
    function schMem() {
        
        $.ajax({
            url: "${path}/schMem",
            data: $("#modalFrm02").serialize(),
            dataType: "json",
            success: function (data) {
                var memList = data.memList;
                var html = "";
                $(memList).each(function (idx, member) {
                    html += "<tr> ";
                    html += "<td>" + member.member_name + "</td>";
                    html += "<td>" + member.member_email + "</td>";
                    html += "<td>" + member.title + "</td>";
                    html += "<td>" + member.start_date + "</td>";
                    html += "<td>" + member.end_date + "</td>";
                    html += "</tr>";
                });
                
                // 할당 안된애
                $.ajax({
            url: "${path}/exceptSchMem",
            data: $("#modalFrm02").serialize(),
            dataType: "json",
            success: function (data) {
                var memList02 = data.memList02;
                console.log(memList02)
                
                $(memList02).each(function (idx, member) {
                    var member_key = member.member_key;
                   
                        html += "<tr ondblclick='selectMem(\"" + member_key + "\", \"" + member.member_name + "\", \"" + member.member_email + "\")' > ";
                        html += "<td>" + member.member_name + "</td>";
                        html += "<td>" + member.member_email + "</td>";
                        html += "<td style='text-align: center;'>·</td>";
                        html += "<td style='text-align: center;'>·</td>";
                        html += "<td><button class='btn btn-' style='background-color: #007FFF; color: white;' onclick='insNewTm(" + member.member_key + ")'>구성원 추가</button></td>";
                        html += "</tr>";
                    
                });
                $("#newMem").html(html);
            },
            error: function (err) {
                console.log(err);
            }
        });
                
                
                $("#newMem").html(html);
                
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

   
    function insNewTm(key) {
        $("#modalFrm02 [name=member_key1]").val(key);
        $.ajax({
            url: "${path}/insNewMem",
            dataType: "json",
            type: "post",
            data: $("#modalFrm02").serialize(),
            success: function (data) {
                var insMsg01 = data.insMsg;
                if(confirm("구성원을 추가 하시겠습니까?")){
                    alert(insMsg01)
                }else{
                    alert("구성원 추가 에러")
                }
               
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
</script>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <!-- 진행중인 프로젝트 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Ongoing Development Project</h4>
                        <!-- 진행중인 프로젝트 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>진행중인 프로젝트</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="plist" items="${plist}">
                                    <c:if test="${plist.status == '진행중'}">
                                        <tr ondblclick="openpage('${plist.project_key}')">
                                            <td>${plist.title}</td>
                                            <c:set var="formattedStartDate"
                                                   value="${fn:substring(plist.start_date, 0, 10)}"/>
                                            <td><c:out value="${formattedStartDate}"/></td>
                                            <c:set var="formattedEndDate"
                                                   value="${fn:substring(plist.end_date, 0, 10)}"/>
                                            <td><c:out value="${formattedEndDate}"/></td>
                                            
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 진행중인 프로젝트 end -->

            <!-- 완료된 프로젝트 -->
            <div class="col-md-12" style="margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Completed Projects</h4>
                        <!-- 완료된 프로젝트 테이블 -->
                        <div class="table-responsive" style="width: 95%; margin-left: 4%;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>완료된 프로젝트</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="plist" items="${plist}">
                                    <c:if test="${plist.status == '완료'}">
                                        <tr ondblclick="openpage('${plist.project_key}')">
                                            <td>${plist.title}</td>
                                            
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 완료된 프로젝트 end -->
        </div>
        <br>

    </div>
</div>
<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h2 class="modal-title">Project Information</h2>

                <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div style="display: flex;">
                    <h3 id=proTitle>프로젝트 정보</h3>
                    <div class="btn-group" style="margin-left: 50%;" id="detailBtn">


                    </div>
                </div>

            </div>
            <form id="roleForm">
            	  <input type="hidden" name="project_key"/>
            	  <input type="hidden" name="member_key1"/>
            </form>
            <form class="forms-sample" id="modalFrm">
          
                <input type="hidden" name="creater" value="${loginMem.member_key}"/>
                <div class="form-group">
                    <label for="exampleInputUsername1">프로젝트 타이틀</label>
                    <input name="title" type="text" class="form-control" id=""
                           placeholder="title">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">팀 명</label>
                    <input type="text" name="team_name" class="form-control" id="" placeholder="teamName">
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">프로젝트 시작일</label> <input
                        name="start_date" type="date" class="form-control" id=""
                        placeholder="startDate">
                </div>
                <div class="form-group">
                    <label for="exampleInputConfirmPassword1">프로젝트 종료일</label> <input
                        name="end_date" type="date" class="form-control" id=""
                        placeholder="endDate">
                </div>
                <div class="form-group">
                    <label for="exampleTextarea1">상세설명</label>
                    <textarea class="form-control" id="" rows="4" name="detail"></textarea>
                </div>
                <!-- 프로젝트 구성원 추가 -->
                <div class="form-group">
                    <label id="tm">프로젝트 구성원 추가</label>
                    <div class="row mt-3">
                        <!-- 아래: 검색 결과 -->
                        <div class="col-12" id="bottom">

                            <div id="searchResults"
                                 style="line-height: 300px; overflow-y: auto; margin-left: 3%; width: 100%;">
                                <table class="table table-hover">
                                    <tbody id="addMem">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- 위: 선택한 구성원 -->
                        <div class="col-12 mb-2" id="top">
                            <div id="selectMember"
                                 style="height: 200px; overflow-y: auto; width: 100%; margin-left: 3%;">
                                <input type="hidden" name="member_key" value=""
                                       id="hiddenMemberKey">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th style="width: 20%;">사원명</th>
                                        <th style="width: 30%;">이메일</th>
                                        <th style="width: 10%;">역할</th>
                                        <th style="width: 20%;">삭제</th>
                                        <th style="width: 20%;">PL지정</th>
                                    </tr>
                                    </thead>
                                    <tbody id="selectMem">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


            </form>


            <!-- Modal footer -->
            <div class="modal-footer">
                <div class="mx-auto">
                    <button type="button" class="btn btn-" id="insBtn"
                            style="background-color: #007FFF; color: white;">구성원 추가
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"
                            id="clsBtn">닫기
                    </button>
                </div>
            </div>

        </div>
    </div>
</div>


<!--사용자 추가 모달창-->
<div class="modal fade" id="myModal02" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <!-- modal-lg를 사용하거나 원하는 크기를 직접 지정할 수 있습니다. -->
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h2 class="modal-title">New Team Member</h2>

                <button type="button" class="close" data-dismiss="modal" id="xBtn02">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div style="display: flex;">
                    <h3>구성원 추가</h3>
                </div>
            </div>
            <form class="forms-sample" id="modalFrm02">
                <input type="hidden" name="member_key1"/>
                <input type="hidden" name="team_key"/>

                <div class="col-12">
                    <input type="text" class="form-control mb-2" name="member_name" placeholder="검색">
                    <div style=" overflow-y: auto; width: 100%; max-height: 500px;">
                        <table class="table table-hover">
                            <tbody id="newMem">
                            </tbody>
                        </table>
                    </div>
                </div>


            </form>


            <!-- Modal footer -->
            <div class="modal-footer">
                <div class="mx-auto">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"
                            id="clsBtn02">닫기
                    </button>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- 풋터 -->
<!-- content-wrapper ends -->
<!-- partial:partials/_footer.html -->
<!-- <footer class="footer">
<div class="card">
<div class="card-body">
<div
class="d-sm-flex justify-content-center justify-content-sm-between">
<span
class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright
Â© 2020 <a href="https://www.bootstrapdash.com/"
class="text-muted" target="_blank">Bootstrapdash</a>. All
rights reserved.
</span> <span
class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center text-muted">Free
<a href="https://www.bootstrapdash.com/" class="text-muted"
target="_blank">Bootstrap dashboard</a> templates from
Bootstrapdash.com
</span>
</div>
</div>
</div>
</footer> -->
<!-- partial -->
<!-- </div> -->
<!-- main-panel ends -->
<!-- 이 밑은 복붙할때 알아서 붙이쇼 -->
</div>
<!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->


</body>

</html>