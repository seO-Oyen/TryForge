<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<jsp:include page="${path}/template/module/module_admain.jsp"
	flush="true" />

<script>
$(document).ready(function() {
    var msg = "${msg}";

    if (msg !== "") {
        Swal.fire({
            text: msg + "\n계속 수정하시겠습니까?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            confirmButtonColor: '#007FFF',
        }).then((result) => {
            if (!result.isConfirmed) {
                location.href = "${path}/noticeList";
            }
        });
    }

    $("#regBtn").click(function() {
        if ($("#noticeTitle").val() === "") {
            Swal.fire({
                text: "제목을 입력해주세요",
                icon: 'warning',
                confirmButtonColor: '#007FFF',
            });
            return;
        }

        if ($("#noticeDetail").val() === "") {
            Swal.fire({
                text: "공지사항 상세내용을 입력해주세요",
                icon: 'warning',
                confirmButtonColor: '#007FFF', 
            });
            return;
        }

        Swal.fire({
            text: "등록하시겠습니까?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            confirmButtonColor: '#007FFF',
        }).then((result) => {
            if (result.isConfirmed) {
                $("form").attr("action", "${path}/updateNotice")
                $("form").submit();
            }
        });
    });
});
</script>
<div class="col-12 grid-margin stretch-card"
	style="max-width: 85%; flex: 0 0 95%;">

	<div class="card">
		<div class="card-body">

			<form class="forms-sample" method="post">
			
				<input type="hidden" name="notice_Key" value="${notice.notice_Key}"/>
				<div class="form-group">
					<label for="exampleInputName1">제목</label> <input type="text"
						class="form-control" id="noticeTitle" placeholder="Title"
						name="notice_Title" value="${notice.notice_Title}">
				</div>

				<div class="form-group">
					<label for="exampleInputEmail3">작성자</label> <input type="text"
						class="form-control" readonly value="${loginMem.member_name}"
						id="exampleInputEmail3" placeholder="Name" name="notice_Writer">
				</div>

				<div class="form-group">
					<label for="exampleInputName1">아이디</label> <input type="text"
						class="form-control" value="${loginMem.member_id}" id="noticeId" readonly
						name="">
				</div>

				<div class="form-group">
					<label for="exampleInputName1">등록일</label> 
					<input type="text" class="form-control" id="noticeDate" readonly
					 value="<fmt:formatDate value="${notice.notice_Regdte}" pattern="yyyy.MM.dd"/>">
				</div>
				<div class="form-group">
					<label for="exampleTextarea1">상세내용</label>
					<textarea class="form-control" id="noticeDetail"
						name="notice_Detail">${notice.notice_Detail}</textarea>
				</div>
				<button id="regBtn" type="button" class="btn btn-info mr-2" style="background:#007FFF;">수정</button>
				<button class="btn btn-light" id="mainBtn" onclick="location.href='${path}/noticeList'">취소</button>
			</form>
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

