<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
.card-body > button {
	margin-top : 20px;
}

#profile{
	width: 150px;
	margin-bottom: 20px;
	border-radius: 70%;
}

#userName {
	border: 1px solid #aab2bd;
	/* display:inline-block; */
	width: 500px;
	margin: 0 auto;
	padding: 10px;
}
#userId {
	border: 1px solid #aab2bd;
	/* display:inline-block; */
	width: 500px;
	margin: 0 auto;
	padding: 10px;
}
#userEmail {
	border: 1px solid #aab2bd;
	/* display:inline-block; */
	width: 500px;
	margin: 0 auto;
	padding: 10px;
}
</style>
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="row">
						<div class="col-md-6" style="flex: 0 0 100%; text-align: center; max-width: 100%;">
							<div class="card-body">
								<img src="${path}/template/images/faces/face5.jpg" alt="profile" id ="profile"/>
								<div style="color: gray; margin-top: 10px;">이름</div>
								<div id="userName">${loginMem.member_name}</div>
								<div style="color: gray; margin-top: 10px;">아이디</div>
								<div id="userId">${loginMem.member_id}</div>
								<div style="color: gray; margin-top: 10px;">이메일</div>
								<div id="userEmail">${loginMem.member_email}</div>
								
								<button type="button"
									class="btn btn-info btn-md mr-3">비밀번호 수정
								</button>
								<button type="button"
									class="btn btn-secondary btn-md btn-icon-text">개인정보 수정
								</button>
							</div>
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