<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_user.jsp" flush="true" />
<script>
function goDash(projectKey) {
	alert("프로젝트 키 : " + projectKey)
	location.href = "${path}/tryForge/dashboard.do"
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
										style="height: 448px; overflow: auto;">
										<div class="d-flex justify-content-between align-items-center mb-2">
										<table class="table table-hover"
											style="width: 95%; margin-left: 4%;">
										<thead>
											<tr>
												<th><h4>프로젝트명</h4></th>
												<th></th>

											</tr>
										</thead>
										<tbody>
											<c:forEach var="plist" items="${plist}">
												<tr>
													<td>${plist.title}</td>
													<td><button type="button" onclick="goDash('${plist.project_key}')"
															class="btn btn-link btn-rounded btn-fw"
															style="margin-left: 60%;">자세히</button></td>
			
												</tr>
											</c:forEach>
										</tbody>
										</table>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-6 grid-margin stretch-card flex-column">
						<h5 class="mb-2 text-titlecase mb-4">초대된 프로젝트</h5>
						<div class="row h-100">
							<div class="col-md-12 stretch-card">
								<div class="card">
									<div class="card-body">
										<div class="d-flex justify-content-between align-items-start flex-wrap"
											style="height: 400px; overflow: auto;">
											<div style="border: 1px solid black; height: auto;
												width: 100%; padding: 10px; margin-bottom:5px;">
												<h5>프로젝트명</h5>
												<div style="height: 100px;">프로젝트 내용</div>
												<div>날짜</div>
												<div style="text-align: center; padding: 10px;">
												<button type="button"
													class="btn btn-success btn-md btn-icon-text mr-3">수락
													<i class="mdi mdi-check-circle-outline"></i>	
												</button>
												<button type="button"
													class="btn btn-danger btn-md btn-icon-text">거절
													<i class="mdi mdi-close-circle-outline"></i>
												</button>
												</div>
											</div>
											<div style="border: 1px solid black; height: auto;
												width: 100%; padding: 10px; margin-bottom:5px;">
												<h5>프로젝트명</h5>
												<div style="height: 100px;">프로젝트 내용</div>
												<div>날짜</div>
												<div style="text-align: center; padding: 10px;">
												<button type="button"
													class="btn btn-success btn-md btn-icon-text mr-3">수락
													<i class="mdi mdi-check-circle-outline"></i>	
												</button>
												<button type="button"
													class="btn btn-danger btn-md btn-icon-text">거절
													<i class="mdi mdi-close-circle-outline"></i>
												</button>
												</div>
											</div>
											<div style="border: 1px solid black; height: auto;
												width: 100%; padding: 10px; margin-bottom:5px;">
												<h5>프로젝트명</h5>
												<div style="height: 100px;">프로젝트 내용</div>
												<div>날짜</div>
												<div style="text-align: center; padding: 10px;">
												<button type="button"
													class="btn btn-success btn-md btn-icon-text mr-3">수락
													<i class="mdi mdi-check-circle-outline"></i>	
												</button>
												<button type="button"
													class="btn btn-danger btn-md btn-icon-text">거절
													<i class="mdi mdi-close-circle-outline"></i>
												</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 
				<table class="table table-hover"
											style="width: 95%; margin-left: 4%;">
										<thead>
											<tr>
												<th><h4>프로젝트 정보</h4></th>

											</tr>
										</thead>
										<tbody>
											<tr>
												<td rowspan="2">프로젝트1</td>
												<td>
												<button type="button"
													class="btn btn-link btn-rounded btn-fw"
													style="margin-left: 60%;">자세히</button>
												</td>

											</tr>
											<tr>
												
												<td>
												<button type="button"
													class="btn btn-link btn-rounded btn-fw"
													style="margin-left: 60%;">자세히</button>
												</td>

											</tr>
											
										</tbody>
									</table>
				-->
				
				
				<!-- <div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="table-responsive pt-3">
								<table class="table table-striped project-orders-table">
									<thead>
										<tr>
											<th class="ml-5">ID</th>
											<th>Project name</th>
											<th>Customer</th>
											<th>Deadline</th>
											<th>Payouts</th>
											<th>Traffic</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>#D1</td>
											<td>Consectetur adipisicing elit</td>
											<td>Beulah Cummings</td>
											<td>03 Jan 2019</td>
											<td>$ 5235</td>
											<td>1.3K</td>
											<td>
												<div class="d-flex align-items-center">
													<button type="button"
														class="btn btn-success btn-sm btn-icon-text mr-3">
														Edit <i class="typcn typcn-edit btn-icon-append"></i>
													</button>
													<button type="button"
														class="btn btn-danger btn-sm btn-icon-text">
														Delete <i
															class="typcn typcn-delete-outline btn-icon-append"></i>
													</button>
												</div>
											</td>
										</tr>
										<tr>
											<td>#D2</td>
											<td>Correlation natural resources silo</td>
											<td>Mitchel Dunford</td>
											<td>09 Oct 2019</td>
											<td>$ 3233</td>
											<td>5.4K</td>
											<td>
												<div class="d-flex align-items-center">
													<button type="button"
														class="btn btn-success btn-sm btn-icon-text mr-3">
														Edit <i class="typcn typcn-edit btn-icon-append"></i>
													</button>
													<button type="button"
														class="btn btn-danger btn-sm btn-icon-text">
														Delete <i
															class="typcn typcn-delete-outline btn-icon-append"></i>
													</button>
												</div>
											</td>
										</tr>
										<tr>
											<td>#D3</td>
											<td>social capital compassion social</td>
											<td>Pei Canaday</td>
											<td>18 Jun 2019</td>
											<td>$ 4311</td>
											<td>2.1K</td>
											<td>
												<div class="d-flex align-items-center">
													<button type="button"
														class="btn btn-success btn-sm btn-icon-text mr-3">
														Edit <i class="typcn typcn-edit btn-icon-append"></i>
													</button>
													<button type="button"
														class="btn btn-danger btn-sm btn-icon-text">
														Delete <i
															class="typcn typcn-delete-outline btn-icon-append"></i>
													</button>
												</div>
											</td>
										</tr>
										<tr>
											<td>#D4</td>
											<td>empower communities thought</td>
											<td>Gaynell Sharpton</td>
											<td>23 Mar 2019</td>
											<td>$ 7743</td>
											<td>2.7K</td>
											<td>
												<div class="d-flex align-items-center">
													<button type="button"
														class="btn btn-success btn-sm btn-icon-text mr-3">
														Edit <i class="typcn typcn-edit btn-icon-append"></i>
													</button>
													<button type="button"
														class="btn btn-danger btn-sm btn-icon-text">
														Delete <i
															class="typcn typcn-delete-outline btn-icon-append"></i>
													</button>
												</div>
											</td>
										</tr>
										<tr>
											<td>#D5</td>
											<td>Targeted effective; mobilize</td>
											<td>Audrie Midyett</td>
											<td>22 Aug 2019</td>
											<td>$ 2455</td>
											<td>1.2K</td>
											<td>
												<div class="d-flex align-items-center">
													<button type="button"
														class="btn btn-success btn-sm btn-icon-text mr-3">
														Edit <i class="typcn typcn-edit btn-icon-append"></i>
													</button>
													<button type="button"
														class="btn btn-danger btn-sm btn-icon-text">
														Delete <i
															class="typcn typcn-delete-outline btn-icon-append"></i>
													</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div> -->
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