<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<style>

</style>
<script>
	$(document).ready(function() {
		// 현재 URL 가져오기
		var currentUrl = window.location.href;
		var urlParams = new URL(currentUrl).searchParams;
		var riskKey = urlParams.get('risk_key');
		var riskResponseKey = urlParams.get('risk_response_key');

		$('input[name="risk_key"]').val(riskKey);
		$('input[name="risk_response_key"]').val(riskResponseKey);

		$("#uploadFile").hide()

		$("#fileBtn").click(function(){
			$("#uploadFile").click();
		})
		$("#uploadFile").change(function() {
			fileUpload();
			var fileList = this.files;
			var fileListDisplay = $('#fileText');
			fileListDisplay.empty();

			for(var i = 0; i < fileList.length; i++) {
				$("#fileText").val(fileList[i].name);
			}
		});
		$("#regBtn").click(function(){
			if (!emptyCheck()) {
				return;
			}
			$.ajax({
				url:"${path}/insRiskApproval",
				type:"post",
				data:$("#form02").serialize(),
				dateType:"json",
				success:function (data){
					if(data.insMsg!=null) {
						Swal.fire({
							title: '결재 성공',
							text: data.insMsg,
							icon: 'success',
						}).then(function () {
							location.href = "${path}/riskApprovalList"
						});
					}
				},
				error:function (err){
					console.log(err)
				}
			})
		})

	})

	function fileUpload(){
		var formData = new FormData();
		var files = $("#uploadFile")[0].files;
		$.each(files, function(index, file) {
			formData.append('files[]', file);

		})
		formData.append('description', $("input[name='description']").val());
		formData.append('member_key', $("input[name='member_key']").val());
		formData.append('project_key', $("input[name='project_key']").val());
		console.log(formData.description)

		$.ajax({
			url: "${path}/upload",
			type: "POST",
			data: formData,
			cache: false,
			processData: false,
			contentType: false,
			success: function(response) {
				msg("success", "파일 업로드 성공!", response.msg)

			},
			error: function(error) {
				msg("error", "업로드에러", error)
			}
		})
	}

	function msg(icon, title, text) {
		Swal.fire({
			icon: icon,
			title: title,
			text: text,
		});
	}

	function emptyCheck() {
		var title = $("#modalFrm [name='title']").val();
		var detail = $("#modalFrm [name='report_detail']").val();

		if (title.trim() === "" || detail.trim() === "") {
			// Use SweetAlert2 for a more visually appealing alert
			Swal.fire({
				icon: 'warning',
				title: '입력 오류',
				text: '모든 입력칸을 채워주세요',
				confirmButtonColor: '#007FFF',
			});
			return false;
		}
		return true;
	}
</script>
<div class="col-12 grid-margin stretch-card"
	 style="max-width: 85%; flex: 0 0 95%;">

	<div class="card">
		<div class="card-body">
			<form class="forms-sample" method="post" id="form02">
				<input type="hidden" name="member_key" value="${loginMem.member_key}"/>
				<input type="hidden" name="project_key" value="${projectMem.project_key}"/>
				<input type="hidden" name="description" value="리스크 결재 보고 파일"/>
				<input type="hidden" name="risk_key" >
				<input type="hidden" name="risk_response_key">

				<div class="form-group">
					<label for="exampleInputName1">결재보고명</label>
					<input type="text" class="form-control" value="" name="title">
				</div>

				<div class="form-group">
					<label for="exampleInputEmail3">작성자</label>
					<input type="text" class="form-control" readonly value="${loginMem.member_name}"
						   id="exampleInputEmail3" placeholder="Name" name="reporter">
				</div>

				<div class="form-group">
					<label for="exampleInputName1">결재보고일</label>
					<input type="date" class="form-control" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />" readonly>
				</div>

				<div class="form-group">
					<label for="exampleInputName1">첨부파일</label>
					<button type="button" class="btn btn-info mr-2" id="fileBtn"
							style="background:#007FFF; width: 120px; height: 30px; margin-left: 15px; margin-bottom: 10px; text-align: center; line-height: 1px;">
						<span style="display: inline-block; width: 100%;">파일 등록</span>
					</button>
					<input type="text" class="form-control" id="fileText">
					<input type="file" class="form-control" id="uploadFile" name="files" multiple="multiple" >
				</div>

				<div class="form-group">
					<label for="exampleTextarea1">상세내용</label>
					<textarea class="form-control" id="noticeDetail" name="report_detail" rows="10"></textarea>
				</div>
				<button id="regBtn" type="button" class="btn btn-info mr-2" style="background:#007FFF;">등록</button>
				<button class="btn btn-light" id="mainBtn">조회페이지</button>
			</form>
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

