<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
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
#radioGroup {
	border: 1px solid #f3f3f3;
	font-weight: 400;
	font-size: 0.875rem;
	margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
	margin-left: 3%;

	padding: 10px; /* 내부 여백 추가 */
}

</style>
<script>
	$(document).ready(function() {
		// 리스크 출력
		$.ajax({
			url: "${path}/riskList",
			data: "project_key=" + "${projectMem.project_key}",
			dataType: "json",
			success: function (data) {
				var rlist = data.rlist;
				var row01 = "";
				var row02 = "";
				var row03 = "";
				$(rlist).each(function (idx, item) {
					if (item.confirm == 0) {
						var formattedDate = new Date(item.reg_date).toLocaleDateString();
						row01 += "<tr ondblclick=" +
								"'riskInfo(\"" + item.title + "\", \"" + item.text + "\", \"" + item.registrant + "\", \"" + formattedDate + "\"," +
								" \"" + item.detail + "\", \"" + item.risk_key + "\", \"" + item.project_key + "\")'>";
						row01 += "<td>" + item.title + "</td>"
						row01 += "<td>" + item.text + "</td>"
						row01 += "<td>" + item.registrant + "</td>"
						row01 += "<td>" + formattedDate + "</td>"
						row01 += "<td>" + item.type + "</td>"
						row01 += "<td>" + item.possibility + "</td>"
						row01 += "<td>" + item.priority + "순위 </td>"
						row01 += "</tr>"
					} else {
						var formattedDate = new Date(item.reg_date).toLocaleDateString();
						row02 += "<tr ondblclick='getRiskResponse(\"" + item.title + "\", \"" + item.text + "\", \"" + item.registrant + "\", \"" + formattedDate + "\"," +
								" \"" + item.detail + "\", \"" + item.risk_key + "\")'>"
						row02 += "<td>" + item.title + "</td>"
						row02 += "<td>" + item.text + "</td>"
						row02 += "<td>" + item.registrant + "</td>"
						row02 += "<td>" + formattedDate + "</td>"
						row02 += "<td>" + item.type + "</td>"
						row02 += "<td>" + item.possibility + "</td>"
						row02 += "<td>" + item.priority + "순위 </td>"
						row02 += "</tr>"
					}

					if(item.contact == "${loginMem.member_name}"){
						var formattedDate = new Date(item.reg_date).toLocaleDateString();
						row03 += "<tr ondblclick='getRiskResponse(\"" + item.title + "\", \"" + item.text + "\", \"" + item.registrant + "\", \"" + formattedDate + "\"," +
								" \"" + item.detail + "\", \"" + item.risk_key + "\")'>"
						row03 += "<td>" + item.title + "</td>"
						row03 += "<td>" + item.text + "</td>"
						row03 += "<td>" + item.registrant + "</td>"
						row03 += "<td>" + formattedDate + "</td>"
						row03 += "<td>" + item.type + "</td>"
						row03 += "<td>" + item.possibility + "</td>"
						row03 += "<td>" + item.priority + "순위 </td>"
						row03 += "</tr>"
					}
				})
				$("#newRisk").html(row01)
				$("#confirmRisk").html(row02)
				$("#contactRisk").html(row03)
			},
			error: function (err) {
				console.log(err)
			}
		})

	})

	function riskInfo(title, text, registrant, regdate, detail, key, project_key) {
		$("#project_title").val(title)
		$("#task_text").val(text)
		$("#registrant").val(registrant)
		$("#myModal [name=risk_key]").val(key)
		$("#reg_date").val(regdate);
		$("#detail").val(detail)

		$("#risk_status_label").hide();
		$("#risk_status").hide();
		$("#myModal").modal('show')

		$("#regResBtn").show()
		$("#appRiskBtn").hide()
		$("#div01").hide()
		$("#riskHeader").text("Risk Information")
		$("#riskTitle").text("리스크 등록정보")

	}

	function getRiskResponse(title, text, registrant, regdate, detail, key){
		$("#project_title").val(title)
		$("#task_text").val(text)
		$("#registrant").val(registrant)
		$("#reg_date").val(regdate);
		$("#detail").val(detail)
		$("[name=risk_key]").val(key)
		$.ajax({
			url:"${path}/RiskResponseInfo",
			data:"risk_key="+key,
			dataType:"json",
			success:function (data){
				var resInfo = data.RiskResponseInfo;
				console.log(resInfo)
				console.log(resInfo.response_method)
				console.log(resInfo.contact)
				$("#contactLabel").text("담당자 확인")
				$("[name=response_method]").val(resInfo.response_method)
				$("[name=status]").val(resInfo.status)
				$("[name=risk_response_key]").val(resInfo.risk_response_key)
				$("#radioGroup").empty().text(resInfo.contact)
				$("[name=contact]").val(resInfo.contact)
				$("[name=strategy]").val(resInfo.strategy)
				$("#risk_status_label").show();
				$("#risk_status").show();
				if(resInfo.contact=="${loginMem.member_name}"){
					$("#appRiskBtn").show();
				}else{
					$("#appRiskBtn").hide()
				}
				$("#div01").show()
				$("#riskHeader").text("Risk Response")
				$("#riskTitle").text("리스크 대응정보")
				$("#myModal").modal('show')

			},
			error:function(err){
				console.log(err)
			}
		})
	}


