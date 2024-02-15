<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />

<script type="text/javascript">
	$(document).ready(function () {
		getFileList();

	});
	var userRole = "${loginMem.member_role}";
	var memberKey = ${loginMem.member_key};
	var creater = ${projectMem.creater};

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
<style>
	#fileModifyName {
		background-color: white;
		color: black;
		margin-bottom: 5%;
	}
	#fileDescriptionInModal {
		background-color: white;
		color: black;
	}
	#fileUploaderInModal {
		background-color: white;
		color: black;
	}
	#fileNameInModal {
		background-color: white;
		color: black;
	}
	.form-control {
		border: 1px solid rgba(0, 0, 0, 0.125);
	}
	#fileList {
		max-height: 105px;
		overflow-y: auto;
		margin-bottom: 10px;
	}
	.modal-content {
		height: 500px;
		margin-top: 25%;
	}
	.file-div {
		flex: 0 0 10%;
		max-width: 10%;
	}

	.file-image {
		flex: 6;
		margin-top: 20px;
		max-width: 60%;
		height: auto;
	}

	.fdel {
		flex: 2;
		font-size: 18px;
		height: 18px;
		max-width: 20%;
	  cursor: pointer;
		text-align: center;
  }
	.finfo {
		flex: 2;
		font-size: 18px;
		height: 18px;
		max-width: 20%;
		cursor: pointer;
		text-align: center;
  }
  .Nfdel {
	  width: 18px;
  }
  .file-title {
  	font-size: 14px;
  	text-align: center;
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-top: 0.5rem;
    margin-bottom: 0;
	  height: 100%;
  }
  .file-size{
  	font-size: 13px;
  	text-align: center;
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-bottom: 0;
	  margin-left: 18px;
    margin-top : 4px; 
    flex-grow: 1;
  }
  .fdown {
	font-size: 18px;
	cursor: pointer;
	margin-top : 4px;
  }
  .card .card-body {
    padding: 0.3em 0.3rem;
}
.file-info-container {
    display: flex;
    justify-content: space-between;
    align-items: center; 
    width: 100%;
}
  .image-and-delete-container {
	  display: flex; /* Flexbox 사용 */

	  width: 100%; /* 부모 요소의 전체 너비 사용 */
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

<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-xl-6 grid-margin stretch-card flex-column" style = "flex: 0 0 100%; max-width: 100%;">
			    <div class="d-flex justify-content-between mb-4 align-items-center">
			        <h5 class="mb-2 text-titlecase" style="font-size : 28px;">파일저장소</h5>
			        	<form method="post" enctype="multipart/form-data" action="upload">
			        		<button type="button" id="uploadBtn" class="btn btn-info">업로드</button>
			    			<input type="file" id="fileInput" name="files" multiple="multiple" style="display: none;" />
							<input type="hidden" name="member_key" value="${loginMem.member_key}"/>
							<input type="hidden" name="project_key" value="${projectMem.project_key}"/>
			    		</form>
			    </div>
				<div class="row" id="fileListContainer">
				</div>
			</div>
		</div>

<script type="text/javascript">
$("#uploadBtn").on('click', function(){
	$('#fileInput').click();
})
$("#fileInput").on('change', function() {
	var fileList = this.files;
	var fileListDisplay = $('#fileList');
	fileListDisplay.empty();

	for(var i = 0; i < fileList.length; i++) {
		fileListDisplay.append($('<li class="list-group-item">').text(fileList[i].name));
	}

	if(fileList.length > 0){
		$("#fileDescription").val("");
		$('#fileDescriptionModal').modal('show');
	}
});

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
			},
			function() {
			}
	);
}

function getFileList() {
	$.ajax({
		url: "${path}/getFileList", //
		type: "GET",
		dataType: "json",
		success: function(response) {
			var fileListHtml = '';
			$.each(response.fList, function(index, file) {
				var deleteButton = '';
				// 삭제 버튼 표시여부
				if (userRole === 'ADM' || memberKey === creater || memberKey === file.member_key) {
					deleteButton = '<i class="mdi mdi-close fdel" onclick="deleteFile(\'' + file.file_key + '\', \'' + file.fname + '\')"></i>';
				} else {
					deleteButton = '<i class="Nfdel"></i>'
				}
				fileListHtml += '<div class="col-md-6 grid-margin stretch-card file-div">' +
						'<div class="card">' +
						'<div class="card-body d-flex flex-column justify-content-between">' +
						'<div class="image-and-delete-container">' +
						deleteButton +
						'<img src="' + file.iconPath + '" alt ="' + file.ftype + '" class="file-image">' +
						'<i class="mdi mdi-information-outline finfo" onclick="infoFile(\'' + file.file_key + '\', \'' + file.member_key + '\', \'' + file.fname + '\')"></i>' +
						'</div>' +
						'<div><h4 title="' + file.fname + '" class="file-title">' + file.fname + '</h4></div>' +
						'<div class="file-info-container">' +
						'<h4 title="' + file.fsize + '" class="file-size">' + file.fsize + '</h4>' +
						'<i class="mdi mdi-download fdown" onclick="download(\'' + file.file_key + '\', \'' + file.fname + '\')"></i>' +
						'</div></div></div></div>';
			});
			$('#fileListContainer').html(fileListHtml);
		},
		error: function(error) {
			msg("error", "파일리스트 로딩 실패", error)
		}
	});
}

