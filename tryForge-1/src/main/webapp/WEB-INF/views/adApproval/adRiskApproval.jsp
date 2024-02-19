<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
    function confirmMsg(title, text, icon, onConfirm, onCancel) {
        Swal.fire({
            title: title,
            text: text,
            icon: icon,
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '승인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed && typeof onConfirm === 'function') {
                onConfirm();
            } else if (result.dismiss === Swal.DismissReason.cancel && typeof onCancel === 'function') {
                onCancel();
            }
        });
    }

    function msg(icon, title, text) {
        Swal.fire({
            icon: icon,
            title: title,
            text: text,
        });
    }
</script>

<jsp:include page="${path}/template/module/module_admain.jsp"
             flush="true"/>
<style>
    .card-title {
        font-size: 20px;
        font-weight: bold;
    }
    #myModal .modal-dialog {
        max-width: 50%; /* 모달의 최대 너비를 80%로 설정 */
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
        aplist();
    })
    function aplist(){
        var currentUrl = window.location.href;
        var urlParams = new URL(currentUrl).searchParams;
        var projectKey = urlParams.get('project_key');
        $.ajax({
            url: "${path}/riskapprovalList",
            data: "project_key="+projectKey,
            dataType: "json",
            success: function (data) {
                var row01 = "";
                var row02 = "";
                var row03 = "";
                $(data.rapList).each(function (idx, risk) {
                    if (risk.report_status == '결재요청') {
                        row01 += "<tr ondblclick='openPage(\"" + risk.risk_approval_key + "\")'>"
                        row01 += "<td>" + risk.text + "</td>"
                        row01 += "<td>" + risk.reporter + "</td>"
                        var formattedDate = new Date(risk.report_date).toLocaleDateString();
                        row01 += "<td>" + formattedDate + "</td>"
                        row01 += "<td>" + risk.report_status + "</td>"
                        row01 += "</tr>"

                        $("#myModal #uptBtn").show()
                        $("#myModal #detailBtn").hide()

                    } else if (risk.status == '결재전') {
                        row02 += "<tr ondblclick='openPage(\"" + risk.risk_approval_key + "\")'>"
                        row02 += "<td>" + risk.text + "</td>"
                        row02 += "<td>" + risk.reporter + "</td>"
                        var formattedDate = new Date(risk.report_date).toLocaleDateString();
                        row02 += "<td>" + formattedDate + "</td>"
                        row02 += "<td>" + risk.report_status + "</td>"
                        row02 += "</tr>"

                        $("#myModal #uptBtn").hide()
                        $("#myModal #detailBtn").show()
                    } else {
                        row03 += "<tr ondblclick='openPage(\"" + risk.risk_approval_key + "\")'>"
                        row03 += "<td>" + risk.text + "</td>"
                        row03 += "<td>" + risk.reporter + "</td>"
                        var formattedDate = new Date(risk.report_date).toLocaleDateString();
                        row03 += "<td>" + formattedDate + "</td>"
                        row03 += "<td>" + risk.report_status + "</td>"
                        row03 += "</tr>"

                        $("#myModal #uptBtn").hide()
                        $("#myModal #detailBtn").hide()
                    }
                })
                $("#taskTable01").html(row01)
                $("#taskTable02").html(row02)
                $("#taskTable03").html(row03)
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    function openPage(key){
        getApprovalInfo(key)
        $("#myModal").modal('show')
        $("#uptBtn").click(function (){
            approvalBefore(key);
        })
        $("#finBtn").click(function (){
            approvalFin(key)
        })
        $("#returnBtn").click(function(){
            $("#myModal02").modal('show')

            $("#regBtn").click(function (){
                if($("#modalFrm02 [name=reject_detail]").val().trim() == ''){
                    msg("error","!","공백란을 채워주세요")


                }else{
                    approvalReturn(key);
                }
            })
        })

    }


    function getApprovalInfo(key){
        $.ajax({
            url:"${path}/getApprovalInfo",
            data:"approval_key="+key,
            dataType:"json",
            success:function (data){
                var getApproval = data.getApproval;
                var getFname = data.getFname;
               $("#modalFrm [name=text]").val(getApproval.text)
                var formattedStartDate = new Date(getApproval.start_date).toLocaleDateString();
               $("#modalFrm [name=start_date]").val(formattedStartDate)
                var formattedEndDate = new Date(getApproval.end_date).toLocaleDateString();
               $("#modalFrm [name=end_date]").val(formattedEndDate)
                var formattedReqDate = new Date(getApproval.request_date).toLocaleDateString();
               $("#modalFrm [name=request_date]").val(formattedReqDate)
                $("#modalFrm [name=detail]").val(getApproval.detail)

                $("#fileList").empty();

                $(getFname).each(function(idx,fname){
                    var listItem = $("<ol></ol>").text(fname.fname).click(function (){
                        download(fname.file_key, fname.fname)
                    });
                    $("#fileList").append(listItem);
                })
            },
            error:function (err){
                console.log(err)
            }
        })
    }

    function download(file_key, fname){
        confirmMsg(
            fname,
            "다운로드 하시겠습니까?",
            "question", // 아이콘
            function() {
                $.ajax({
                    url: "${path}/download?file_key="+file_key+"&fname="+fname,
                    type: "POST",
                    success: function(response) {
                        msg("success", "파일 다운로드 성공!")
                    },
                    error: function(error) {
                        msg("error", "오류", error)
                    }
                })
            }
        );
    }
    // 상태 수정(결재전)
    function approvalBefore(key){
        confirmMsg(
            '',
            "상태를 수정 하시겠습니까?",
            "question", // 아이콘
            function() {
                $.ajax({
                    url: "${path}/approvalStatusBefore",
                    data:"approval_key="+key,
                    success: function(data) {
                        if(data.beforeMsg!=null){
                            msg("success", "수정 성공!",data.beforeMsg)
                        }
                        $("#clsBtn").click()
                        aplist();
                    },
                    error: function(error) {
                        msg("error", "오류", error)
                    }
                })
            }
        );
    }

    // 상태 수정(결재완료)
    function approvalFin(key){
        confirmMsg(
            '',
            "상태를 수정 하시겠습니까?",
            "question", // 아이콘
            function() {
                $.ajax({
                    url: "${path}/approvalStatusFin",
                    data:"approval_key="+key,
                    success: function(data) {
                        if(data.FinMsg!=null){
                            msg("success", "수정 성공!",data.FinMsg)
                        }
                        $("#clsBtn").click()
                        aplist();
                    },
                    error: function(error) {
                        msg("error", "오류", error)
                    }
                })
            }
        );
    }
    // 상태 수정(재상신)
    function approvalReturn(key){
        $("#modalFrm02 [name=approval_key]").val(key)
        confirmMsg(
            '',
            "상태를 수정 하시겠습니까?",
            "question", // 아이콘
            function() {
                $.ajax({
                    url: "${path}/approvalStatusReturn",
                    data:$("#modalFrm02").serialize(),
                    type:"post",
                    success: function(data) {
                        if(data.returnMsg!=null){
                            msg("success", "수정 성공!",data.returnMsg)
                        }
                        $("#clsBtn").click()
                        $("#clsBtn02").click()
                        aplist();
                    },
                    error: function(error) {
                        msg("error", "오류", error)
                    }
                })
            }
        );
    }
</script>

<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <!-- 확인 ㄴ -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">새로운 리스크 결재</h4>
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <thead>
                                <tr>
                                    <th>업무명</th>
                                    <th>보고자</th>
                                    <th>요청일</th>
                                    <th>처리상태</th>
                                </tr>
                                </thead>
                                <tbody id="taskTable01">
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 확인 ㄴ -->

            <!-- 확인 ㅇ 처리 ㄴ -->
            <div class="col-md-12" style="margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">처리전 리스크 결재</h4>
                        <!-- 완료된 프로젝트 테이블 -->
                        <div class="table-responsive" style="width: 95%; margin-left: 4%;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>업무명</th>
                                    <th>보고자</th>
                                    <th>요청일</th>
                                    <th>처리상태</th>
                                </tr>
                                </thead>
                                <tbody id="taskTable02">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 완료된 프로젝트 end -->

            <!-- 처리 ㅇ -->
            <div class="col-md-12" style="margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">처리완료 리스크 결재</h4>
                        <!-- 완료된 프로젝트 테이블 -->
                        <div class="table-responsive" style="width: 95%; margin-left: 4%;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>업무명</th>
                                    <th>보고자</th>
                                    <th>요청일</th>
                                    <th>처리상태</th>
                                </tr>
                                </thead>
                                <tbody id="taskTable03">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 완료된 프로젝트 end -->
        </div>
    </div>
</div>
</div>
</div>
</div>

<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h2 class="modal-title">Approval</h2>

                <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div style="display: flex;">
                    <h3 id=proTitle>결재 상세</h3>
                    <div class="btn-group" style="margin-left: 60%;" id="detailBtn">
                        <button type="button" class="btn btn-"
                                style="background-color: #007FFF; color: white;">결재 상세설정
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
                            <button class="dropdown-item" id="finBtn">결재 완료</button>
                            <button class="dropdown-item" id="returnBtn">재상신 요청</button>
                        </div>
                    </div>
                </div>

            </div>
            <form class="forms-sample" id="modalFrm">
                <input type="hidden" name="creater" value="${loginMem.member_key}"/>
                <div class="form-group">
                    <label for="exampleInputUsername1">업무 명</label>
                    <input
                            name="text" type="text" class="form-control" id=""
                            placeholder="title">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">업무 시작일</label>
                    <input type="text"
                           name="start_date" class="form-control" id=""
                           placeholder="teamName" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">업무 예상 종료일</label> <input
                        name="end_date" type="text" class="form-control" id=""
                        placeholder="startDate" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleInputConfirmPassword1">업무 보고일</label> <input
                        name="request_date" type="text" class="form-control" id=""
                        placeholder="endDate" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleInputConfirmPassword1">첨부 파일</label>
                    <ui id="fileList">

                    </ui>
                </div>
                <div class="form-group">
                    <label for="exampleTextarea1">상세설명</label>
                    <textarea class="form-control" id="" rows="4" name="detail"></textarea>
                </div>

            </form>
            <!-- Modal footer -->
            <div class="modal-footer">
                <div class="mx-auto">
                    <button type="button" class="btn btn-" id="uptBtn"
                            style="background-color: #007FFF; color: white;">업무확인
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"
                            id="clsBtn">닫기
                    </button>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- 재상신이유  -->
<div class="modal" id="myModal02">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">재상신</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <form id="modalFrm02">
                <input type="hidden" name="approval_key">
            <div class="modal-body">
                <div class="form-group">
                    <label for="exampleTextarea1">재상신요청 상세</label>
                    <textarea class="form-control" rows="4" name="reject_detail"></textarea>
                </div>
            </div>
            </form>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-" id="regBtn"
                        style="background-color: #007FFF; color: white;">재상신요청
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="clsBtn02">Close</button>
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

