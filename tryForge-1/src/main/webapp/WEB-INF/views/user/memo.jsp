<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
.memoDetail{
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    -webkit-box-orient: vertical;
}​
</style>
<script>
$(document).ready(function() {
	/* document.addEventListener('keydown', function(event) {
		if(event.keyCode === 13) {
			event.preventDefault()
		}
	}, true) */
	
})

function memoCreate() {
	console.log("클릭")
	if ($("[name=memo_detail]").val() == "") {
		Swal.fire({
            title: '빈칸입니다.',
            text: '값을 채워주세요.',
            icon: 'error',
        })
        
		return false;
	}
	
	
	$.ajax({
        url: "${path}/createMemo",
        type: "POST",
        data: {
        	member_key: $("[name=member_key]").val(),
        	memo_detail: $("[name=memo_detail]").val()
        },
        dataType: "json",
        success: function (data) {
            if (data.result) {
            	Swal.fire({
                    title: '등록 성공',
                    text: ' ',
                    icon: 'success',
                }).then(function () {
                    window.location.reload()
                })
            } else {
            	Swal.fire({
                    title: '등록 실패',
                    text: '다시 시도해주세요.',
                    icon: 'error',
                })
            }
            
        },
        error: function (err) {
            console.log(err)
        }
    })
}

</script>
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-12 grid-margin stretch-card">
				<div class="card">
					<div class="row">
						<div class="col-md-6" style="flex: 0 0 100%; max-width: 100%;">
							<div class="card-body">
								<form class="forms-sample" id="memoForm">
									<div class="form-group">
										<input name="member_key" type="hidden" value="${loginMem.member_key}">
										<label for="comment" style="margin-top: 20px;">메모</label>

										<textarea name="memo_detail" type="text" class="form-control" id="memo"
											rows="5"></textarea>

										<div style="text-align: center;">
											<button id="createMemo" type="button"
												class="btn btn-info btn-lg" style="margin-top: 20px;" onclick="memoCreate()">
												메모 등록</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		
		<div class="row">
			<div class="col-xl-12 grid-margin stretch-card flex-column">
				<h5 class="mb-2 text-titlecase mb-4">메모 목록</h5>
				<div class="row">
					<div class="col-md-12 stretch-card">
						<div class="card">
							<div class="card-body d-flex flex-column justify-content-between"
								style="height: 350px;">
								<div class="table-responsive">
									<table class="table" style="table-layout:fixed">
										<col width="80%">
										<col width="20%">
										<thead>
											<tr>
												<th>내용</th>
												<th>작성 날짜(수정 날짜)</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${memoList ne null}">
											<c:forEach var="memo" items="${memoList}">
												<tr>
													<td class="memoDetail">${memo.memo_detail}</td>
													<td>${memo.create_time}</td>
												</tr>
											</c:forEach>
											</c:if>
										</tbody>
									</table>
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