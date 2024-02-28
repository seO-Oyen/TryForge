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
		var currentUrl = window.location.href;
		var urlParams = new URL(currentUrl).searchParams;
		var riskKey = urlParams.get('risk_key');
		var riskResponseKey = urlParams.get('risk_response_key');
		var isResubmit = urlParams.get('isResubmit');
		var RiskApprovalKey = urlParams.get('risk_approval_key');
		console.log("리스크키"+riskKey)
		console.log("리스크대응키"+riskResponseKey)
		console.log("리스크결재키"+RiskApprovalKey)
		
		$('input[name="risk_key"]').val(riskKey);
		$('input[name="risk_response_key"]').val(riskResponseKey);
		$('input[name="risk_approval_key"]').val(RiskApprovalKey);

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
		
		if(isResubmit == "true"){
			getApproval(RiskApprovalKey);
			$("#regBtn").click(function(){
				if (!emptyCheck()) {
					return;
				}else{
					reRiskApproval();
				}
			})
		}else{
			$("#regBtn").click(function(){
				if (!emptyCheck()) {
					return;
				}else{
					insRiskApproval();
				}
			})
		}
	})
	
	function msg(icon, title, text) {
		Swal.fire({
			icon: icon,
			title: title,
			text: text,
		});
	}
	
	function insRiskApproval(){
		var formData = new FormData();
		var files = $("#uploadFile")[0].files;
		$.each(files, function(index, file) {
			formData.append('files[]', file);
		})
		console.log( $("#Detail0003").val())
		formData.append('description', $('input[name="description"]').val());
		formData.append('member_key', $('input[name="member_key"]').val());
		formData.append('project_key', $('input[name="project_key"]').val());
		formData.append('title', $('input[name="title"]').val());
		formData.append('reporter', $('input[name="reporter"]').val());
		formData.append('report_detail', $("#Detail0003").val());
		formData.append('risk_key', $('input[name="risk_key"]').val());
		formData.append('risk_response_key', $('input[name="risk_response_key"]').val());

		console.log(formData.reporter)
		$.ajax({
			url:"${path}/insRiskApproval",
			type:"post",
			data: formData ,
			dataType:"json",
			cache: false,
			processData: false,
			contentType: false,
			success:function (data){
				if(data.result!=null) {
					Swal.fire({
						title: '결재 성공',
						text: data.result,
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
	}
	
	function fileUpload(){
		// var formData = new FormData();
		// var files = $("#uploadFile")[0].files;
		// $.each(files, function(index, file) {
		// 	formData.append('files[]', file);
		//
		// })
		// formData.append('description', $("input[name='description']").val());
		// formData.append('member_key', $("input[name='member_key']").val());
		// formData.append('project_key', $("input[name='project_key']").val());
		// formData.append('title', $("#form2 [name=title]").val());
		// formData.append('reporter', $("#form2 [name=reporter]").val());
		// formData.append('report_detail', $("#form2 [name=report_detail]").val());

		// console.log($("[name=description]").val())
		// console.log(formData.get('description'));

	}

	
	function emptyCheck() {
		var title = $("#form02 [name='title']").val();
		var detail = $("#form02 [name='report_detail']").val();
		var fileText = $("#fileText").val();

		if (title.trim() === "" || detail.trim() === "" || fileText.trim() === "") {
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
	
	function getApproval(key){
		$.ajax({
			url:"${path}/getRiskApprovalByrakey",
			data:"risk_approval_key="+key,
			dataType:"json",
			success:function(data){
				var approvalData = data.getRiskApproval
				console.log(approvalData.title)
				$("#form02 [name=title]").val("[재상신]"+approvalData.title)
				$("#form02 [name=report_detail]").val(approvalData.report_detail)
			},
			error:function(err){
				console.log(err)
			}
		})
	}
	
	function reRiskApproval(){
		var formData = new FormData();
		var files = $("#uploadFile")[0].files;
		$.each(files, function(index, file) {
			formData.append('files[]', file);
		})
		console.log( $("#Detail0003").val())
		formData.append('description', $('input[name="description"]').val());
		formData.append('member_key', $('input[name="member_key"]').val());
		formData.append('project_key', $('input[name="project_key"]').val());
		formData.append('title', $('input[name="title"]').val());
		formData.append('report_detail', $("#Detail0003").val());
		formData.append('risk_approval_key', $('input[name="risk_approval_key"]').val());
		$.ajax({
			url:"${path}/reRiskApproval",
			data:formData,
			dataType:"json",
			type:"post",
			cache: false,
			processData: false,
			contentType: false,
			success:function(data){
				if(data.result!=null) {
					Swal.fire({
						title: '결재 성공',
						text: data.result,
						icon: 'success',
					}).then(function () {
						location.href = "${path}/riskApprovalList"
					});
				}
			},
			error:function(err){
				console.log(err)
			}
		})
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
				<input type="hidden" name="risk_approval_key">
				<div class="form-group">
					<label for="exampleInputName1">결재보고명</label>
					<p style="color: red;">*필수 입력란</p>
					<input type="text" class="form-control" value="" name="title"/>
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
					<p style="color: red;">* 파일등록은 필수입니다</p>
					<input type="text" class="form-control" id="fileText">
					<input type="file" class="form-control" id="uploadFile" name="files" multiple="multiple" >
				</div>

				<div class="form-group">
					<label for="exampleTextarea1">상세내용</label>
					<p style="color: red;">*필수 입력란</p>
					<textarea class="form-control" id="Detail0003" name="report_detail" rows="10"></textarea>
				</div>
				<button id="regBtn" type="button" class="btn btn-info mr-2" style="background:#007FFF;">등록</button>
				<button class="btn btn-light" id="mainBtn" onclick="location.href='${path}/riskApprovalList'">조회페이지</button>
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

