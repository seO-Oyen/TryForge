<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_user.jsp" flush="true" />

<style>
  .pagination a {
    text-decoration: none; /* 링크 밑줄 제거 */
    border: none; /* 테두리 제거 */
    color: #000; /* 링크 색상 지정 */
  }

  .pagination a:hover {
    background-color: #007FFF; /* hover 시 배경색 변경 */
    color: #fff; /* hover 시 글자색 변경 */
  }

  .pagination .page-item:hover .page-link {
    background-color: #007FFF; /* Previous, Next hover 시 배경색 변경 */
    color: #fff; /* Previous, Next hover 시 글자색 변경 */
  }
  
 .pagination .page-item.active .page-link{
 	background-color: #007FFF;
 	border-color: #007FFF;
    color: #ffffff;
 }
  
</style>
<script>

	$(document).ready(function(){
		var memberRole = "${loginMem.member_role}";
		$("#goInsertPage").click(function(){
			if(memberRole=='EMP'){
				Swal.fire({
					icon: 'warning',
					title: '접근실패',
					text: '공지사항 관리는 관리자만 이용이 가능합니다.',
					confirmButtonColor: '#007FFF',
				});
			}else{
				location.href="${path}/noticeList";
			}
		})
	
	})
	function goDetail(data){
		location.href="${path}/noticeDetail?notice_Key="+data;
	}
</script>
<div class="col-lg-6 grid-margin stretch-card"
	style="max-width: 85%; flex: 0 0 95%;">
	<div class="card">
		<div class="card-body">
			<h4 class="card-title">NOTICE</h4>
			<button type="button" class="btn btn-outline-info btn-fw" id="goInsertPage"
				style="margin-left: 85%; height: 5%; display: flex; align-items: center;">공지사항
				관리</button>
			<form>
				<div style="display: flex; width: 100%;">
				<input type="hidden" name="curPage" value="${noticeSch.curPage}"/>
					<div class="form-group" style="width: 30%; margin-left: 10%;">
						<label for="exampleInputUsername1">제목</label> <input type="text"
							name="notice_Title" class="form-control"
							id="exampleInputUsername1" value="${noticeSch.notice_Title}"
							placeholder="Noticename" style="width: 100%;">
					</div>
					<div class="form-group" style="width: 30%; margin-left: 1%;">
						<label for="exampleInputUsername2">작성자</label> <input type="text"
							name="notice_Writer" class="form-control"
							id="exampleInputUsername2" value="${noticeSch.notice_Writer}"
							placeholder="writer" style="width: 100%;">
					</div>

					<button type="submit" class="btn btn-inverse-info btn-fw"
						style="margin-left: 10px; height: 5%; margin-top: 2.3%; width: 10%;">검색</button>

				</div>
			</form>
			<div class="table-responsive" style="width: 95%;">
				<table class="table table-hover"
					style="width: 95%; margin-left: 4%;">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록날짜</th>
							<th>수정날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="nlist" items="${noticeList}">
							<tr ondblclick="goDetail(${nlist.notice_Key})">
								<td>${nlist.cnt}</td>
								<td>${nlist.notice_Title}</td>
								<td>${nlist.notice_Writer}</td>
								<td><fmt:formatDate value="${nlist.notice_Regdte}" pattern="yyyy.MM.dd"/></td>
								<td><fmt:formatDate value="${nlist.notice_Uptdte}" pattern="yyyy.MM.dd"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br><br>
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="javascript:goPage(${noticeSch.startBlock-1})">Previous</a></li>

					<c:forEach begin="${noticeSch.startBlock}" end="${noticeSch.endBlock}" var="pcnt">
						<li class="page-item ${noticeSch.curPage==pcnt?'active' : ''}">
							<a class="page-link" href="javascript:goPage(${pcnt})">${pcnt}</a>
						</li>
					</c:forEach>
							
					<li class="page-item"><a class="page-link" href="javascript:goPage(${noticeSch.endBlock+1})">Next</a></li>
				</ul>
			</div>
		</div>
		<script>
					function goPage(pcnt){
						$("[name=curPage]").val(pcnt)
						$("form").submit();
					}
		</script>
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

