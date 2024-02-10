<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="${path}/template/module/module_admain.jsp"
             flush="true"/>
<style>
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

    #searchResults {
        height: 150px;
        overflow-y: auto;
    }

    .text02 {
        border: 1px solid #f3f3f3;
        font-weight: 400;
        font-size: 0.875rem;
        height: 2.875rem
    }

    .detail02 {
        border: 1px solid #f3f3f3;
        font-weight: 400;
        font-size: 0.875rem;
        height: 2.875rem
    }

    #radioGroup {
        border: 1px solid #f3f3f3;
        font-weight: 400;
        font-size: 0.875rem;
        margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
        margin-left: 3%;

        padding: 10px; /* 내부 여백 추가 */
    }

    #radioGroup .form-check-label {
        margin-left: 20px;
    }

    #radioGroup .form-check-label:hover label {
        color: #7FBFFF;
    }

    #radioGroup .form-check-label:hover .check {
        border: 5px solid #7FBFFF;
    }

    #radioGroup input[type=radio]:checked ~ label {
        color: #7FBFFF;
    }

    #radioGroup input[type=radio]:checked {
        box-shadow: 0 0 0 1px #7FBFFF;
        border: 4px solid #fff;
        background: #7FBFFF;
    }

    #radioGroup input[type=radio] {

        appearance: none;
        width: 15px;
        height: 15px;
        box-shadow: 0 0 0 1px #fff;
        border: 3px solid #c7c7c7;
        border-radius: 50%;
        background-color: #fff;
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
        // 리스크 출력
        $.ajax({
            url: "${path}/AdriskList",
            data: "creater=" + "${loginMem.member_key}",
            dataType: "json",
            success: function (data) {
                var rlist = data.rlist;
                var row01 = "";
                var row02 = "";

                $(rlist).each(function (idx, item) {
                    if (item.confirm == 0) {
                        var formattedDate = new Date(item.reg_date).toLocaleDateString();
                        row01 += "<tr ondblclick=" +
                            "'riskRes(\"" + item.title + "\", \"" + item.text + "\", \"" + item.registrant + "\", \"" + formattedDate + "\"," +
                            " \"" + item.detail + "\", \"" + item.risk_key + "\", \"" + item.project_key + "\")'>";
                        row01 += "<td>" + item.title + "</td>"
                        row01 += "<td>" + item.text + "</td>"
                        row01 += "<td>" + item.registrant + "</td>"
                        row01 += "<td>" + formattedDate + "</td>"
                        row01 += "<td>" + item.type + "</td>"
                        row01 += "<td>" + item.possibility + "</td>"
                        row01 += "<td>" + item.priority + "순위 </td>"
                        row01 += "</tr>"
                    } else {
                        var formattedDate = new Date(item.reg_date).toLocaleDateString();
                        row02 += "<tr ondblclick='riskRes()'ss>"
                        row02 += "<td>" + item.title + "</td>"
                        row02 += "<td>" + item.text + "</td>"
                        row02 += "<td>" + item.registrant + "</td>"
                        row02 += "<td>" + formattedDate + "</td>"
                        row02 += "<td>" + item.type + "</td>"
                        row02 += "<td>" + item.possibility + "</td>"
                        row02 += "<td>" + item.priority + "순위 </td>"
                        row02 += "</tr>"
                    }
                })
                $("#newRisk").html(row01)
                $("#confirmRisk").html(row02)
            },
            error: function (err) {
                console.log(err)
            }
        })

        var totalTasks = 0;
        var task1 = 0;
        var task2 = 0;
        var task3 = 0;

        function drawChart() {
            var ratio1 = (task1 / totalTasks) * 100;
            var ratio2 = (task2 / totalTasks) * 100;
            var ratio3 = (task3 / totalTasks) * 100;

            var doughnutPieData = {
                labels: ["미확인", "진행중", "완료"],
                datasets: [{
                    data: [ratio1, ratio2, ratio3],
                    backgroundColor: ["#FFB6C1", "#4CA5FF", "#BDC3C7"],
                }]
            };

            var doughnutPieOptions = {
                responsive: true,
                animation: {
                    animateScale: true,
                    animateRotate: true
                }
            };

            if ($("#pieChart").length) {
                var pieChartCanvas = $("#pieChart").get(0).getContext("2d");
                var pieChart = new Chart(pieChartCanvas, {
                    type: 'pie',
                    data: doughnutPieData,
                    options: doughnutPieOptions
                });
            }
        }

        // Ajax 요청
        $.ajax({
            url: "${path}/taskChart",
            dataType: "json",
            success: function (data) {
                totalTasks = data.allCnt;
                task1 = data.unConfCnt;
                task2 = data.confCnt;
                task3 = data.finCnt;
                $("#task01").text(task1 + "개")
                $("#task02").text(task2 + "개")
                $("#task03").text(task3 + "개")

                drawChart();
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    function riskRes(title, text, registrant, regdate, detail, key, project_key) {
        $("#project_title").val(title)
        $("#task_text").val(text)
        $("#registrant").val(registrant)
        $("#myModal [name=risk_key]").val(key)
        $("#reg_date").val(regdate);
        $("#detail").val(detail)
        schMem(project_key)
        $("#myModal").modal('show')

        $("#regResBtn").click(function () {
            insRiskRes();
        })
    }

    function schMem(project_key) {
        $.ajax({
            url: "${path}/riskContactSch",
            data: "project_key=" + project_key,
            dataType: "json",
            success: function (data) {
                var radioGroup = $('#radioGroup');
                $(data.mlist).each(function (idx, member) {
                    var radioBtn = $('<input type="radio" class="form-check-input" name="contact" value="' + member.member_name + '">');
                    var label = $('<label class="form-check-label"></label>').text(member.member_name + "-" + member.role);

                    // 라디오 버튼과 라벨을 label 요소로 감싸서 radioGroup에 추가
                    var labelWrapper = $('<label class="form-check-label"></label>').append(radioBtn).append(label);
                    radioGroup.append(labelWrapper);
                    radioGroup.append('<br>'); // 줄 바꿈 추가
                });
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    function insRiskRes() {
        alert($("#modalFrm").serialize())
        $.ajax({
            url: "${path}/insertRiskResponse",
            data: $("#modalFrm").serialize(),
            dataType: "json",
            type: "post",
            success: function (data) {
                var insResMsg = data.insResMsg;
                if (insResMsg != null) {
                    alert(insResMsg);
                }
            },
            error: function (err) {
                console.log(err)
            }
        })
    }
</script>

<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <div class="top-wrap" style="display: flex; justify-content: space-between; width: 100%;">
                <!-- 업무 현황 -->
                <div class="col-lg-4 grid-margin stretch-card" style="padding-left: 0; width: 70%; padding-right: 0;">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">업무 현황</h4>
                            <canvas id="pieChart" style="margin-top: 50px;" ></canvas>
                        </div>
                    </div>
                </div>

                <!-- 업무 현황 -->
                <div class="col-lg-4 grid-margin stretch-card" style="padding-left: 0; width: 70%; padding-right: 0;">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">리스크 현황</h4>
                            <canvas id="pieChart02" ></canvas>
                        </div>
                    </div>
                </div>

                <div class="stretch-card-wrap" style="width: 30%; display: flex; flex-direction: column">
                    <!--미확인 업무-->
                    <div class="col-mg-4 grid-margin stretch-card" style="width: 100%;">
                        <div class="card">
                            <div class="card-body" style="width: 100%;">
                                <div class="d-flex align-items-center justify-content-between justify-content-md-center justify-content-xl-between flex-wrap mb-4">
                                    <div>
                                        <p class="mb-2 text-md-center text-lg-left">미확인업무</p>
                                        <h1 class="mb-0" id="task01"></h1>
                                    </div>
                                    <i class="mdi mdi-clipboard-outline icon-xl text-secondary"></i>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!--진행중인 업무-->
                    <div class="col-mg-4 grid-margin stretch-card" style="width: 100%;">
                        <div class="card">
                            <div class="card-body" style="width: 100%;">
                                <div
                                        class="d-flex align-items-center justify-content-between justify-content-md-center justify-content-xl-between flex-wrap mb-4">
                                    <div>
                                        <p class="mb-2 text-md-center text-lg-left">진행중인 업무</p>
                                        <h1 class="mb-0" id="task02"></h1>
                                    </div>
                                    <i class="mdi mdi-clipboard-text icon-xl text-secondary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--완료 업무-->
                    <div class="col-mg-4 grid-margin stretch-card" style="width: 100%;">
                        <div class="card">
                            <div class="card-body" style="width: 100%;">
                                <div
                                        class="d-flex align-items-center justify-content-between justify-content-md-center justify-content-xl-between flex-wrap mb-4">
                                    <div>
                                        <p class="mb-2 text-md-center text-lg-left">완료된 업무</p>
                                        <h1 class="mb-0" id="task03"></h1>
                                    </div>
                                    <i class="mdi mdi-clipboard-check icon-xl text-secondary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <!-- 리스크 -->
            <div class="col-md-12" style="margin-bottom: 20px; padding-right: 0; padding-left: 0">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">New Risk</h4>
                        <!-- 리스크 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트 명</th>
                                    <th>업무 명</th>
                                    <th>등록자</th>
                                    <th>등록일</th>
                                    <th>리스크 종류</th>
                                    <th>발생 가능성</th>
                                    <th>처리 우선순위</th>

                                </tr>
                                </thead>
                                <tbody id="newRisk">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 확인 완료 리스크 -->
            <div class="col-md-12" style="padding-right: 0; padding-left: 0">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Confirm Risk</h4>
                        <!-- 리스크 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트 명</th>
                                    <th>업무 명</th>
                                    <th>등록자</th>
                                    <th>등록일</th>
                                    <th>리스크 종류</th>
                                    <th>발생 가능성</th>
                                    <th>처리 우선순위</th>
                                </tr>
                                </thead>
                                <tbody id="confirmRisk">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 업무정보 모달창 -->
<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h2 class="modal-title">Risk Response</h2>

                <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div style="display: flex;">
                    <h3 id=proTitle>리스크 대응</h3>

                </div>

            </div>
            <form class="forms-sample" id="modalFrm">
                <input type="hidden" name="risk_key"/>

                <div class="form-group">
                    <label for="exampleInputUsername1">프로젝트 명</label>
                    <input name="project_title" type="text" readonly class="form-control" id="project_title"
                           placeholder="title">
                </div>

                <div class="form-group">
                    <label for="exampleInputUsername1">해당 업무 명</label>
                    <input name="task_title" type="text" readonly class="form-control" id="task_text"
                           placeholder="title">
                </div>

                <div class="form-group">
                    <label for="exampleInputPassword1">리스크 등록자</label> <input
                        name="start_date" type="text" readonly class="form-control" id="registrant"
                        placeholder="risk_registrant">
                </div>

                <div class="form-group">
                    <label for="exampleInputPassword1">리스크 등록일</label> <input
                        type="text" class="form-control" readonly id="reg_date" placeholder="reg_date">
                </div>


                <div class="form-group">
                    <label for="exampleTextarea1">상세설명</label>
                    <textarea class="form-control" readonly id="detail" rows="4"></textarea>
                </div>

                <div class="form-group">
                    <label for="exampleInputPassword1">구성원 선택</label>
                    <div id="radioGroup">
                        <div class="form-check">

                        </div>
                    </div>

                </div>
                <div class="form-group">
                    <label for="exampleTextarea1">대응방안</label>
                    <textarea class="form-control" id="" rows="4" name="response_method"></textarea>
                </div>

            </form>


            <!-- Modal footer -->
            <div class="modal-footer">
                <div class="mx-auto">
                    <button type="button" class="btn btn-" id="regResBtn"
                            style="background-color: #007FFF; color: white;">등록
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