function deleteFile(file_key, fname){
	confirmMsg(
			fname + " 삭제", // 제목
			"정말로 파일을 삭제하시겠습니까?", // 메시지 내용
			"warning", // 아이콘
			function() {
				$.ajax({
					url: "${path}/deleteFile?file_key="+file_key,
					type: "POST",
					success: function(response) {
						$('#fileInfoModal').modal('hide');
						switch(response.result){
							case 0:
								msg("error", "파일삭제 실패", "파일 삭제에 실패했습니다.");
								break;
							case 1:
								msg("warning", "파일 부분삭제", "로컬파일만 삭제되었습니다.(관리자문의)");
								break;
							case 2:
								msg("success", "파일삭제 완료!", "성공적으로 파일을 삭제하였습니다.");
								break;
							default:
								msg("info", "알 수 없는 응답", "관리자에게 문의하세요.")
						}
					getFileList();
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

function modifyFile(file_key, fname) {
	$('#fileInfoModal').modal('hide');
	var fileDisplay = $('#fileModifyName');
	var fileDescription = $('#fileModifyDescription');

	fileDescription.empty();
	fileDisplay.empty();

	fileDisplay.append(fname);

	$('#getFileKey').val(file_key);
	$('#fileModifyModal').modal('show');

}

function infoFile(file_key, member_key, fname){
	$.ajax({
		url: "${path}/getFileDetail",
		type: "GET",
		dataType: "json",
		data: {
			file_key: file_key
		},
		success: function(response) {
			var uploaderName = response.detail.member_name;
			var fileDescription = response.detail.description;

			$('#fileNameInModal').text(fname);
			$('#fileUploaderInModal').text(uploaderName);
			$('#fileDescriptionInModal').text(fileDescription);

			if (userRole === 'ADM' || memberKey === creater || memberKey === parseInt(member_key)) {
				$("#modalDeleteBtn").show().on('click', function() {
					deleteFile(file_key, fname);
				});
				if	(memberKey === parseInt(member_key)) {
					$("#modalModifyBtn").show().on('click', function () {
						modifyFile(file_key, fname);
					});
				}
			} else {
				$("#modalDeleteBtn").hide()
				$("#modalModifyBtn").hide()
			}
			$('#fileInfoModal').modal('show');
		},
		error: function(error) {
			msg("error", "파일 상세정보 로딩 실패", error)
		}
	});
}
</script>
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

<div class="modal fade" id="fileDescriptionModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalLabel">파일 설명</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="fileUploadForm">
					<div class="form-group">
						<label>선택된 파일</label>
						<ul id="fileList" class="list-group"></ul>
						<label for="fileDescription">설명</label>
						<textarea class="form-control" id="fileDescription" name="fileDescription" rows="6" placeholder="파일 설명을 입력하세요"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-info" id="uploadDescription">업로드</button>
			</div>
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

<div class="modal fade" id="fileInfoModal" tabindex="-1" role="dialog" aria-labelledby="fileInfoModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileInfoModalLabel">파일 정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- 파일 정보를 여기에 표시 -->
				<label for="fileNameInModal">파일명</label>
				<textarea class="form-control" id="fileNameInModal" rows="1" readonly></textarea>
				<label for="fileUploaderInModal" style="margin-top: 3%;">업로더</label>
				<textarea class="form-control" id="fileUploaderInModal" rows="1" readonly></textarea>
				<label for="fileDescriptionInModal" style="margin-top: 3%;">설명</label>
				<textarea class="form-control" id="fileDescriptionInModal" rows="6" readonly></textarea>
			</div>
			<div class="modal-footer" style="display: flex; justify-content: flex-end;">
				<div class="flex-grow-1" style="flex: 1;">
					<button type="button" class="btn btn-danger" id="modalDeleteBtn" style="float: left;">삭제</button>
				</div>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-info" id="modalModifyBtn">수정</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$("#uploadDescription").on('click', function(){
		var formData = new FormData();
		var files = $("#fileInput")[0].files;
		var fileDescription = $("#fileDescription").val();

		$.each(files, function(index, file) {
			formData.append('files[]', file);
		})
		formData.append('description', fileDescription);
		formData.append('member_key', $("input[name='member_key']").val());
		formData.append('project_key', $("input[name='project_key']").val());

		$.ajax({
			url: "${path}/upload",
			type: "POST",
			data: formData,
			cache: false,
			processData: false,
			contentType: false,
			success: function(response) {
				$('#fileDescriptionModal').modal('hide');
				msg("success", "파일 업로드 성공!", response.msg)
				getFileList();
			},
			error: function(error) {
				msg("error", "업로드에러", error)
			}
		})
	});
	$("#cancelModifyBtn").on('click', function(){
		$('#fileModifyModal').modal('hide');
		$('#fileInfoModal').modal('show');
	})
	$("#modifyConfirm").on('click', function(){
		confirmMsg(
				"수정", // 제목
				"파일 설명을 수정하시겠습니까?", // 메시지 내용
				"warning", // 아이콘
				function() {
					$.ajax({
						url: "${path}/modifyFile",
						data:$('#fileModifyForm').serialize(),
						type: "POST",
						success: function(response) {
							$('#fileModifyModal').modal('hide');
							switch(response.result){
								case 0:
									msg("error", "수정 실패", "파일설명 수정이 실패했습니다.");
									break;
								case 1:
									msg("success", "수정 성공", "파일에 대한 설명이 수정되었습니다.");
									break;
								default:
									msg("info", "알 수 없는 응답", "관리자에게 문의하세요.")
							}
							getFileList();
						},
						error: function(error) {
							msg("error", "오류", error)
						}
					})
				},
				function() {
				}
		);
	});

</script>
</body>

</html>

