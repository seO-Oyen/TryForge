<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
#chatList {
	/* background-color: white; */
}

.chat {
	border: 1px solid;
}

.${loginMem.member_id} {
	color: yellow;
}

.sendMsg {
	border-radius: 10px;
	width: 600px;
}

.inputbox {
	display:inline-block;
}
</style>
<div class="main-panel">
<div class="content-wrapper">
<div class="col-md-12">
<div class="row">

	<div class="col-md-3 grid-margin stretch-card">
		<div class="card">
			<div class="card-body d-flex flex-column justify-content-between">
				<div
					class="d-flex justify-content-between align-items-center mb-2">
					<p class="mb-0">채팅 리스트</p>
					<!-- <p class="mb-0 text-muted">새로운 메세지 개수?</p> -->
				</div>
				<table class="table table-hover"
					style="width: 95%; margin-left: 4%;">
					<thead>
						
					</thead>
					<tbody>
						<tr>
							<td>이름</td>
						</tr>
						<tr>
							<td>이름</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-9 grid-margin stretch-card">
		<div class="card">
			<div class="card-body d-flex flex-column justify-content-between">
				<div
					class="d-flex justify-content-between align-items-center mb-2">
					<p class="mb-0">채팅 내용</p>
				</div>
				<div class="chat ${loginMem.member_id}">안녕</div>
				<div class="chat">방가루</div>
				<div class="form-group" style="display: flex;">
					<input class="typeahead sendMsg" />
					<input type="button" class="btn btn-info" value="전송">
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