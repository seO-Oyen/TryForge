<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="${path}/template/module/module_admain.jsp" flush="true"/>


<script>
    $(document).ready(function () {
        // 프로젝트 진행률(가로 막대바)
        const ctx = document.getElementById('projectPercent').getContext('2d');
        const myChart = new Chart(ctx, {
            type: 'horizontalBar',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 40, 3, 5, 2, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            },

        });

        // 가용인원
        const ctx02 = document.getElementById('ablePersonnel').getContext('2d');
        const myDoughnutChart = new Chart(ctx02, {
            type: 'doughnut',
            data: {
                labels: ['Red', 'Blue'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',

                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',

                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        // 올해 프로젝트 수주 차트 polarArea
        const ctx03 = document.getElementById('projectCnt').getContext('2d');
        const myPolarAreaChart = new Chart(ctx03, {
            type: 'polarArea',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)'

                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        // 리스크관리
        const ctx04 = document.getElementById('riskStatus').getContext('2d');
        const stackedBar = new Chart(ctx04, {
            type: 'bar',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [
                    {
                        label: 'Dataset 1',
                        data: [12, 19, 3, 5, 7, 10],
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Dataset 2',
                        data: [8, 12, 5, 8, 0, 0],
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    },
                    {
                        type: 'line', // 두 번째 데이터셋은 꺾은선 그래프로 지정
                        label: 'Dataset 3 (Line)',
                        data: [30, 50, 25, 33, 45, 22], // 꺾은선 그래프의 데이터
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 2,
                        fill: false
                    }
                ]
            },
            options: {
                scales: {
                    x: {
                        stacked: true
                    },
                    y: {
                        stacked: true,
                        max: 100,
                        ticks: {
                            stepSize: 5
                        }
                    }
                }
            }
        });
    });
</script>
<!-- 프로젝트 진행률 차트 -->
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="row">
                        <div class="col-md-6" style="flex: 0 0 40%; max-width: 35%;">
                            <div class="card-body">
                                <div style="display: flex;">
                                    <h4 class="card-title">ProjectPercent</h4>
                                    <canvas id="projectPercent" width="20" height="20"></canvas>
                                    <div class="table-responsive"
                                         style="overflow-x: visible; margin-left: 40%; margin-top: 10%;">
                                        <table class="table table-hover" style="width: 100%;">
                                            <thead>
                                            <tr>
                                                <th>진행중인 프로젝트</th>
                                                <th>1</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>2</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 프로젝트 진행률 end -->
        <!-- 가용인원 차트-->
        <div style="display: flex;">
            <div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 40%; max-width: 40%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Available Personnel</h4>
                        <canvas id="ablePersonnel" width="50" height="30"></canvas>
                        <!-- 간단한 수치를 나타내는 텍스트 -->
                        <div class="chart-info" style="margin-top: 20%;">
                            <p>Current Value: <span id="currentValue">42</span></p>
                        </div>
                    </div>
                </div>
            </div>
            <!--가용인원 차트 end-->
            <!-- 올해 프로젝트 차트 -->
            <div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 40%; max-width: 60%;">
                <div class="card">
                    <div class="card-body">
                        <div style="display: flex;">
                            <h4 class="card-title">project Counts</h4>
                            <canvas id="projectCnt" width="50" height="30"></canvas>
                            <div class="chart-info" style="position: absolute; bottom: 8%; left: 5%;">
                                <p>Current Value: <span id="currentValue02">42</span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- 올해 프로젝트 차트 end -->
        <!-- 리스크 현황 차트 -->
        <div class="row">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="row">
                        <div class="col-md-6" style="flex: 0 0 40%; max-width: 35%;">
                            <div class="card-body">
                                <div style="display: flex;">
                                    <h4 class="card-title" style="margin-right: 15px;">Risk Status</h4>
                                    <canvas id="riskStatus" width="20" height="20"></canvas>
                                    <div class="table-responsive"
                                         style="overflow-x: visible; margin-left: 40%; margin-top: 10%;">
                                        <table class="table table-hover" style="width: 100%;">
                                            <thead>
                                            <tr>
                                                <th>진행중인 프로젝트</th>
                                                <th>1</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>2</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 리스크 현황 end -->
    </div>
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h2 class="modal-title">New Task</h2>

                    <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div style="display: flex;">
                        <h3 id=>업무 할당</h3>
                        <span class="close">&times;</span>
                        <p>Clicked Bar Label: <span id="modalLabel"></span></p>
                        <p>Clicked Bar Value: <span id="modalValue"></span></p>s
                    </div>

                </div>



                <!-- Modal footer -->
                <div class="modal-footer">
                    <div class="mx-auto">
                        <button type="button" class="btn btn-" id="regBtn"
                                onclick="insTask()"
                                style="background-color: #007FFF; color: white;">할당
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

