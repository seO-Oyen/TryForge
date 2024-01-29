<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />

<script type="text/javascript">
	$(document).ready(function(){
		var msg = "${msg}"
		if(msg!=""){
			alert(msg);
			location.href="${pageContext.request.contextPath}/file.do"
		}		
	});
</script>
<style>
  .file-div {
    flex: 0 0 10%;
    max-width: 10%;
  }
  .file-image {
  	margin-left: 15%;
  	max-width: 70%;
  	height: auto;
  }
  .file-title {
  	font-size: 13px; 
  	text-align: center;
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-top: 0.2rem; 
    margin-bottom: 0;  
  }
  .file-size{
  	font-size: 12px;
  	text-align: center;
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-left: 18px;
    margin-bottom: 0;
    margin-top : 4px; 
    flex-grow: 1; 
  }
  .fdown {
	font-size: 18px;
	cursor: pointer;
	margin-top : 4px;
  }
  .card .card-body {
    padding: 0.7rem 1rem; 
}
.file-info-container {
    display: flex;
    justify-content: space-between;
    align-items: center; 
    width: 100%;
}
</style>

<div class="main-panel">
	<div class="content-wrapper">

		<div class="row">
			<div class="col-xl-6 grid-margin stretch-card flex-column" style = "flex: 0 0 100%; max-width: 100%;">
			    <div class="d-flex justify-content-between mb-4 align-items-center">
			        <h5 class="mb-2 text-titlecase" style="font-size : 28px;">파일저장소</h5>
			        	<form method="post" enctype="multipart/form-data" action="upload.do">
			        		<button type="button" id="uploadBtn" class="btn btn-success">업로드</button>
			    			<input type="file" id="fileInput" name="files" multiple="multiple" style="display: none;" />
			    		</form>
			    </div>
				<div class="row">
					<c:forEach var = "file" items="${fList}">
					<div class="col-md-6 grid-margin stretch-card file-div">
						<div class="card">
							<div
								class="card-body d-flex flex-column justify-content-between">
								<div
									class="d-flex justify-content-between align-items-center mb-2">
									<img src="${pageContext.request.contextPath}${file.iconPath}" alt ="${file.ftype}"class="file-image">
								</div>
								<div>
									<h4 title="${file.fname}" class="file-title">${file.fname}</h4>
								</div>
								<div class="file-info-container">
								    <h4 title="${file.fsize}" class="file-size">${file.fsize}</h4>
								    <i class="mdi mdi-download fdown" onclick = "download('${file.fname}')"></i>
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>

<!-- 업로드 버튼눌렀을때 바로 파일 선택하고, 파일 선택 시 업로드처리까지 한번에 처리. -->
<script type="text/javascript">
document.querySelector("#uploadBtn").addEventListener('click', function(){
	document.querySelector("#fileInput").click();
});

document.querySelector("#fileInput").addEventListener('change', function(){
	$("form").submit()
})

function download(fname){
	if( confirm(fname+" 다운로드 하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/download.do?fname="+fname
	}
}
</script>			
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

