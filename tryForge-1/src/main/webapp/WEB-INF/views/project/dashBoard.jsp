<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<style>
	.card-title {
		font-weight: bold;
	}
</style>
<script>
	$(document).ready(function (){
		getComingSchedule();
		getTaskMem();
		const titleArr = ['1주', '2주', '3주', '4주', '5주', '6주', '7주', '8주', '9주', '10주', '11주', '12주', '13주']; // x축 라벨
		const riskTotResults = [1,2,3,4,5,6,7,8,9,10]; // 총 업무 개수
		const risk01TotResults = [5, 15, 25, 35]; // 진행중인 업무
		const risk02TotResults = [5, 10, 20, 30]; // 완료된 업무
		createChart(titleArr, riskTotResults, risk01TotResults, risk02TotResults);
	});

	function createChart(titleArr, riskTotResults, risk01TotResults, risk02TotResults) {
		const ctx = document.getElementById('projectStatus').getContext('2d');
		new Chart(ctx, {
			type: 'bar',
			data: {
				labels: titleArr,
				datasets: [{
					label: '진행중인 업무',
					data: risk01TotResults,
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					borderColor: 'rgba(255, 99, 132, 1)',
					borderWidth: 1
				},
					{
						label: '완료된 업무',
						data: risk02TotResults,
						backgroundColor: 'rgba(54, 162, 235, 0.2)',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 1
					},
					{
						type: 'line',
						label: '총 업무 개수',
						data: riskTotResults,
						borderColor: 'rgba(75, 192, 192, 1)',
						borderWidth: 2,
						fill: false
					}
				]
			},
			options: {
				plugins: {
					title: {
						text: 'Chart.js Combo Time Scale',
						display: true
					}
				},
				scales: {
					xAxes: {
						type: 'time',
						display: true,
						offset: true,
						ticks: {
							source: 'data'
						},
						time: {
							unit: 'week'
						},
					},
					yAxes: [{
						ticks: {
							suggestedMin: 0,
							suggestedMax: 100
						}
					}]
				},
			},
		});
	}

	function getComingSchedule() {
		$.ajax({
			url: "${path}/getComingSchedule",
			type: "GET",
			dataType: "json",
			success: function(response) {
				var scheduleListHtml = '';
				if (response.scheduleList && response.scheduleList.length > 0) {
					$.each(response.scheduleList, function(index, schedule) {
						var startDateFormat = schedule.start.split(' ')[0];
						scheduleListHtml += '<tr>' +
								'<td>' + startDateFormat + '</td>' +
								'<td>' + schedule.title + '</td>' +
								'</tr>';
					});
				} else {
					scheduleListHtml = '<tr><td colspan="5">일정이 없습니다.</td></tr>';
				}
				$('#comingSchedule').html(scheduleListHtml);
			},
			error: function(error) {
				msg("error", "일정 로딩 실패", error)
			}
		});
	}
	function getTaskMem() {
		$.ajax({
			url: "${path}/getTaskMem",
			type: "GET",
			dataType: "json",
			success: function(response) {
				var memberListHtml = '';
				if (response.memberList && response.memberList.length > 0) {
					$.each(response.memberList, function(index, member) {
						memberListHtml += '<tr>' +
								'<td>' + member.owner + '</td>' +
								'</tr>';
					});
				} else {
					memberListHtml = '<tr><td colspan="5">구성원이 없습니다.</td></tr>';
				}
				$('#memberList').html(memberListHtml);
			},
			error: function(error) {
				msg("error", "구성원 로딩 실패", error)
			}
		});
	}
</script>
<div class="main-panel">
	<div class="content-wrapper">
		<div style="display: flex;">
			<div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 30%; max-width: 30%; padding-left: 0;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">총 업무</h4>
						<canvas id="ablePersonnel" width="50" height="30"></canvas>

						<div class="chart-info" style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">
							<h3 style="display: inline-block; width: 75%;">
								<span style="float: left;">진행중 : <span>${inCompleteTask}</span></span>
								<span style="float: right;">완료 : <span>${completeTask}</span></span>
							</h3>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 15%; max-width: 15%;">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
							<h4 class="card-title">진척도</h4>
							<canvas id="projectCnt" width="50" height="30"></canvas>
							<div class="chart-info" style="position: absolute; top: 65%; left: 50%; transform: translate(-50%, -50%);">
								<h2>${projectProgress}%</h2>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 25%; max-width: 25%;">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
							<h4 class="card-title">프로젝트 경과일</h4>
							<canvas id="ablePersonneld" width="50" height="30"></canvas>
							<!-- 간단한 수치를 나타내는 텍스트 -->
							<div class="chart-info" style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">
								<h3 style="display: inline-block; width: 65%;">
									<span style="float: left;"><span>${projectElapsedDate}</span>&nbsp;일</span>
									<span style="float: right;">D - <span>${projectDday}</span></span>
								</h3>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 30%; max-width: 30%;">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
							<h4 class="card-title">프로젝트 종료일</h4>
							<canvas id="ablePersonnessld" width="50" height="30"></canvas>
							<!-- 간단한 수치를 나타내는 텍스트 -->
							<div class="chart-info" style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">
								<h3 style="display: inline-block; width: 65%;">
									<span><span>${projectEndDate}</span></span>
								</h3>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div style="display: flex;">
			<div class="col-md-6 grid-margin stretch-card" style="height: 70%; flex: 0 0 70%; max-width: 70%; padding-left: 0;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">프로젝트 현황</h4>
						<canvas id="projectStatus"></canvas>
					</div>
				</div>
			</div>
			<div class="col-md-6 grid-margin stretch-card" style="height: 100%; flex: 0 0 30%; max-width: 30%; flex-direction: column; margin-bottom: 0;">
				<!--미확인 업무-->
				<div class="col-mg-4 grid-margin stretch-card" style="width: 100%;">
					<div class="card">
						<div class="card-body" style="width: 100%; height: 259px;">
							<h4 class="card-title">다가오는 일정</h4>
							<div class="table-responsive" style="max-height: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
								<table class="table table-hover" style="width: 100%;">
									<thead>
									</thead>
									<tbody id="comingSchedule"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!--진행중인 업무-->
				<div class="col-mg-4 grid-margin stretch-card" style="width: 100%;">
					<div class="card">
						<div class="card-body" style="width: 100%; height: 259px;">
							<h4 class="card-title">프로젝트 구성원</h4>
							<div class="table-responsive" style="max-height: 180px; overflow-x: hidden; text-overflow: ellipsis; white-space: nowrap;">
								<table class="table table-hover" style="width: 100%;">
									<thead></thead>
									<tbody id="memberList"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--
		<div style="display: flex;">
			<div class="col-md-6 grid-margin stretch-card" style="flex: 0 0 100%; max-width: 100%; padding-left: 0; margin-bottom: 0;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">다가오는 일정</h4>
						<canvas id="ablePersonnel" width="50" height="30"></canvas>

						<div class="chart-info" style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">
							<h3 style="display: inline-block; width: 75%;">
								<span style="float: left;">진행중 : <span id="tot01">${inCompleteTask}</span></span>
								<span style="float: right;">완료 : <span id="tot02">${completeTask}</span></span>
							</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
		-->
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