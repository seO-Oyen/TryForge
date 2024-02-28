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

	$(document).ready(function() {
		$("[name=receiver]").keypress(function(e){
			if(e.keyCode && e.keyCode == 13){
				mailSend()
			}
		})
		
		$("#inviteBtn").click(function() {
			console.log("클릭")
			mailSend()
		})
	})
	
	function mailSend() {
		if ($("[name=receiver]").val() != "") {
			
			$.ajax({
				url : "${path}/emailCheck",
				type : "GET",
				data : {
					email: $("[name=receiver]").val()
				},
				dataType : "json",
				success : function(data) {
					if(data.emailChk) {
						const Toast = Swal.mixin({
						    toast: true,
						    position: 'top-end',
						    showConfirmButton: false,
						    timer: 1500,
						    timerProgressBar: false
						})
						
						Toast.fire({
						    icon: 'error',
						    title: '이미 초대한 이메일입니다.'
						})
						return false
					} else {
						console.log("클릭염")
						mailSendOk()
					}
				},
				error : function(err) {
					console.log(err)
				}
			})
			
		} else {
			alert("보내는 사람의 메일을 입력해주세요.")
			$("[name=receiver]").focus()
			return false;
		}
	}
	
function mailSendOk() {
/* 	$("form").attr("method", "post")
	$("form").attr("onsubmit", "return true;")
	$("form").submit() */
	
	$.ajax({
		url : "${path}/insertUser",
		type : "POST",
		data : $("form").serialize(),
		dataType : "json",
		success : function(data) {
			console.log("넘어옴요")
			if(data.msg) {
				const Toast = Swal.mixin({
				    toast: true,
				    position: 'top-end',
				    showConfirmButton: false,
				    timer: 2000,
				    timerProgressBar: false
				})
				
				Toast.fire({
				    icon: 'success',
				    title: '초대완료했습니다'
				}).then(function() {
					window.location.reload()
				})
			} else {
				const Toast = Swal.mixin({
				    toast: true,
				    position: 'top-end',
				    showConfirmButton: false,
				    timer: 1500,
				    timerProgressBar: false
				})
				
				Toast.fire({
				    icon: 'error',
				    title: '이메일 전송 실패'
				})
			}
		},
		error : function(err) {
			console.log(err)
		}
	})
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
							<button type="button" id="inviteBtn" class="btn btn-info mr-2">초대하기</button>
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
									<c:if test="${memList.joined eq false}">
										<td><label class="badge badge-warning">초대완료</label></td>
									</c:if>
									<c:if test="${memList.joined eq true}">
										<td><label class="badge badge-success">가입완료</label></td>
									</c:if>
									
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