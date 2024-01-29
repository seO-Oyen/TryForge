<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_admain.jsp" flush="true" />
<!-- 진행중인 프로젝트 -->
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="row">
						<div class="col-md-6" style="flex: 0 0 100%; max-width: 100%;">
							<div class="card-body">
								<div style="display: flex;">
								<h4 class="card-title">Project</h4>
								<button type="button" class="btn btn-link btn-rounded btn-fw"
								style="margin-left: 83%;" onclick="location.href='${path}/projList'">자세히</button>
								</div>

								<!-- 진행중인 프로젝트 테이블 -->
								<div class="table-responsive" style="width: 95%; margin-left: 4%; max-height: 350px; overflow-x: auto;">
									<table class="table table-hover"
										style="width: 95%; margin-left: 4%;">
										<thead>
											<tr>
						

											</tr>
										</thead>
										<tbody>
									<c:forEach var="plist" items="${plist}">
										<c:if test="${plist.status == '진행중'}">
											<tr>
												<td>${plist.title}</td>
												<c:set var="formattedStartDate" value="${fn:substring(plist.start_date, 0, 10)}" />
												<td><c:out value="${formattedStartDate}" /></td>
												<c:set var="formattedEndDate" value="${fn:substring(plist.end_date, 0, 10)}" />
												<td><c:out value="${formattedEndDate}" /></td>
												
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

		<!-- 진행중인 프로젝트 end -->
		<!-- 요청된 프로젝트 -->
		<div style="display: flex;">
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">Completed Projects</h4>

						<div class="table-responsive" style="width: 95%; margin-left: 4%; max-height: 200px; overflow-x: auto;">
							<table class="table table-hover"
								style="width: 95%; margin-left: 4%;">
								<thead>
									
								</thead>
								<tbody>
									<c:forEach var="plist" items="${plist}">
										<c:if test="${plist.status == '완료'}">
											<tr>
												<td>${plist.title}</td>
												<td><button type="button"
														class="btn btn-link btn-rounded btn-fw"
														style="margin-left: 60%;">자세히</button></td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- 구성원관리 -->
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
							<h4 class="card-title">Team Member Management</h4>
							<button type="button" class="btn btn-link btn-rounded btn-fw"
								style="margin-left: 35%;">자세히</button>
						</div>

						<div class="table-responsive" style="width: 95%;">
							<table class="table table-hover"
								style="width: 95%; margin-left: 4%;">
								<thead>
									<tr>
										<th>이름</th>
										<th>진행프로젝트</th>
										<th>권한</th>
									</tr>
								</thead>
								<tbody>

									<tr>
										<td>홍길동</td>
										<td>프로젝트1</td>
										<td>팀원</td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- 요청된 프로젝트, 구성원관리 -->
		<!-- 공지사항 -->
		<div style="display: flex;">
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
							<h4 class="card-title">Notice</h4>
							<button type="button" class="btn btn-link btn-rounded btn-fw"
								style="margin-left: 70%;" onclick="location.href='${path}/noticeList'">자세히</button>
						</div>
						<div class="table-responsive" style="width: 95%; margin-left: 4%; max-height: 200px; overflow-x: auto;">
							<table class="table table-hover"
								style="width: 95%; margin-left: 4%;">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="nlist" items="${noticeList}">
										<tr>
											<td>${nlist.notice_Key}</td>
											<td>${nlist.notice_Title}</td>
											<td>${nlist.notice_Writer}</td>
											<td><fmt:formatDate value="${nlist.notice_Regdte}" pattern="yyyy.MM.dd"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

					</div>
				</div>
			</div>
			<!-- 업무현황 -->
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<div style="display: flex;">
							<h4 class="card-title">Task Progress</h4>
							<button type="button" class="btn btn-link btn-rounded btn-fw"
								style="margin-left: 60%;">자세히</button>
						</div>
						<div class="table-responsive" style="width: 95%;">
							<table class="table table-hover"
								style="width: 95%; margin-left: 4%;">
								<thead>
									<tr>
										<th>담당자</th>
										<th>업무</th>
										<th>진행상태</th>
										<th>할당날짜</th>
									</tr>
								</thead>
								<tbody>

									<tr>
										<td>홍길동</td>
										<td>화면설계</td>
										<td>진행중</td>
										<td>20240101</td>
									</tr>

								</tbody>
							</table>
						</div>

					</div>
				</div>
			</div>

		</div>
		<!-- 공지사항, 업무현황 -->




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

