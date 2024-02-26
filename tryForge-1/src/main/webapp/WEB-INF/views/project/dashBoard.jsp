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
								<span style="float: left;">진행중 : <span id="tot01">${inCompleteTask}</span></span>
								<span style="float: right;">완료 : <span id="tot02">${completeTask}</span></span>
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
									<span style="float: left;"><span id="tot03">7</span>일</span>
									<span style="float: right;">D - <span id="tot04">50</span></span>
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
							<h4 class="card-title">프로젝트 경과일</h4>
							<canvas id="ablePersonnessld" width="50" height="30"></canvas>
							<!-- 간단한 수치를 나타내는 텍스트 -->
							<div class="chart-info" style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">
								<h3 style="display: inline-block; width: 65%;">
									<span style="float: left;"><span id="tot0s">7</span>일</span>
									<span style="float: right;">D - <span id="tot0s4">50</span></span>
								</h3>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div style="display: flex;">
			<div class="col-md-6 grid-margin stretch-card" style="height: 100%; flex: 0 0 70%; max-width: 70%; padding-left: 0;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">프로젝트 현황</h4>
						<canvas id="ablePersonneldd" width="50" height="30"></canvas>

						<div class="chart-info" style="position: absolute; top: 70%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">

						</div>
					</div>
				</div>
			</div>
		</div>

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