</script>
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<!-- 리스크 -->
			<div class="col-md-12" style="margin-bottom: 20px; padding-right: 0; padding-left: 0">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">New Risk</h4>
						<!-- 리스크 테이블 -->
						<div class="table-responsive"
							 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
								<tr>
									<th>프로젝트 명</th>
									<th>업무 명</th>
									<th>등록자</th>
									<th>등록일</th>
									<th>리스크 종류</th>
									<th>발생 가능성</th>
									<th>처리 우선순위</th>

								</tr>
								</thead>
								<tbody id="newRisk">

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- 확인 완료 리스크 -->
			<div class="col-md-12" style="padding-right: 0; padding-left: 0; margin-bottom: 20px;">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">Confirm Risk</h4>
						<!-- 리스크 테이블 -->
						<div class="table-responsive"
							 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
								<tr>
									<th>프로젝트 명</th>
									<th>업무 명</th>
									<th>등록자</th>
									<th>등록일</th>
									<th>리스크 종류</th>
									<th>발생 가능성</th>
									<th>처리 우선순위</th>
								</tr>
								</thead>
								<tbody id="confirmRisk">

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<!-- 확인 완료 리스크 -->
			<div class="col-md-12" style="padding-right: 0; padding-left: 0">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
						<h4 class="card-title">Contact Risk</h4>
							<a href="${path}/riskApprovalList" style="margin-left: 75%; font-size: 20px;">리스크 결재 페이지 이동</a>
						</div>
						<!-- 리스크 테이블 -->
						<div class="table-responsive"
							 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
							<table class="table table-hover" style="width: 100%;">
								<thead>
								<tr>
									<th>프로젝트 명</th>
									<th>업무 명</th>
									<th>등록자</th>
									<th>등록일</th>
									<th>리스크 종류</th>
									<th>발생 가능성</th>
									<th>처리 우선순위</th>
								</tr>
								</thead>
								<tbody id="contactRisk">

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>


		</div>

		<!-- 업무정보 모달창 -->
		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h2 class="modal-title" id="riskHeader">Risk Response</h2>

						<button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<div style="display: flex;">
							<h3 id="riskTitle">리스크 대응</h3>


						</div>

					</div>
					<form class="forms-sample" id="modalFrm">
						<input type="hidden" name="risk_key"/>
						<input type="hidden" name="risk_response_key"/>
						<input type="hidden" name="contact"/>

						<div class="form-group">
							<label id="risk_status_label" for="exampleInputUsername1">리스크 상태</label>
							<input name="status" type="text" readonly class="form-control" id="risk_status"
								   placeholder="title">
						</div>

						<div class="form-group">
							<label for="exampleInputUsername1">프로젝트 명</label>
							<input name="project_title" type="text" readonly class="form-control" id="project_title"
								   placeholder="title">
						</div>

						<div class="form-group">
							<label for="exampleInputUsername1">해당 업무 명</label>
							<input name="task_title" type="text" readonly class="form-control" id="task_text"
								   placeholder="title">
						</div>

						<div class="form-group">
							<label for="exampleInputPassword1">리스크 등록자</label> <input
								name="start_date" type="text" readonly class="form-control" id="registrant"
								placeholder="risk_registrant">
						</div>

						<div class="form-group">
							<label for="exampleInputPassword1">리스크 등록일</label> <input
								type="text" class="form-control" readonly id="reg_date" placeholder="reg_date">
						</div>


						<div class="form-group">
							<label for="exampleTextarea1">상세설명</label>
							<textarea class="form-control" readonly id="detail" rows="4"></textarea>
						</div>
						<div id="div01">

						<div class="form-group">
							<label for="exampleInputPassword1" id="contactLabel">담당자 선택</label>
							<div id="radioGroup">
								<div class="form-check">

								</div>
							</div>
							<div class="form-group">

								<label for="exampleInputConfirmPassword1" >리스크 대응전략</label>
								<i class="mdi mdi-information-outline" style="font-size: 20px;" id="res_infoBtn">
								</i>
								<blockquote class="blockquote" id="res_info">
									<p style=" line-height: 2.0;">
										<strong>[부정적 전략] 회피(Avoidance) : </strong> 심각한 위험의 경우 발생 가능성을 원천적으로 차단하여 프로젝트를 중단합니다.
										<br>
										<strong>[부정적 전략] 전가(Transference) : </strong> 위험 조치에 대한 책임을 제3자에게 전가하여 보험가입 등을 통해 위험을 분산시킵니다.
										<br>
										<strong>[부정적 전략] 완화/감소(Mitigation) : </strong> 위험의 발생 가능성이나 영향력을 감소시키기 위해 테스트 및 보완 조치를 시행합니다.
										<br>
										<strong>[부정적 전략] 수용(Acceptance) : </strong> 비용 대비 효과를 고려하여 관련 위험을 그대로 수용하고 대비 계획을 수립합니다.
										<br>
										<strong>[긍정적 전략] 활용(Exploit) : </strong> 기회가 확실히 발생할 수 있도록 하여 특정 상위 리스크와 관련된 불확실성을 제거합니다.
										<br>
										<strong>[긍정적 전략] 공유(Share) : </strong> 긍정적 리스크와 기회를 공유하여 회사 간 컨소시엄을 구성하거나 협력합니다.
										<br>
										<strong>[긍정적 전략] 향상/증대(Enhance) : </strong> 긍정적 영향의 리스크 주요 원인을 식별하고 최대화하기 위해 더 많은 자원을 투입합니다.
										<br>
										<strong>[긍정적 전략] 수용(Accept) : </strong> 적극적으로 기회를 추구하는 활동을 수행하지 않고, 안전한 기존 방식을 유지합니다.
									</p>

								</blockquote>
								<input type="text"  name="strategy" class="form-control" readonly>
							</div>
							<div class="form-group">
								<label for="exampleTextarea1" >대응방안</label>
								<textarea class="form-control" rows="4" name="response_method"></textarea>
							</div>

					</form>







					<!-- Modal footer -->
					<div class="modal-footer">
						<div class="mx-auto">
							<button type="button" class="btn btn-" id="appRiskBtn"
									style="background-color: #007FFF; color: white;">리스크 결재
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

