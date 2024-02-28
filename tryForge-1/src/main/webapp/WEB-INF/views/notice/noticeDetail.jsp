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
    // 수정, 삭제 구분
    var proc = "${proc}";
    var msg = "${msg}";

    if (proc !== "") {
        if (proc === "upt") {
            Swal.fire({
                text: msg + "\n조회화면으로 이동하시겠습니까?",
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
                confirmButtonColor: '#007FFF',
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = "${path}/noticeList";
                }
            });
        }
        if (proc === "del") {
            Swal.fire({
                text: msg + "\n조회화면으로 이동합니다.",
                icon: 'warning',
                confirmButtonColor: '#007FFF', 
            }).then(() => {
                location.href = "${path}/noticeList";
            });
        }
    }

    // 세션값 확인하여 버튼 숨김
    $(document).ready(function() {
        var writer = "${notice.notice_Writer}";
        var sessName = "${loginMem.member_name}";

        if (sessName !== writer) {
            $("#uptBtn").hide();
            $("#delBtn").hide();
        }

        
        // 수정
        $("#uptBtn").click(function() {
            var noticeKey = "${notice.notice_Key}";
            location.href = "${path}/updateNoticeFrm?notice_Key=" + noticeKey;
        });

        // 삭제
        $("#delBtn").click(function() {
            var no = "${notice.notice_Key}";
            Swal.fire({
                text: '삭제하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#007FFF',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = "${path}/deleteNotice?notice_Key=" + no;
                }
            });
        });
    });
</script>
<div class="col-12 grid-margin" style="max-width: 85%; flex: 0 0 95%;">
	<div class="card">
		<div class="card-body">
			<div style="display: flex; margin-left: 85%">
				<button type="button" class="btn btn-inverse-info btn-fw"
					id="uptBtn">수정</button>
				<button type="button" class="btn btn-inverse-danger btn-fw"
					style="margin-left: 10px" id="delBtn">삭제</button>
			</div>
			<form class="form-sample" method="post" id="updateForm">

			
				<!-- 제목 -->
				<br>
				<div style="display: flex;">
					<h2>${notice.notice_Title}</h2>
					<br>
					<p style="margin-top: 1%;">
						&nbsp;
						<mark class="bg-danger text-white"> 필독</mark>
					</p>
				</div>
				<br>
				<!-- 수정 등록일 -->
				<div style="display: flex;">
					<p class="text-lowercase">
						등록
						<fmt:formatDate value="${notice.notice_Regdte}"
							pattern="yyyy.MM.dd" />
					</p>
					<p class="text-lowercase" style="margin-left: 2%;">
						수정
						<fmt:formatDate value="${notice.notice_Uptdte}"
							pattern="yyyy.MM.dd" />
					</p>
					<p class="text-lowercase" style="margin-left: 2%;">조회수
						${notice.notice_Readcnt}</p>
				</div>
				<!-- 작성자, 권한 -->
				<ul class="list-star">
					<li>작성자 ${notice.notice_Writer}(${notice.member_Role})</li>
				</ul>
				<!-- 상세내용 -->

				<br>
				<div class="form-group">
					<textarea class="form-control" id="exampleTextarea1"
						style="border: none;">${notice.notice_Detail}</textarea>
				</div>
			</form>

			<button type="button" class="btn btn-info btn-lg btn-block"
				onclick="location.href='${path}/noticeList'"
				style="margin-left: 34%; height: 5%; margin-top: 2.3%; width: 30%; background: #007FFF;">이전페이지</button>
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

