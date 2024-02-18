<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${path}/template/module/module_admain.jsp" flush="true"/>
<style>
    #myModal .modal-dialog {
        max-width: 50%;
    }
</style>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "${path}/projectProgress",
            dataType: "json",
            success: function (pjdata) {
                var texts = [];
                var progresses = [];

                $(pjdata.pjprogress).each(function (idx, item) {
                    var row = "";
                    var startDate = new Date(item.start_date);
                    startDate.setDate(startDate.getDate() + 1);
                    var formattedStartDate = startDate.toISOString().split('T')[0];
                    var endDate = new Date(item.end_date);
                    endDate.setDate(endDate.getDate() + 1);
                    var formattedEndDate = endDate.toISOString().split('T')[0];
                    row += "<tr onclick='openPage(\"" + item.project_key + "\")'><td>" + item.text + "</td><td>" + Math.floor(item.progress * 100) + "%</td><td>" + formattedStartDate + "</td><td>" + formattedEndDate + "</td></tr>"
                    console.log(item.project_key)
                    $("#progress").append(row)
                    texts.push(item.text);
                    progresses.push(item.progress * 100);
                });
                // 프로젝트 진행률(가로 막대바)
                const ctx = document.getElementById('projectPercent').getContext('2d');
                const myChart = new Chart(ctx, {
                    type: 'horizontalBar',
                    data: {
                        labels: texts,
                        datasets: [{
                            label: '진행률',
                            data: progresses,
                            barPercentage: 0.25,
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
                            xAxes: [{
                                ticks: {
                                    suggestedMin: 0,
                                    suggestedMax: 100
                                }
                            }]
                        }
                    }

                });
            },
            error: function (err) {
                console.log(err)
            }
        })

        $.ajax({
            url: "${path}/ablePersonnel",
            dataType: "json",
            success: function (persondata) {
                var totMember = persondata.totMem
                var totTeamMember = persondata.totTeamMem
                $("#tot01").text(totMember)
                $("#tot02").text(totTeamMember)
                $("#tot03").text(totMember - totTeamMember)
                // 가용인원
                const ctx02 = document.getElementById('ablePersonnel').getContext('2d');
                const myDoughnutChart = new Chart(ctx02, {
                    type: 'doughnut',
                    data: {
                        labels: ['프로젝트 할당인원', '비 할당인원'],
                        datasets: [{
                            label: '# of Votes',
                            data: [totTeamMember, (totMember - totTeamMember)],
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
            },
            error: function (err) {
                console.log(err)
            }
        })

        // 올해 프로젝트 수주 차트 예약/진행중/완료
        $.ajax({
            url: "${path}/totProject",
            dataType: "json",
            success: function (totPJData) {
                var nowPj = totPJData.totOngoingPJ;
                var futurePj = totPJData.totWaitingPJ;
                var agoPj = totPJData.totCompletePJ;
                $("#pjCnt01").text(nowPj + futurePj + agoPj)
                $("#pjCnt02").text(nowPj)
                $("#pjCnt03").text(agoPj)
                $("#pjCnt04").text(futurePj)

                const ctx03 = document.getElementById('projectCnt').getContext('2d');
                const myPolarAreaChart = new Chart(ctx03, {
                    type: 'polarArea',
                    data: {
                        labels: ['진행중인 프로젝트', '대기중인 프로젝트', '완료 프로젝트'],
                        datasets: [{
                            label: '# of Votes',
                            data: [nowPj, futurePj, agoPj],
                            backgroundColor: [
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)'

                            ],
                            borderColor: [
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scale: {
                            ticks: {
                                suggestedMin: 0,
                                suggestedMax: nowPj + futurePj + agoPj
                            }
                        }
                    }
                });
            },
            error: function (err) {
                console.log(err)
            }
        })
        $.ajax({
            url: "${path}/RiskChart",
            dataType: "json",
            success: function (data) {
                const promises = [];
                const titleArr = [];
                const riskTotResults = [];
                const risk01TotResults = [];
                const risk02TotResults = [];

                data.gettitle.forEach(title => {
                    promises.push(
                        $.ajax({
                            url: "${path}/riskTot",
                            data: "title=" + title,
                            dataType: "json"
                        })
                            .then(result => {
                                titleArr.push(title);
                                riskTotResults.push(result.riskTot);
                                risk01TotResults.push(result.risk01Tot);
                                risk02TotResults.push(result.risk02Tot);
                                var row="";
                                row+="<tr>"
                                row+="<td>"+title+"</td>"
                                row+="<td>"+result.riskTot+"개</td>"
                                row+="<td>"+(result.riskTot - (result.risk01Tot+result.risk02Tot))+"개</td>"
                                row+="<td>"+result.risk02Tot+"개</td>"
                                row+="<td>"+result.risk02Tot+"개</td>"
                                row+="</tr>"
                                $("#riskTable").append(row)
                            })
                    );
                });

                Promise.all(promises).then(() => {
                    createChart(titleArr, riskTotResults, risk01TotResults, risk02TotResults);
                });
            },
            error: function (err) {
                console.log(err);
            }
        });

        function createChart(titleArr, riskTotResults, risk01TotResults, risk02TotResults) {
            // 리스크 차트 생성
            const ctx04 = document.getElementById('riskStatus').getContext('2d');
            const stackedBar = new Chart(ctx04, {
                type: 'bar',
                data: {
                    labels: titleArr,
                    datasets: [
                        {
                            label: '처리중 리스크',
                            data: risk01TotResults,
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        },
                        {
                            label: '처리완료 리스크',
                            data: risk02TotResults,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        },
                        {
                            type: 'line',
                            label: '총 리스크 갯수',
                            data: riskTotResults,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 2,
                            fill: false
                        }
                    ]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                suggestedMin: 0,
                                suggestedMax: 50
                            }
                        }]
                    }
                }
            });
        }

    })
    // 담당자별 업무 진척도
    function openPage(key){
        $.ajax({
            url: "${path}/ownerProgress",
            data: "project_key=" + key,
            dataType: "json",
            success: function (ownerdata) {
            	 console.log(ownerdata);  
                var ownerName=[];
                var ownerProgress=[];
                $(ownerdata.taskProgressBypeople).each(function (idx, item) {
                    console.log(item.owner)
                    console.log(item.progress * 100)
                    ownerName.push(item.owner);
                    ownerProgress.push(item.progress * 100);
                });
                const ctx05 = document.getElementById('ownerPercent').getContext('2d');
                const myChart = new Chart(ctx05, {
                    type: 'horizontalBar',
                    data: {
                        labels: ownerName,
                        datasets: [{
                            label: '# of Votes',
                            data: ownerProgress,
                            barPercentage: 0.25,
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
                            xAxes: [{
                                ticks: {
                                    suggestedMin: 0,
                                    suggestedMax: 100
                                }
                            }]
                        }
                    }

                });
            },
            error: function (err) {
                console.log(err)
            }
        })

        $("#myModal").modal('show')
    }
</script>

<!-- 프로젝트 진행률 차트 -->
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="row">
                        <div class="col-md-6" style="flex: 0 0 80%; max-width: 40%;">
                            <div class="card-body">
                                <div style="display: flex;">
                                    <h4 class="card-title">ProjectPercent</h4>
                                    <canvas id="projectPercent" width="60" height="45"></canvas>

                                    <div class="table-responsive"
                                         style="overflow-x: visible; margin-left: 30%; margin-top: 3%;">
                                        <table class="table table-hover" style="width: 100%;">
                                            <thead>
                                            <tr>
                                                <th>진행중인 프로젝트</th>
                                                <th>진행률</th>
                                                <th>시작일</th>
                                                <th>종료일</th>
                                            </tr>
                                            </thead>
                                            <tbody id="progress">

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
                        <div class="chart-info" style="margin-top: 8%;">
                            <p>총 구성원 : <span id="tot01"></span></p>
                            <p>프로젝트 할당인원 : <span id="tot02"></span></p>
                            <p>프로젝트 비 할당인원 : <span id="tot03"></span></p>
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
                                <p>총 프로젝트 갯수: <span id="pjCnt01"></span></p>
                                <p>진행중인 프로젝트: <span id="pjCnt02"></span></p>
                                <p>완료된 프로젝트 갯수: <span id="pjCnt03"></span></p>
                                <p>대기중인 프로젝트 갯수: <span id="pjCnt04"></span></p>
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
                                         style="overflow-x: visible; margin-left: 25%; margin-top: 0;">
                                        <table class="table table-hover" style="width: 100%;">
                                            <thead>
                                            <tr>
                                                <th>프로젝트 명</th>
                                                <th>리스크 총 갯수</th>
                                                <th>미발생 리스크</th>
                                                <th>발생(처리중) 리스크</th>
                                                <th>처리완료 리스크</th>
                                            </tr>
                                            </thead>
                                            <tbody id="riskTable">

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
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">담당자 별 업무 진척도</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <canvas id="ownerPercent" width="60" height="45"></canvas>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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