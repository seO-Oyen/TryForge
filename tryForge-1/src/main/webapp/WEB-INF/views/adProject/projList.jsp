<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${path}/template/module/module_admain.jsp" flush="true"/>
<style>
    #myModal .modal-dialog {
        max-width: 50%;
    }

    .card-title {
        font-size: 20px;
        font-weight: bold;
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

    #searchResults {
        overflow-y: auto;
        margin-left: 3%;
        width: 100%;
        max-height: 500px;
    !important;
    }
</style>
<script>
var exceptSchMlist=[];
    $(document).ready(function () {
        $("#clsBtn").click(function () {
            $("#myModal form")[0].reset()

        })
        $("#xBtn").click(function () {
            $("#myModal form")[0].reset()

        })
        $("#regProj").click(function () {
            $("#regBtn").show()
            $("#convertRegBtn").hide()
            regNewProject()
        })
        $("[name=member_name]").keyup(function () {
            schMem();
            
        });

        insertProject();

        $("#returnBtn").click(function () {
            $("#regBtn").hide()
            $("#convertRegBtn").show()
            regNewProject()
        })
        $("#convertRegBtn").click(function (){
            if (getAllMemberKeys() === "") {
                return;
            }
            if (!emptyCheck()) {
                return;
            }
            convertProject()
        })

    });

    function regNewProject() {
        $("#myModal").modal('show');
        $(".modal-title").text("New Project")
        $("#proTitle").text("프로젝트 생성")
        // 구성원 목록 초기화
        $("#selectMem").empty();
        // 왼쪽 검색 결과 초기화
        $("#left input").val("");
        $("#addMem").empty();
        // 검색 결과 창 높이 초기화
        $("#searchResults").css("height", "150px");
        // 프로젝트 구성원 추가 영역 초기화
        $("#right").removeClass("col-12");
        $("#right").addClass("col-6");
        $("#tm").text("프로젝트 구성원 추가");
        $("[name=member_name]").show();
        //$("#regBtn").show()
        $("#uptBtn").hide()
        $("#memberDiv").show()
        $("#teamNameDiv").show()
        $("#returnBtn").hide()
        $("#reservation").hide()
        schMem();
    }

    function insertProject() {

        $("#regBtn").click(function () {

            event.preventDefault();
            // 공백 유효성 체크
            if (getAllMemberKeys() === "") {
                return;
            }
            getAllMemberKeys();
            if (!emptyCheck()) {
                return;
            }
            $.ajax({
                // 등록 controller 호출
                url: "${path}/insertAll",
                type: "POST",
                data: $("#modalFrm").serialize(),
                dataType: "json",
                success: function (data) {
                    var msg = data.insertAll;
                    Swal.fire({
                        title: '성공',
                        text: '프로젝트 생성 성공',
                        icon: 'success',
                    }).then(function () {
                        $("#clsBtn").click();
                        window.location.reload();
                    });
                },
                error: function (err) {
                    console.log(err)
                }
            })
        })
    }
    

    function schMem() {
        console.log("exceptSchMlist length: " + exceptSchMlist.length);
        console.log("exceptSchMlist content: ", exceptSchMlist);
        $.ajax({
            url: "${path}/schMem",
            data: $("#modalFrm").serialize(),
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
            data: $("#modalFrm").serialize(),
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
                        html += "<td style='text-align: center;'>·</td>";
                        html += "</tr>";
                    
                });
                $("#addMem").html(html);
            },
            error: function (err) {
                console.log(err);
            }
        });
                
                
                $("#addMem").html(html);
                
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
    function selectMem(member_key, member_name, member_email) {
        var row = "<tr data-member-key='" + member_key + "'>";
        row += "<td>" + member_name + "</td>";
        row += "<td>" + member_email + "</td>";
        row += "<td><button class='btn btn-danger' type='button' onclick='deleteMem(this)'>삭제</button></td>";
        row += "</tr>";
        $("#selectMem").append(row);
    }

    function deleteMem(buttonElement) {
        // 삭제 버튼이 속한 행을 찾아서 삭제
        var row = $(buttonElement).closest("tr");
        var member_key = row.data("member-key");
        row.remove();
    }

    // 폼 안에 hidden 필드 추가
    $("#modalFrm").append("<input type='hidden' name='member_key' value='' id='hiddenMemberKey'>");
    var member_key = [];

    function getAllMemberKeys() {
        member_key = [];
        $("#selectMem tr").each(function () {
            var memberKey = $(this).data("member-key");
            member_key.push(memberKey);
        });
        
        if(member_key.length==1){
        	 Swal.fire({
                 title: '구성원선택',
                 text: '구성원은 두명이상 선택해주세요',
                 icon: 'error',
             });
             return "";
        }else{
            const setCollection = new Set(member_key)
            const isDuplicate = setCollection.size < member_key.length
            if (isDuplicate) {
                Swal.fire({
                    title: '중복발생',
                    text: '구성원이 중복으로 추가되었습니다',
                    icon: 'error',
                });
                return "";
            } else {
                $("#hiddenMemberKey").val(member_key);
                return member_key;
            }
        }
      
    }

    function openpage(key) {
        $.ajax({
            url: "${path}/detail",
            data: "project_key=" + key,
            dataType: "json",
            success: function (data) {
                var projectInfo = data.projectInfo;
                var teamInfo = data.teamInfo;
                var tmInfo = data.tmInfo;
                var memberInfo = data.memberInfo;
                // 모달창 내용 변경
                $("#myModal").modal('show');
                $(".modal-title").text("Project Information")
                $("#proTitle").text("상세정보 조회")
                $("[name=title]").val(projectInfo.title)
                $("[name=team_name]").val(teamInfo.team_name)
                $("#returnBtn").hide()
                var startDate = new Date(projectInfo.start_date);
                startDate.setDate(startDate.getDate() + 1);
                var formattedStartDate = startDate.toISOString().split('T')[0];
                var endDate = new Date(projectInfo.end_date);
                endDate.setDate(endDate.getDate() + 1);
                var formateedendtDate = endDate.toISOString().split('T')[0];
                $("[name=start_date]").val(formattedStartDate)
                $("[name=end_date]").val(formateedendtDate)
                $("#memberDiv").show()
                $("#teamNameDiv").show()
                $("[name=detail]").val(projectInfo.detail)
                $("[name=left]").hide()
                $("[name=member_name]").hide()
                $("#tm").text("프로젝트 구성원 확인")
                $("#right").removeClass("col-6");
                $("#right").addClass("col-12");
                $("#searchResults").css("height", "0px");
                $("#reservation").hide()
                // 다중 멤버 each 처리
                var addhtml = "";
                $.each(memberInfo, function (index, member) {
                    if (member.member_name == null) {
                        addhtml += "<tr><td>" + 구성원없음 + "</td></tr>";
                    } else {
                        addhtml += "<tr><td>" + member.member_name + "</td><td>"
                            + member.member_email + "</td></tr>";
                    }
                });
                // 기존의 내용을 비우고 새로운 행을 추가
                $("#selectMem").empty().append(addhtml);
                $("#regBtn").hide()
                $("#uptBtn").show()
                $("#detailBtn").show()
                $("#convertRegBtn").hide()
                $("#delBtn").click(function () {
                    Swal.fire({
                        title: '삭제',
                        text: '해당 프로젝트를 삭제하시겠습니까?',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonText: '확인',
                        cancelButtonText: '취소',
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            delAll(key);
                        }
                    });
                });
                $("#endBtn").click(function () {
                    Swal.fire({
                        title: '확인',
                        text: '진행상태를 완료로 변경하시겠습니까?',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonText: '확인',
                        cancelButtonText: '취소',
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            uptFin(key);
                        }
                    });
                });
                // 수정
                $("#uptBtn").click(function () {
                    Swal.fire({
                        title: '확인',
                        text: '내용을 변경하시겠습니까?',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonText: '확인',
                        cancelButtonText: '취소',
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            uptAll(key);
                        }
                    });
                });
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    function delAll(key) {
        $.ajax({
            url: "${path}/delAll?project_key=" + key,
            //data:$("#modalFrm").serialize(),
            dataType: "json",
            success: function (data) {
                var delmsg = data.delmsg;
                if (delmsg != null) {
                    Swal.fire({
                        title: '삭제 성공',
                        text: ' ',
                        icon: 'success',
                    }).then(function () {
                        $("#clsBtn").click();
                        window.location.reload();
                    });

                }
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    function uptFin(key) {
        $.ajax({
            url: "${path}/uptProjectFin?project_key=" + key,
            dataType: "json",
            success: function (data) {
                var uptmsg = data.uptmsg;
                if (uptmsg != null) {
                    Swal.fire({
                        title: '수정 성공',
                        text: uptmsg,
                        icon: 'success',
                    }).then(function () {
                        $("#clsBtn").click();
                        window.location.reload();
                    });
                }
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    function uptAll(key) {
        
        $.ajax({
            url: "${path}/uptAll?project_key=" + key,
            dataType: "json",
            data: $("#modalFrm").serialize(),
            success: function (data) {
                var uptAllmsg = data.uptAllmsg;
                if (uptAllmsg != null) {
                    Swal.fire({
                        title: '수정 성공',
                        text: ' ',
                        icon: 'success',
                    }).then(function () {
                        $("#clsBtn").click();
                        window.location.reload();
                    });
                }
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    function emptyCheck() {
        var title = $("#modalFrm [name='title']").val();
        var teamName = $("#modalFrm [name='team_name']").val();
        var startDate = $("#modalFrm [name='start_date']").val();
        var endDate = $("#modalFrm [name='end_date']").val();
        var detail = $("#modalFrm [name='detail']").val();
        if (title.trim() === "" || teamName.trim() === "" || startDate === ""
            || endDate === "" || detail.trim() === "" || member_key.length === 0) {
            Swal.fire({
                icon: 'warning',
                title: '입력 오류',
                text: '모든 입력칸을 채워주세요',
                confirmButtonColor: '#007FFF',
            });
            return false;
        }
        return true;
    }

    function bookProject() {
        $("#memberDiv").hide()
        $("#teamNameDiv").hide()
        $("#myModal").modal('show');
        $("#regBtn").hide()
        $("#returnBtn").hide()
        $("#uptBtn").hide()
        $("#detailBtn").hide()
        $("#reservation").show()
        $("#convertRegBtn").hide()
        $("#reservation").click(function () {
            $.ajax({
                url: "${path}/insBookProject",
                data: $("#modalFrm").serialize(),
                dataType: "json",
                type: "post",
                success: function (data) {
                    if (data.bookInsMsg != null) {
                        Swal.fire({
                            title: '성공',
                            text: data.bookInsMsg,
                            icon: 'success',
                        }).then(function () {
                            $("#clsBtn").click();
                            window.location.reload();
                        });
                    }
                },
                error: function (err) {
                    console.log(err)
                }
            })
        })
    }
    function bookPage(key) {
        $("[name=project_key]").val(key)
        $.ajax({
            url: "${path}/projectDetail",
            data: "project_key=" + key,
            dataType: "json",
            success: function (data) {
                var projectInfo = data.pjDetail;
                // 모달창 내용 변경
                $("#myModal").modal('show');
                $(".modal-title").text("Project Information")
                $("#proTitle").text("상세정보 조회")
                $("[name=title]").val(projectInfo.title)
                var startDate = new Date(projectInfo.start_date);
                startDate.setDate(startDate.getDate() + 1);
                var formattedStartDate = startDate.toISOString().split('T')[0];
                var endDate = new Date(projectInfo.end_date);
                endDate.setDate(endDate.getDate() + 1);
                var formateedendtDate = endDate.toISOString().split('T')[0];
                $("[name=start_date]").val(formattedStartDate)
                $("[name=end_date]").val(formateedendtDate)
                $("#memberDiv").hide()
                $("#teamNameDiv").hide()
                $("#detailBtn").show()
                $("#endBtn").hide()
                $("#delBtn").show()

                $("#regBtn").hide()
                $("[name=detail]").val(projectInfo.detail)
                $("#returnBtn").show()
                $("#uptBtn").hide()
                $("#reservation").hide()
                $("#convertRegBtn").hide()
            },
            error: function (err) {
                console.log(err)
            }
        });

        $("#delBtn").click(function () {
            Swal.fire({
                title: '삭제',
                text: '해당 프로젝트를 삭제하시겠습니까?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            }).then(function (result) {
                if (result.isConfirmed) {
                    delAll(key);
                }
            });
        });
    }
   function convertProject(){
       getAllMemberKeys();
        $.ajax({
            url:"${path}/convertProject",
            type: "POST",
            data: $("#modalFrm").serialize(),
            dataType: "json",
            success:function (data){
               if(data.convertMsg!=null){
                   Swal.fire({
                       title: '성공',
                       text: data.convertMsg,
                       icon: 'success',
                   }).then(function () {
                       $("#clsBtn").click();
                       window.location.reload();
                   });
               }
            },
            error:function (err){
                console.log(err)
            }
        })
    }

    function goDash(projectKey) {
       
        $.ajax({
            url : "${path}/setPj",
            type : "GET",
            data : {
                projectNum: projectKey
            },
            dataType : "json",
            success : function(data) {
             
                location.href = "${path}/dashboard"
            },
            error : function(err) {
                console.log(err)
            }
        })
    }
</script>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <!-- 진행중인 프로젝트 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">진행중인 프로젝트</h4>
                        <!-- 진행중인 프로젝트 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트명</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                    <th>대시보드 이동</th>
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
                                            <td>
                                                <button type="button"
                                                        onclick="goDash('${plist.project_key}')"
                                                        class="btn btn-link btn-rounded btn-fw">대시보드
                                                </button>
                                            </td>
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
            <!-- 대기중인 프로젝트 -->
            <div class="col-md-12" style=" margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <div style="display: flex;">
                            <h4 class="card-title">대기중인 프로젝트</h4>
                            <button type="button" class="btn btn-link btn-fw"
                                    style="font-size: 20px; margin-left: 70%; padding-top: 0;" id="bookBtn"
                                    onclick="bookProject()">프로젝트 예약 생성
                            </button>
                        </div>

                        <!-- 대기중인 프로젝트 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트명</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                   
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="plist" items="${plist}">
                                    <c:if test="${plist.status == '대기중'}">
                                        <tr ondblclick="bookPage('${plist.project_key}')">
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
            <!-- 완료된 프로젝트 -->
            <div class="col-md-12" style="margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">완료된 프로젝트</h4>
                        <!-- 완료된 프로젝트 테이블 -->
                        <div class="table-responsive" style="width: 95%; margin-left: 4%;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트명</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                    <th>대시보드 이동</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="plist" items="${plist}">
                                    <c:if test="${plist.status == '완료'}">
                                        <tr ondblclick="openpage('${plist.project_key}')">
                                            <td>${plist.title}</td>
                                            <c:set var="formattedStartDate"
                                                   value="${fn:substring(plist.start_date, 0, 10)}"/>
                                            <td><c:out value="${formattedStartDate}"/></td>
                                            <c:set var="formattedEndDate"
                                                   value="${fn:substring(plist.end_date, 0, 10)}"/>
                                            <td><c:out value="${formattedEndDate}"/></td>
                                            <td>
                                                <button type="button"
                                                        onclick="goDash('${plist.project_key}')"
                                                        class="btn btn-link btn-rounded btn-fw">대시보드
                                                </button>
                                            </td>
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
        <button type="button" class="btn btn-dark btn-lg btn-block"
                id="regProj"
                style="width: 50%; margin-left: 24%; background-color: #007FFF; border: none;">프로젝트
            생성
        </button>
    </div>
</div>
<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h2 class="modal-title">New Project</h2>
                <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
                <div style="display: flex;">
                    <h3 id=proTitle>프로젝트 생성</h3>
                    <div class="btn-group" style="margin-left: 50%;" id="detailBtn">
                        <button type="button" class="btn btn-"
                                style="background-color: #007FFF; color: white;">프로젝트
                            상세설정
                        </button>
                        <button type="button"
                                style="background-color: #007FFF; color: white;"
                                class="btn btn- dropdown-toggle dropdown-toggle-split"
                                id="dropdownMenuSplitButton1" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu"
                             aria-labelledby="dropdownMenuSplitButton1">
                            <button class="dropdown-item" id="endBtn">프로젝트 완료</button>
                            <button class="dropdown-item" id="delBtn">프로젝트 삭제</button>
                        </div>
                    </div>
                </div>
            </div>
            <form class="forms-sample" id="modalFrm">
                <input type="hidden" name="creater" value="${loginMem.member_key}"/>
                <input type="hidden" name="project_key"/>
                <div class="form-group">
                    <label for="exampleInputUsername1">프로젝트 타이틀</label> <input
                        name="title" type="text" class="form-control" id=""
                        placeholder="title">
                </div>
                <div class="form-group" id="teamNameDiv">
                    <label for="exampleInputEmail1">팀 명</label> <input type="text"
                                                                       name="team_name" class="form-control" id=""
                                                                       placeholder="teamName">
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
                <div id="memberDiv">
                    <!-- 프로젝트 구성원 추가 -->
                    <div class="form-group">
                        <label id="tm">프로젝트 구성원 추가</label>
                        <p style="color:red">*구성원은 2명이상 선택해주세요</p>
                        <div class="row mt-3">
                            <!-- 아래: 검색 결과 -->
                            <div class="col-12" id="bottom">
                                <input type="text" class="form-control mb-2" name="member_name"
                                       placeholder="검색">
                                <div id="searchResults">
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
                                        <tbody id="selectMem">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Modal footer -->
            <div class="modal-footer">
                <div class="mx-auto">
                    <button type="button" class="btn btn-" id="reservation"
                            style="background-color: #007FFF; color: white;">예약
                    </button>
                    <button type="button" class="btn btn-" id="returnBtn"
                            style="background-color: #007FFF; color: white;">진행프로젝트 변경
                    </button>
                    <button type="button" class="btn btn-" id="regBtn"
                            style="background-color: #007FFF; color: white;">등록
                    </button>
                    <button type="button" class="btn btn-" id="uptBtn"
                            style="background-color: #007FFF; color: white;">수정
                    </button>
                    <button type="button" class="btn btn-" id="convertRegBtn"
                            style="background-color: #007FFF; color: white;">변경등록
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"
                            id="clsBtn">닫기
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

