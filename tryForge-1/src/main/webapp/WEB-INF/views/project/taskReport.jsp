<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<style>
	#reportAgainReasonBtn {
		margin-right: 10%;
	}
	.btn-fit-li {
		width: auto; /* 버튼 내용에 따라 자동 조정 */
		padding: 0 10px; /* 좌우 패딩으로 버튼 내부 여백 조정 */
		line-height: 25px; /* 버튼의 라인 높이를 li의 높이에 맞춤 */
		float: right; /* li 내에서 오른쪽 정렬 */
	}
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
	#taskNameInModal, #taskFileUploadInModal, #reportAgainNameInModal, #reportAgainDetailInModal {
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
</style>
<script>
	$(document).ready(function() {
		getMemberTaskList();
		getRejectApprovalList();
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
	function formatDate(date) {
		var date = new Date(date);
		var year = date.getFullYear();
		var month = ('0' + (date.getMonth() + 1)).slice(-2);
		var day = ('0' + date.getDate()).slice(-2);
		return year + '-' + month + '-' + day;
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
	function getRejectApprovalList() {
		$.ajax({
			url: "${path}/getRejectApprovalList",
			type: "GET",
			dataType: "json",
			success: function(response) {
				var reApproveListHtml = '';
				if (response.rejectList && response.rejectList.length > 0) {
					$.each(response.rejectList, function(index, reject) {
						var reportBtn = '';
						var startDateFormat = formatDate(reject.request_date);
						var endDateFormat = formatDate(reject.completion_date);
						reportBtn = '<button type="button" onclick="reportAgain(\'' + reject.approval_key + '\', \'' + reject.task.text + '\', \'' + reject.task.id + '\', \'' + reject.detail + '\')" class="btn btn-info" id="reportAgainBtn">재상신</button>';
						reportAgainReasonBtn = '<button type="button" onclick="reportAgainReason(\'' + reject.task.text + '\', \'' + reject.reject_detail + '\')" class="btn btn-danger" id="reportAgainReasonBtn">반려사유</button>';

						reApproveListHtml += '<tr class="member-row">' +
								'<td>' + reject.task.text + '</td>' +
								'<td>' + startDateFormat + '</td>' +
								'<td>' + endDateFormat + '</td>' +
								'<td>' + reject.task.assignor + '</td>' +
								'<td>' + reportAgainReasonBtn + reportBtn + '</td>' +
								'</tr>';
					});
				} else {
					reApproveListHtml = '<tr><td colspan="5">반려된 업무가 없습니다.</td></tr>';
				}
				$('#reApproveList').html(reApproveListHtml);
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

			<div class="col-md-12" style="margin-top: 3%;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">결재 반려함</h4>
						<div class="table-responsive"
							 style="width: 95%; margin-left: 4%; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
								<tr>
									<th>업무명</th>
									<th>결재요청일</th>
									<th>결재반려일</th>
									<th>결재자</th>
									<th></th>
								</tr>
								</thead>
								<tbody id="reApproveList"></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
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
								<button type="button" class="btn btn-success" id="reportAgainUploadBtn" style="float: left;">추가첨부</button>
								<input type="file" id="fileInput" name="files" multiple="multiple" style="display: none;" />
								<input type="file" id="fileInputAgain" name="files" multiple="multiple" style="display: none;" />
								<input type="hidden" name="member_key" id="memberKey" value="${loginMem.member_key}"/>
								<input type="hidden" name="project_key" id="projectKey" value="${projectMem.project_key}"/>
								<input type="hidden" name="task_key" id="taskKey"/>
								<input type="hidden" name="approval_key" id="approvalKey"/>
							</div>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-info" id="taskReportInModalBtn">보고</button>
							<button type="button" class="btn btn-info" id="taskReportAgainInModalBtn">재상신</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div class="modal fade" id="reportAgainReasonModal" tabindex="-1" role="dialog" aria-labelledby="reportAgainReasonModal" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="reportAgainReasonTitle">반려 사유</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
						<div class="modal-body">
							<!-- 업무 정보를 여기에 표시 -->
							<label for="reportAgainNameInModal">업무명</label>
							<textarea class="form-control" id="reportAgainNameInModal" rows="1" readonly></textarea>
							<label for="reportAgainDetailInModal" style="margin-top: 1.5%;">상세 반려사유</label>
							<textarea class="form-control" id="reportAgainDetailInModal" rows="12" readonly></textarea>
						</div>
						<div class="modal-footer" style="display: flex; justify-content: flex-end;">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
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
		$('#fileInput').val('').click();
	})
	$("#fileInput").on('change', function() {
		var fileList = this.files;
		var fileListDisplay = $('#taskFileUploadInModal');
		fileListDisplay.empty();

		for(var i = 0; i < fileList.length; i++) {
			fileListDisplay.append($('<li class="list-group-item">').text(fileList[i].name));
		}
	});
	$("#reportAgainUploadBtn").on('click', function(){
		$('#fileInputAgain').val('').click();
	});
	$("#fileInputAgain").on('change', function(){
		var fileList = this.files;
		var fileListDisplay = $('#taskFileUploadInModal');

		for(var i = 0; i < fileList.length; i++) {
			fileListDisplay.append($('<li class="list-group-item">').text(fileList[i].name));
		}
	})
	function taskReport(id, text){
		var fileListDisplay = $('#taskFileUploadInModal');
	 	$('#taskReportDetailInModal').val("");
		fileListDisplay.empty();

		fileListDisplay.append($('<li class="list-group-item">').text("첨부파일 없음"));
		$('#taskNameInModal').text(text);
		$('#taskKey').val(id);

		$('#reportAgainUploadBtn').hide();
		$('#uploadBtn').show();

		$('#taskReportInModalBtn').show();
		$('#taskReportAgainInModalBtn').hide();
		$('#taskReportModal').modal('show');
	}
	function reportAgainReason(text, reject_detail) {
		$('#reportAgainNameInModal').text(text);
		$('#reportAgainDetailInModal').text(reject_detail);

		$('#reportAgainReasonModal').modal('show');
	}
	function reportAgain(approvalKey, text, id, detail){
		$.ajax({
			url: "${path}/getRejectApprovalFileList?approval_key="+approvalKey,
			type: "GET",
			dataType: "json",
			success: function(response) {
				var fileListDisplay = $('#taskFileUploadInModal');
				fileListDisplay.empty();
				$('#taskReportDetailInModal').text("").text(detail);

				if (response.rejectFileList.length > 0) {
					$.each(response.rejectFileList, function(index, rejectFile) {
						if (rejectFile && rejectFile.fname) {
							// 첨부파일이 있을 경우
							var fname = rejectFile.fname;
							var file_key = rejectFile.file_key;

							var listItem = $('<li class="list-group-item"></li>')
									.attr('data-file_key', file_key) // 파일 고유 식별자 저장
									.text(fname);

							// 삭제 버튼을 listItem에 추가
							var deleteButton = $('<button type="button" class="btn btn-danger btn-fit-li" style="float: right;">삭제</button>')
									.click(function() {
										deleteFileInReportAgain(fname, file_key, approvalKey, text, id, detail);
									});
							listItem.append(deleteButton);

							fileListDisplay.append(listItem);
						}
					});
				} else {
					// 첨부파일이 없을 경우
					fileListDisplay.append($('<li class="list-group-item">').text("첨부파일 없음"));
				}
				$('#uploadBtn').hide();
				$('#reportAgainUploadBtn').show();

				$('#taskReportInModalBtn').hide();
				$('#taskReportAgainInModalBtn').show();
				$('#taskNameInModal').text(text);
				$('#taskKey').val(id);
				$('#approvalKey').val(approvalKey);

				$('#taskReportModal').modal('show');
			},
			error: function(error) {
				msg("error", "파일리스트 로딩 실패", error)
			}
		});
	}
	$('#taskReportInModalBtn').on('click', function(){
		var formData = new FormData();
		var files = $("#fileInput")[0].files;
		if($('#taskReportDetailInModal').val().trim()!=="") {
			confirmMsg(
					"업무 보고",
					"작성하신 내용으로 업무 보고 하시겠습니까?",
					"warning",
					function() {
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
								getRejectApprovalList();
							},
							error: function(error) {
								msg("error", "업무보고 에러", error.result)
							}
						})
					},
					function() {
					}
			);
		} else {
			msg("error", "경고!", "보고내용을 작성 하셔야 합니다.")
			return false;
		}
	})

	$('#taskReportAgainInModalBtn').on('click', function(){
		var formData = new FormData();
		var files = $("#fileInputAgain")[0].files;
		if($('#taskReportDetailInModal').val().trim()!=="") {
			confirmMsg(
					"업무 재상신",
					"작성하신 내용으로 재상신 하시겠습니까?",
					"warning",
					function() {
						$.each(files, function(index, file) {
							formData.append('files[]', file);
						})
						formData.append('description', '업무보고 파일');
						formData.append('detail', $("#taskReportDetailInModal").val());
						formData.append('member_key', $("#memberKey").val());
						formData.append('project_key', $("#projectKey").val());
						formData.append('task_key', $("#taskKey").val());
						formData.append('approval_key', $("#approvalKey").val());
						$.ajax({
							url: "${path}/reportTaskAgain",
							type: "POST",
							data: formData,
							cache: false,
							processData: false,
							contentType: false,
							success: function(response) {
								$('#taskReportModal').modal('hide');
								msg("success", "재상신 완료!", response.result)
								getMemberTaskList();
								getRejectApprovalList();
							},
							error: function(error) {
								msg("error", "업무보고 에러", error.result)
							}
						})
					},
					function() {
					}
			);
		} else {
			msg("error", "경고!", "보고내용을 작성 하셔야 합니다.")
			return false;
		}
	})

	function deleteFileInReportAgain(fname, file_key, approvalKey, text, id, detail) {
		confirmMsg(
				fname + " 삭제", // 제목
				"정말로 파일을 삭제하시겠습니까?", // 메시지 내용
				"warning", // 아이콘
				function() {
					$.ajax({
						url: "${path}/deleteFile?file_key="+file_key,
						type: "POST",
						success: function(response) {
							switch(response.result){
								case 0:
									msg("error", "파일삭제 실패", "파일 삭제에 실패했습니다.");
									break;
								case 1:
									msg("warning", "파일 부분삭제", "로컬파일만 삭제되었습니다.(관리자문의)");
									break;
								case 2:
									msg("success", "파일삭제 완료!", "성공적으로 파일을 삭제하였습니다.");
									$('li[data-file_key="' + file_key + '"]').remove();
									break;
								default:
									msg("info", "알 수 없는 응답", "관리자에게 문의하세요.")
							}

						},
						error: function(error) {
							msg("error", "오류", error)
						}
					})
				},
				function() {
				}
		);
	}
</script>

</body>

<!--
그다음 거기 안에서 재상신 버튼 클릭 시 기존 재상신 폼 -> 재상신 절차.. -->
</html>