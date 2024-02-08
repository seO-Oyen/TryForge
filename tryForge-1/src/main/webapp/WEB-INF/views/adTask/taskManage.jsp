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
</style>
<script>
    $(document).ready(function () {
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
                $("#task01").text(task1+"개")
                $("#task02").text(task2+"개")
                $("#task03").text(task3+"개")

                drawChart();
            },
            error: function (err) {
                console.log(err);
            }
        });
    });
</script>

<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <div style="display: flex; margin-left: 3%;" >
            <!-- 업무 현황 -->
            <div class="col-lg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">업무 현황</h4>
                        <canvas id="pieChart"></canvas>
                    </div>
                </div>
            </div>
            <!--미확인 업무-->
            <div class="col-mg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between justify-content-md-center justify-content-xl-between flex-wrap mb-4">
                            <div>
                                <p class="mb-2 text-md-center text-lg-left">미확인업무</p>
                                <h1 class="mb-0" id="task01"></h1>
                            </div>
                            <i class="mdi mdi-clipboard-outline icon-xl text-secondary"></i>
                        </div>
                        <canvas id="expense-chart" height="80"></canvas>
                    </div>
                </div>
            </div>
            <!--진행중인 업무-->
            <div class="col-mg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div
                                class="d-flex align-items-center justify-content-between justify-content-md-center justify-content-xl-between flex-wrap mb-4">
                            <div>
                                <p class="mb-2 text-md-center text-lg-left">진행중인 업무</p>
                                <h1 class="mb-0" id="task02"></h1>
                            </div>
                            <i class="mdi mdi-clipboard-text icon-xl text-secondary"></i>
                        </div>
                        <canvas id="budget-chart" height="80" style="visibility: hidden;"></canvas>
                    </div>
                </div>
            </div>
            <!--완료 업무-->
            <div class="col-mg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div
                                class="d-flex align-items-center justify-content-between justify-content-md-center justify-content-xl-between flex-wrap mb-4">
                            <div>
                                <p class="mb-2 text-md-center text-lg-left">완료된 업무</p>
                                <h1 class="mb-0" id="task03"></h1>
                            </div>
                            <i class="mdi mdi-clipboard-check icon-xl text-secondary"></i>
                        </div>
                        <canvas id="balance-chart" height="80"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</div>


<!-- 업무정보 모달창 -->
<div class="modal fade" id="myModal02" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <!-- modal-lg를 사용하거나 원하는 크기를 직접 지정할 수 있습니다. -->
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h2 class="modal-title">Task Information</h2>

                <button type="button" class="close" data-dismiss="modal" id="xBtn02">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div style="display: flex;">
                    <h3 id=proTitle>업무 확인</h3>

                </div>

            </div>
            <form class="forms-sample" id="modalFrm02">
                <input type="hidden" name="member_key"/> <input type="hidden"
                                                                name="project_key"/>
                <div class="form-group" style="width: 80%; margin-left: 10%;">
                    <label for="exampleInputUsername1">이름</label> <input
                        name="member_name" readonly type="text" class="form-control"
                        id="mname" placeholder="member name">
                </div>

                <div class="table-responsive"
                     style="width: 95%; margin-left: 4%; max-height: 2000px; overflow-x: auto;">
                    <table class="table table-hover" style="width: 100%;">
                        <thead>
                        <tr>
                            <th>업무이름</th>
                            <th>업무설명</th>
                            <th>진행상태</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody id="taskTable">
                        </tbody>
                    </table>
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

