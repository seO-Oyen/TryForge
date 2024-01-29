<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<style>
    .content-wrapper {
        height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .card {
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    .card-body {
        flex: 1;
        overflow: hidden !important;
    }

    #calendar {
        height: 100%;
        overflow: hidden !important;
    }
    .card .card-body{
        padding: 1rem 1.65rem;
    }
    #chatArea {
	width: 80%;
	height: 100px;
	overflow-y: auto;
	text-align: left;
	border: 1px solid green;
	
}
.input-group-text {
	width: 100%;
	background-color: linen;
	color: black;
	font-weight: bolder;
}

.input-group-prepend {
	width: 20%;
}
</style>
<div class="main-panel">
<script type="text/javascript">
$(document).ready(function() {
	var calendarEl = document.getElementById('calendar');
	var today = new Date();
	var todayTitle = today.toISOString().split("T")[0] // 표준시간
	console.log(todayTitle)
	var calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar : {
			left : 'prev,next today',
			center : 'title',
			right : 'dayGridMonth,timeGridWeek,timeGridDay'
		},
		initialDate : todayTitle,
		fixedWeekCount: false,
	    height: 'parent',
		navLinks : true, // can click day/week names to navigate views
		selectable : true,
		selectMirror : true,
		
		select : function(arg) { // 날짜 선택하면 상세일정 등록 이벤트
			// 등록을 위해 처리되는 이벤트 핸들러(날짜 클릭, 시간을 스크롤 하면 처리)
			// 등록을 위해서 기존에 있던 정보(없으면 공백)으로 입력창 출력
			$("#frm01")[0].reset()
			$("#calTitle").text("일정등록")
			$("#start").val(arg.start.toLocaleString())
			$("[name=start]").val(arg.startStr)
			$("#end").val(arg.end.toLocaleString())
			$("[name=end]").val(arg.endStr)
			$("[name=allDay]").val(arg.allDay ? 1 : 0)
			// 강제 클릭..
			$("#calTitle").text("일정등록")	
			$("#regBtn").show()
			$("#uptBtn").hide()
			$("#delBtn").hide() 
			$("#calModal").click()				

			calendar.unselect() // 입력된 정보 등록/취소 후 날짜선택창 닫음
		},
		
		eventClick : function(arg) {
			console.log("#일정 클릭시#")
			console.log(arg.event)
			addForm(arg.event)

			$("#calTitle").text("일정상세")	
			$("#regBtn").hide()
			$("#uptBtn").show()
			$("#delBtn").show() 
			$("#calModal").click()					
		},
		eventDrop : function(arg){
			addForm(arg.event)
			ajaxFunc("updateCalendar.do", "post")
		},
		eventResize : function(arg){
			addForm(arg.event)
			ajaxFunc("updateCalendar.do", "post")
		},
		editable : true,
		dayMaxEvents : true, // allow "more" link when too many events
		events : function(info, successCallback, failureCallBack) {
			$.ajax({
				url : "${pageContext.request.contextPath}/getCalendar.do",
				dataType : "json",
				success : function(data) {
					console.log(data.cal)
					//alert(data.callist.length+"건!!")
					// 서버단에서 받은 json데이터를 
					// calendar api에 할당 처리..
					successCallback(data.cal)
				},
				error : function(err) {
					console.log(err)
					failureCallBack(err)
				}
			})
		}
	});

	calendar.render();

	$("#regBtn").click(function() {
		ajaxFunc("insertCalendar.do", "post")
	})
	$("#uptBtn").click(function(){
		if(confirm("수정하시겠습니까?")){
			ajaxFunc("updateCalendar.do", "post")
		}
	})
	$("#delBtn").click(function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxFunc("deleteCalendar.do", "post")
		}
	})
	
	// 링크된 페이지로 창을 로딩하여 이동하게 처리..
	$("[name=urlLink]").dblclick(function(){
		if(confirm("해당페이지로 이동하시겠습니까?")){
			window.open($(this).val(),"","")
		}
	})
	// 데이터를 입력하고 요청데이터 서버에 전송 함수
	function ajaxFunc(url, type){
		$.ajax({
			type : type,
			url : "${pageContext.request.contextPath}/"+url,
			data : $("#frm01").serialize(),
			dataType : "json",
			success : function(data) {							
				$("#clsBtn").click() 
				calendar.refetchEvents();
			},
			error : function(err) {
				console.log(err)
			}
		})			
	}
	// evt.속성 : 기본적으로 fullcalendar에서 사용하는 속성 
	// evt.extendedProps.속성 : 기본속성이 아닌 추가적으로 
	//		상세화면에 출력시 사용되는 속성
	function addForm(evt){
		$("[name=calendar_key]").val(evt.extendedProps.calendar_key)
		$("[name=title]").val(evt.title)
		$("[name=writer]").val(evt.extendedProps.writer)
		$("#start").val(evt.start.toLocaleString())
		$("[name=start]").val(evt.startStr)
		$("#end").val(evt.end.toLocaleString())
		$("[name=end]").val(evt.endStr)
		
		$("[name=backgroundColor]").val(evt.backgroundColor)
		$("[name=textColor]").val(evt.textColor)
		$("[name=detail]").val(evt.extendedProps.detail)
		$("[name=urlLink]").val(evt.extendedProps.urlLink)
		$("[name=allDay]").val(evt.allDay?1:0)
	}

});
</script>

<div class="content-wrapper">
	<div class="card">
		<div id='calendar' class="card-body">
		
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
	<button id="calModal" class="btn btn-success d-none"
		data-toggle="modal" data-target="#exampleModalCenter" type="button">등록</button>

	<div class="modal fade" id="exampleModalCenter" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header"><!-- 

				
				 -->
					<h5 class="modal-title" id="calTitle">일정등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm01" class="form" method="post">
						<input type="hidden" name="calendar_key" value="0"/>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									제목</span>
							</div>
							<input type="text" name="title" class="form-control" value="" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									시작일</span>
							</div>
							<input type="text" id="start" readonly class="form-control" /> <input
								type="hidden" name="start" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									종료일</span>
							</div>
							<input type="text" id="end" readonly class="form-control" /> <input
								type="hidden" name="end" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									작성자</span>
							</div>
							<input name="writer" class="form-control" value="" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									내용</span>
							</div>
							<textarea name="detail" id="chatArea" class="form-control"></textarea>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									배경색상</span>
							</div>
							<input type="color" name="backgroundColor" class="form-control"
								value="#0099cc" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									글자색상</span>
							</div>
							<input type="color" name="textColor" class="form-control"
								value="#ccffff" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									종일여부</span>
							</div>

							<select name="allDay" class="form-control">
								<option value="1">종일</option>
								<option value="0">시간</option>
							</select>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									참고 link</span>
							</div>
							<input type="text" name="urlLink" class="form-control" value="" />
						</div>
					</form>
				</div>
				<div class="modal-footer"><!-- -->
					<button type="button" id="regBtn" class="btn btn-primary">일정등록</button>
					<button type="button" id="uptBtn" class="btn btn-info">일정수정</button>
					<button type="button" id="delBtn" class="btn btn-warning">일정삭제</button>
					<button type="button" id="clsBtn" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
				<script type="text/javascript">
					
				</script>
			</div>
		</div>
	</div>
	
</body>

</html>

