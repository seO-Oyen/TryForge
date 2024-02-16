<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<style>
	.card-title {
		font-size: 20px;
		font-weight: bold;
	}
	#taskFileUploadInModal {
		max-height: 105px;
		overflow-y: auto;
	}
	.modal-content {
		margin-top: 25%;
	}
	#taskNameInModal, #taskFileUploadInModal {
		background-color: white;
		color: black;
	}
	.table {
		width: 100%;
		border-collapse: collapse;
	}
	.form-control {
		border: 1px solid rgba(0, 0, 0, 0.25);
	}

	.table thead th {
		position: sticky;
		border-bottom: 1.5px solid #ddd;
	}

	.table tbody {
		display: block;
		max-height: 255px;
		overflow-y: auto;
	}

	/* 테이블 행과 셀 */
	.table tbody tr, .table thead tr {
		display: table;
		width: 100%;
		table-layout: fixed;
	}

	.table th, .table td {
		text-align: center;
		border-bottom: 1px solid #ddd;
	}
	.btn-info {
		color: #fff;
		background-color: #007fff;
		border-color : #007fff;
	}
	.btn-info:hover {
		color: #fff;
		background-color: #2c73ba;
		border-color : #296db0;
	}

#searchResults {
	height: 150px;
	overflow-y: auto;
}

</style>
<script>
	$(document).ready(function() {
		getMemberTaskList();
	})
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
	function getMemberTaskList() {
		$.ajax({
			url: "${path}/getMemberTaskList",
			type: "GET",
			dataType: "json",
			success: function(response) {
				var taskListHtml = '';
				if (response.taskList && response.taskList.length > 0) {
					$.each(response.taskList, function(index, task) {
						var reportBtn = '';
						var startDateFormat = task.start_date.split(' ')[0];
						var endDateFormat = task.end_date.split(' ')[0];
						reportBtn = '<button type="button" onclick="taskReport(\'' + task.id + '\', \'' + task.text + '\')" class="btn btn-info" id="TaskReportBtn">업무보고</button>';

						taskListHtml += '<tr class="member-row">' +
								'<td>' + task.text + '</td>' +
								'<td>' + startDateFormat + '</td>' +
								'<td>' + endDateFormat + '</td>' +
								'<td>' + task.assignor + '</td>' +
								'<td>' + reportBtn + '</td>' +
								'</tr>';
					});
				} else {
					taskListHtml = '<tr><td colspan="5">진행중인 업무가 없습니다.</td></tr>';
				}
				$('#memberTaskList').html(taskListHtml);
			},
			error: function(error) {
				msg("error", "파일리스트 로딩 실패", error)
			}
		});
	}
