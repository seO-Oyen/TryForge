<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" /> --%>

<jsp:include page="${path}/template/module/module_admain.jsp"
	flush="true" />

<script>
	var msg = "${msg}"
	if (msg != "") {
		alert(msg)
	}

	$(document).ready(function() {
		$("[name=receiver]").keypress(function(e){
			if(e.keyCode && e.keyCode == 13){
				mailSend()
			}
		})
		
		$("#inviteBtn").click(function() {
			mailSend()
		})
	})
	
	function mailSend() {
		if ($("[name=receiver]").val() != "") {
			$("form").attr("method", "post")
			$("form").attr("onsubmit", "return ture;")
			$("form").submit()
		} else {
			alert("보내는 사람의 메일을 입력해주세요.")
			$("[name=receiver]").focus()
			return false;
		}
	}
</script>
<div class="content-wrapper">
	<div class="row">
		<div class="col-12 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">유저 초대</h4>
					<form class="forms-sample" onsubmit="return false;">
						<div class="form-group row">
							<label for="exampleInputUsername2"
								class="col-sm-3 col-form-label">초대받으실 분의 이메일</label>
							<div class="col-sm-9">
								<input type="email" name="receiver" class="form-control"
									id="exampleInputUsername2" placeholder="Email"
									autocomplete="off">
							</div>
						</div>
						<div style="text-align: center;">
							<button type="button" id="inviteBtn" class="btn btn-primary mr-2">초대하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div class="col-12 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">초대 목록</h4>
					<table class="table table-hover"
						style="width: 95%; margin-left: 4%;">
						<thead>
							<tr>
								<th>번호</th>
								<th>초대한 사람</th>
								<th>초대받는 사람</th>
								<th>가입여부</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="memList" items="${list}" varStatus="status">
								<tr>
									<td>${memList.invite_key}</td>
									<td>${mem[status.index].member_name}</td>
									<td>${memList.invitee_email}</td>
									<td>${memList.joined}</td>
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
<!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->


</body>

</html>