<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 

<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_user.jsp" flush="true" />
<script>
function goDash(projectKey) {
	$.ajax({
		url : "${path}/setPj",
		type : "GET",
		data : {
			projectNum: projectKey
		},
		dataType : "json",
		success : function(data) {
			console.log(data)
			location.href = "${path}/dashboard"
		},
		error : function(err) {
			console.log(err)
		}
	})
}

function projectMem(projectKey) {
	$.ajax({
		url: "${path}/projectMem",
		type: "GET",
		data: {
			projectNum: projectKey
		},
		dataType: "json",
		success: function(data) {
			console.log(data)
			var memList = data.memList
			var html = ""
			for (var i = 0; i < memList.length; i++) {
				console.log(i)
				/* if (i == 0) {
					html += "<td colspan='2'>" + memList[i].member_name + "</td></tr>"
				} */
				/* else {
				} */
					html += "<tr>"
					html += "<td colspan='2'>" + memList[i].member_name + "</td>"
					html += "</tr>"
				console.log(html)
			}
			$("#tbody").append(html)
			
			
		},
		error: function(err) {
			console.log(err)
		}
		
	})
	
}

function goChat(projectKey) {
	console.log(projectKey)
	$.ajax({
		url: "${path}/goPjChat",
		type: "GET",
		data: {
			projectNum: projectKey
		},
		dataType: "json",
		success: function(data) {
			if (data.msg == "없음") {
				Swal.fire({
					title : "만들어진 채팅방이 없습니다.",
					text : '관리자에게 문의해주세요',
					icon : 'error',
				})
			} else {
				location.href = "${path}" + data.chat				
			}
		},
		error: function(err) {
			console.log(err)
		}
		
	})
}

</script>
		<!-- main 대시보드 내용 -->
		<!-- partial -->
		<div class="main-panel">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-xl-6 grid-margin stretch-card flex-column">
						<h5 class="mb-2 text-titlecase mb-4">참여중인 프로젝트</h5>
						<div class="row h-100">
							<div class="col-md-12 stretch-card">
								<div class="card">
									<div class="card-body d-flex flex-column justify-content-between"
										style="height: 500px; overflow: auto;">
										<div class="d-flex justify-content-between align-items-center mb-2">
										<table class="table"
											style="width: 95%; margin-left: 4%;">
											<col width="90%">
											<col width="10%">
											<thead>
												
											</thead>
											<tbody id="tbody">
												<c:forEach var="project" items="${projectList}">
													<c:if test="${project.status eq '진행중'}">
														<tr>
															<td><h5>${project.title}</h5></td>
															<td><button type="button" onclick="goDash('${project.project_key}')"
																	class="btn btn-link btn-rounded btn-fw">대시보드로</button></td>
														</tr>
														<tr>
															<td colspan="2">
															${project.start_date.substring(0,10)}
															~ ${project.end_date.substring(0,10)}</td>
														</tr>
														<tr>
															<td colspan="2"><h6>참여중인 멤버</h6></td>
														</tr>
														<script>
															projectMem("${project.project_key}")
														</script>
														</tbody>
													</table>
													</div>
													<button class="btn btn-info" onclick="goChat('${project.project_key}')">프로젝트 채팅방으로</button>
													</c:if>
												</c:forEach>
											
											
										
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-6 grid-margin stretch-card flex-column">
						<h5 class="mb-2 text-titlecase mb-4">완료 프로젝트</h5>
						<div class="row h-100">
							<div class="col-md-12 stretch-card">
								<div class="card">
										<div class="card-body d-flex flex-column justify-content-between"
											style="height: 400px; overflow: auto;">
											<div class="d-flex justify-content-between align-items-center mb-2">
											<table class="table table-hover"
												style="width: 95%; margin-left: 4%;">
											<col width="90%">
											<col width="10%">
											<thead>
												<tr>
													
												</tr>
											</thead>
											<tbody>
												<c:forEach var="project" items="${projectList}">
													<c:if test="${project.status eq '완료'}">
														<tr>
															<td><h5>${project.title}</h5></td>
															<td><button type="button" onclick="goDash('${project.project_key}')"
																	class="btn btn-link btn-rounded btn-fw">대시보드로</button></td>
														</tr>
													</c:if>
												</c:forEach>
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
				
			</div>

		
		<!-- 이 밑은 복붙할때 알아서 붙이쇼 -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->


</body>

</html>