</script>
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<!-- 새 업무 -->
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">내 업무</h4>
						<!-- 새 업무 테이블 -->
						<div class="table-responsive"
							style="width: 95%; margin-left: 4%; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
									<tr>
										<th>업무명</th>
										<th>업무시작일</th>
										<th>업무종료일</th>
										<th>할당자</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="memberTaskList"></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<!-- 새 업무 end -->

			<!-- 결재 대기중 업무 -->
			<div class="col-md-12" style="margin-top: 3%;">
				<div class="card">
					<div class="card-body">
						<h3 class="card-title">결재 중</h3>
						<!-- 진행중인 업무 테이블 -->
						<div class="table-responsive"
							style="width: 95%; margin-left: 4%; max-height: 2000px; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
									<tr>
										<th>업무명</th>
										<th>업무시작일</th>
										<th>업무종료일</th>
										<th>업무상세</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								<!--
									<c:forEach var="tlist" items="${getTask}" varStatus="sts">
										<c:if
											test="${tlist.member_key == loginMem.member_key && tlist.confirm == 1}">

											<tr class="task-row" data-member-key="${tlist.id}" ondblclick="openDetail()">
												<td>${tlist.text}</td>
												<td>${tlist.start_date}</td>
												<td>${tlist.end_date}</td>
												<td>${tlist.assignor}</td>
												<td>
													<button type="button" class="btn btn-open"
														style="background-color: #007FFF; color: white;">
														리스크등록</button>
												</td>
											</tr>
										</c:if>
										<c:if test="${empty getTask}">
											<tr>
												<td>진행중인 업무가 없습니다.</td>
											</tr>
										</c:if>
									</c:forEach>
									-->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<!-- 결재 대기중 업무 -->
			<div class="col-md-12" style="margin-top: 3%;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">결재 완료</h4>
						<!-- 진행중인 업무 테이블 -->
						<div class="table-responsive"
							 style="width: 95%; margin-left: 4%; max-height: 2000px; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
								<tr>
									<th>업무명</th>
									<th>업무시작일</th>
									<th>업무종료일</th>
									<th>업무상세</th>
									<th></th>
								</tr>
								</thead>
								<tbody>
								<!--
									<c:forEach var="tlist" items="${getTask}" varStatus="sts">
										<c:if
											test="${tlist.member_key == loginMem.member_key && tlist.confirm == 1}">

											<tr class="task-row" data-member-key="${tlist.id}" ondblclick="openDetail()">
												<td>${tlist.text}</td>
												<td>${tlist.start_date}</td>
												<td>${tlist.end_date}</td>
												<td>${tlist.assignor}</td>
												<td>
													<button type="button" class="btn btn-open"
														style="background-color: #007FFF; color: white;">
														리스크등록</button>
												</td>
											</tr>
										</c:if>
										<c:if test="${empty getTask}">
											<tr>
												<td>진행중인 업무가 없습니다.</td>
											</tr>
										</c:if>
									</c:forEach>
									-->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- 진행중인 업무 end -->
		</div>


		<div class="modal fade" id="taskReportModal" tabindex="-1" role="dialog" aria-labelledby="taskReportModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="taskReportModalLabel">업무 보고</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form method="post" enctype="multipart/form-data" action="upload">
						<div class="modal-body">
							<!-- 업무 정보를 여기에 표시 -->
							<label for="taskNameInModal">업무명</label>
							<textarea class="form-control" id="taskNameInModal" rows="1" readonly></textarea>
							<label for="taskFileUploadInModal" style="margin-top: 1.5%;">첨부파일</label>
							<ul id="taskFileUploadInModal" class="list-group"></ul>
							<label for="taskReportDetailInModal" style="margin-top: 1.5%;">보고내용</label>
							<textarea class="form-control" id="taskReportDetailInModal" rows="12"></textarea>
						</div>
						<div class="modal-footer" style="display: flex; justify-content: flex-end;">
							<div class="flex-grow-1" style="flex: 1;">
								<button type="button" class="btn btn-success" id="uploadBtn" style="float: left;">파일첨부</button>
								<input type="file" id="fileInput" name="files" multiple="multiple" style="display: none;" />
								<input type="hidden" name="member_key" id="memberKey" value="${loginMem.member_key}"/>
								<input type="hidden" name="project_key" id="projectKey" value="${projectMem.project_key}"/>
								<input type="hidden" name="task_key" id="taskKey"/>
							</div>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-info" id="taskReportInModalBtn">보고</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div class="modal fade" id="fileModifyModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="fileModifyModalLabel">파일 설명</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="fileModifyForm">
							<div class="form-group">
								<label for="fileModifyName">선택한 파일</label>
								<textarea class="form-control" id="fileModifyName" rows="1" readonly></textarea>
								<label for="fileModifyDescription">설명</label>
								<textarea class="form-control" id="fileModifyDescription" name="description" rows="6" placeholder="수정내용을 입력하세요"></textarea>
								<input type="hidden" id="getFileKey" name="file_key" value=""/>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" id="cancelModifyBtn">취소</button>
						<button type="button" class="btn btn-info" id="modifyConfirm">수정</button>
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
<script>
	$("#uploadBtn").on('click', function(){
		$('#fileInput').click();
	})
	$("#fileInput").on('change', function() {
		var fileList = this.files;
		var fileListDisplay = $('#taskFileUploadInModal');
		fileListDisplay.empty();

		for(var i = 0; i < fileList.length; i++) {
			fileListDisplay.append($('<li class="list-group-item">').text(fileList[i].name));
		}
	});
	function taskReport(id, text){
		var fileListDisplay = $('#taskFileUploadInModal');
		fileListDisplay.empty();
		fileListDisplay.append($('<li class="list-group-item">').text("첨부파일 없음"));
		$('#taskNameInModal').text(text);
		$('#taskKey').val(id);
		$('#taskReportModal').modal('show');
	}
	$('#taskReportInModalBtn').on('click', function(){
		var formData = new FormData();
		var files = $("#fileInput")[0].files;

		$.each(files, function(index, file) {
			formData.append('files[]', file);
		})
		formData.append('description', '업무보고 파일')
		formData.append('detail', $("#taskReportDetailInModal").val());
		formData.append('member_key', $("#memberKey").val());
		formData.append('project_key', $("#projectKey").val());
		formData.append('task_key', $("#taskKey").val());
		$.ajax({
			url: "${path}/reportTask",
			type: "POST",
			data: formData,
			cache: false,
			processData: false,
			contentType: false,
			success: function(response) {
				$('#taskReportModal').modal('hide');
				msg("success", "업무보고 완료!", response.result)
				getMemberTaskList();
			},
			error: function(error) {
				msg("error", "업무보고 에러", error.result)
			}
		})
	})
</script>

</body>

</html>