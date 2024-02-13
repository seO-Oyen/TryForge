<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<script>
	function updateTaskOpenStatus(id, isOpen) {
		gantt.ajax.post({
			url:"${path}/uptTaskOpenStatus",
			data: {
				id: id,
				open: isOpen,
			}
		}).then(function(response){
			var msg = isOpen?"하위업무 표시.":"하위업무 숨김."
			toastMsg('success', msg);
		}).catch(function(error){
			errorMsg('업무 숨김처리 실패', '에러메세지 : '+error);
		})
	}
	function successMsg(title, text) {
		Swal.fire({
			icon: 'success',
			title: title,
			text: text,
		});
	}
	function toastMsg(icon, title, text) {
		const Toast = Swal.mixin({
			toast: true,
			position: 'top-end',
			showConfirmButton: false,
			timer: 3000,
			timerProgressBar: true,
			didOpen: (toast) => {
				toast.addEventListener('mouseenter', Swal.stopTimer);
				toast.addEventListener('mouseleave', Swal.resumeTimer);
			}
		})
		Toast.fire({
			icon: icon,
			title: title,
			text: text
		});
	}
	function errorMsg(title, text) {
		Swal.fire({
			icon: 'error',
			title: title,
			text: text,
		});
	}
	function confirmMsg(title, text, icon, onConfirm, onCancel) {
		Swal.fire({
			title: title,
			text: text,
			icon: icon,
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '승인',
			cancelButtonText: '취소'
		}).then((result) => {
			if(result.isConfirmed && typeof onConfirm === 'function') {
				onConfirm();
			} else if(result.dismiss === Swal.DismissReason.cancel && typeof onCancel === 'function') {
				onCancel();
			}
		});
	}
</script>
<style>
.swal2-container {
	z-index: 999999 !important; /* swalert2 최상단에 보이게끔 */
}
.saturday {
    background-color: #f0f8ff; /* 토요일 */
}
.sunday {
	background-color : #fff0f5; /* 일요일 */
}
.gantt_cal_light { /* 라이트박스 속성 변경 */
	width: 40% !important;
	height: auto !important;
}
.gantt_cal_light_wide .gantt_section_time { /* 날짜 세로 조정 */
	height:auto !important;
	align-items: center;
	display: flex;
}
.gantt_cal_light_wide .gantt_wrap_section { /* 라이트박스 테두리 제거 */
	border: none !important;
}
.gantt_cal_light_wide .gantt_cal_lsection {
	text-align: center;
}
.gantt_delete_btn_set { /* 라이트박스 삭제버튼 속성 변경 */
	display: inline-block !important;
	color: #fff !important;
	background-color: #dc3545 !important;
	border-color : #dc3545 !important; 
} 
.gantt_delete_btn_set:hover {
	color: #fff !important;
	background-color: #c82333 !important;
	border-color : #bd2130 !important; 
} 
.gantt_cancel_btn_set { /* 라이트박스 취소버튼 속성 변경 */
	display: inline-block !important;
	color: #fff !important; 
	background-color: #6c7293 !important;
	border-color : #6c7293 !important; 	 
}
.gantt_cancel_btn_set:hover {
	color: #fff !important;
	background-color: #5c617d !important;
	border-color : #565b76 !important;
} 
.gantt_save_btn_set { /* 라이트박스 저장버튼 속성 변경 */
	display: inline-block !important;
	color: #fff !important; 
	background-color: #007fff !important;
	border-color : #007fff !important;
}
.gantt_save_btn_set:hover {
	color: #fff !important; 
	background-color: #2c73ba !important; 
	border-color : #296db0 !important; 
}
.gantt_duration span {
	display : none;
}
.gantt_scale_cell {
    text-align: center !important;
    vertical-align: middle !important;
}
div.gantt_cal_light .gantt_cal_ltitle .gantt_title {
	font-size: 25px;
}
/* 왼쪽 그리드 컬럼명 중앙 정렬 */
.gantt_grid_head_cell {
    text-align: center !important;
    vertical-align: middle !important;
}
/* 라이트박스 기간 설정 */
.div.gantt_cal_light .gantt_section_time select, div.gantt_cal_light select {
	margin-right: 5px;
}
/* 왼쪽 그리드 컬럼 데이터 중앙 정렬 */
.gantt_cell, .gantt_task_cell {
    text-align: center !important;
    vertical-align: middle !important;
}

.gantt_grid_head_cell.gantt_grid_head_add.gantt_last_cell {
    display: none !important; 
}

</style>
<div id='gantt_here' style="width:100%; height:100%; margin-left:20px; margin-right:20px;"class="main-panel">

<div>
<script type="text/javascript">
const userRole = "${loginMem.member_role}"
const memberKey = "${loginMem.member_key}"
const creater = "${projectMem.creater}"

if(userRole === 'ADM' || memberKey === creater) {
	gantt.config.readonly = false;
} else {
	gantt.config.readonly = true;
}

gantt.setWorkTime({ day: 6, hours: false }); // 토요일
gantt.setWorkTime({ day: 0, hours: false }); // 일요일
gantt.config.duration_unit = "day";
gantt.config.work_time = true; // 워크타임 적용
// locale 적용
gantt.i18n.setLocale({
    date: {
        month_full: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        month_short: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        day_full: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
        day_short: ["일", "월", "화", "수", "목", "금", "토"]
    },
    labels: {
        new_task: "새로운 업무",
        icon_save: "저장",
        icon_cancel: "취소",
        icon_details: "세부사항",
        icon_edit: "편집",
        icon_delete: "삭제",
        gantt_save_btn: "저장",
        gantt_cancel_btn: "취소",
        gantt_delete_btn: "삭제",
        confirm_closing: "",
        confirm_deleting: "작업이 영구적으로 삭제됩니다. 계속하시겠습니까?",
        section_description: "업무명",
        section_time: "업무기간",
        section_type: "유형",
        section_owner: "담당자",
        section_rollup: "롤업",
        section_hide_bar: "바 숨기기",
		section_detail: "업무설명",
        /* grid columns */
        column_wbs: "WBS",
        column_text: "작업 이름",
        column_start_date: "시작 시간",
        column_duration: "기간",
        column_add: "",
        
        /* link confirmation */
        link: "링크",
        confirm_link_deleting: "삭제될 것입니다",
        link_start: " (시작)",
        link_end: " (끝)",
        
        type_task: "작업",
        type_project: "프로젝트",
        type_milestone: "마일스톤",
        
        minutes: "분",
        hours: "시간",
        days: "일",
        weeks: "주",
        months: "월",
        years: "년",
        
        /* message popup */
        message_ok: "확인",
        message_cancel: "취소",
        
        /* constraints */
        section_constraint: "제약사항",
        constraint_type: "제약사항 유형",
        constraint_date: "제약사항 날짜",
        asap: "가능한 빨리",
        alap: "가능한 늦게",
        snet: "빨리 시작 안함",
        snlt: "늦게 시작 안함",
        fnet: "빨리 끝내지 않음",
        fnlt: "늦게 끝내지 않음",
        mso: "반드시 시작",
        mfo: "반드시 끝내기",
         
        /* resource control */
        resources_filter_placeholder: "필터링을 위해 입력하세요",
        resources_filter_label: "빈 항목 숨기기"
    }
});
// 날짜 단위설정과 휴일설정
gantt.config.scales = [
    {unit: "month", step: 1, format: "%Y년 %m월"},
	{unit: "day", step: 1, format: "%d %D", css: function(date) {
	    if(!gantt.isWorkTime({ date: date, unit: "day"})){
	        var day = date.getDay();
	        if(day === 6){
				return "saturday";
	        } else if(day === 0){
				return "sunday";
	        }	
	    }
	}}
];

// 기존 설정 유지
show_empty_state = true;
gantt.config.start_date = new Date("${date.start_date}");
gantt.config.end_date = new Date("${date.end_date}+1");
gantt.config.autosize = "y";
gantt.config.date_format = "%Y-%m-%d";

gantt.config.date_grid = "%M %d일";

gantt.templates.task_time = function(start, end) {
   // 날짜 포맷을 정의
    var dateFormat = gantt.date.date_to_str("%Y년 %m월 %d일");
    return dateFormat(start) + " - " + dateFormat(end);
};
var users = [];
var dataUsers = [];
<c:forEach var="mem" items="${memList}">
	users.push({key: "${mem.owner}", label: "${mem.owner}"});
	dataUsers.push("${mem.member_key}");
</c:forEach>

// task 라이트박스
gantt.config.lightbox.sections = [
	{name: "description", height: 47, map_to: "text", type: "textarea", focus: true},
	{name: "owner", height: 40, map_to: "owner", type: "select", options: users},
	{name: "time",map_to: "auto", type: "time", time_format:["%Y","%m","%d"]},
	{name: "detail", height: 47, map_to: "detail", type: "textarea"}
];
// project 라이트박스
gantt.config.lightbox.project_sections=[
    {name:"detail", height:100, map_to:"detail", type:"textarea"}
];

gantt.config.scale_height = 50;
gantt.templates.date_scale = function(date){
    var formatFunc = gantt.date.date_to_str("%d %l");
    return formatFunc(date);
};
gantt.templates.lightbox_header = function(start, end, task) {
	return task.text;
};
// 왼쪽 컬럼
gantt.config.columns=[
    {name:"text",       label:"업무명",  tree:true, width:180 },
    {name:"start_date", label:"시작일", align: "center", width:80 },
    {name:"duration",   label:"기간",   align: "center", width:40 },
    {name:"owner",      label:"담당자", align: "center", width:70 },
    {name:"add",        label:"", width:44 }
];
// 새 작업일 때 삭제버튼 숨기기처리
gantt.attachEvent("onLightbox", function(id) {
	var task = gantt.getTask(id);
	var deleteButton = document.querySelector(".gantt_delete_btn_set");
	// 새로운 작업 또는 프로젝트 삭제 버튼 숨기기
	if (task.$new || task.type === 'project') {
		if (deleteButton) {
			deleteButton.style.setProperty('display', 'none', 'important');
		}
	} else {
		// 기존 작업 삭제 버튼을 다시 표시
		if (deleteButton) {
			deleteButton.style.setProperty('display', '', 'important');
		}
	}
});
// 라이트박스 save
gantt.attachEvent("onLightboxSave", function(id, task) {
	if(task.type!=='project') {
		var selectControl = gantt.getLightboxSection('owner').control;
		// 현재 선택된 option의 index 가져오기
		var selectedIndex = selectControl.selectedIndex;
		if(selectedIndex > -1 && selectedIndex < dataUsers.length) {
			var selectedUserKey = dataUsers[selectedIndex];
			task.selectedUserKey = selectedUserKey; // task객체에 userkey 할당
		}
	}
	if (!task.text || !task.detail) {
		errorMsg('경고!', '업무명과 업무설명은 반드시 입력해야 합니다.');
		return false;
	}
	return true; // 입력값 유효 시 작업 추가 계속
});
// 라이트박스 삭제이벤트
gantt.attachEvent("onLightboxDelete", function(id) {
	confirmMsg(
			'삭제하시겠습니까?',
			'업무가 영구적으로 삭제됩니다.(하위포함)',
			'error',
			function() {
				gantt.ajax.post({
					url: "${path}/delTask",
					data: {
						id: id
					}
				}).then(function(response) {
					gantt.deleteTask(id);
					successMsg('삭제 성공!', '업무가 성공적으로 삭제되었습니다.');
					gantt.hideLightbox();
				}).catch(function(error) {
					errorMsg('삭제 실패!', '에러메세지 : '+error);
				})
			},
			function() {
				errorMsg('삭제 취소!', '업무 삭제를 취소하였습니다.');
			}
	);
	return false;
})

// 업무추가
gantt.attachEvent("onAfterTaskAdd", function(id, item){
	var dateFormat = gantt.date.date_to_str("%Y-%m-%d");
	var startDate = dateFormat(item.start_date);
	var endDate = dateFormat(item.end_date);
		gantt.ajax.post({
			url:"${path}/insTask",
			data: {
				text: item.text,
				member_key: item.selectedUserKey,
				start_date: startDate,
				end_date: endDate,
				duration: item.duration,
				progress: item.progress,
				parent: item.parent,
				detail: item.detail,
			}
		}).then(function(response){
			successMsg('업무할당 성공!', item.owner+' 에게 업무를 할당하였습니다.');
			gantt.load("${pageContext.request.contextPath}/getGantt");

			var responseData = JSON.parse(response.responseText);
			var newTaskId = responseData.task.id;
			gantt.changeTaskId(id, newTaskId);

		}).catch(function(error){
			errorMsg('업무할당 실패', '에러메세지 : '+error);
		})
});

gantt.attachEvent("onAfterLinkAdd", function(id, link){
	gantt.ajax.post("${path}/insTaskDep", link)
			.then(function(response) {
				toastMsg('success', '업무 종속성 부여 성공!');
			})
			.catch(function(error) {
				errorMsg('종속성 부여 실패', '에러메세지 : '+error);
			});
});

gantt.attachEvent("onLinkDblClick", function (id) {
	if (userRole === 'ADM' || memberKey === creater) {
		confirmMsg(
				'업무 종속성 삭제',
				'이 종속성을 삭제하시겠습니까?',
				'error',
				function() {
					gantt.deleteLink(id);
				},
				function() {
				}
		);
	}
	return false;
});

gantt.attachEvent("onAfterLinkDelete", function(id, link){
	gantt.ajax.post("${path}/delTaskDep", link)
			.then(function(response) {
				successMsg('업무 종속성 삭제 성공!');
			})
			.catch(function(error) {
				errorMsg('종속성 삭제 실패', '에러메세지 : '+error);
			});
})

gantt.attachEvent("onAfterTaskUpdate", function(id, item){
	var dateFormat = gantt.date.date_to_str("%Y-%m-%d");
	var startDate = dateFormat(item.start_date);
	var endDate = dateFormat(item.end_date);
	if(item.type === 'project'){
		gantt.ajax.post({
			url:"${path}/uptTask",
			data: {
				id: item.id,
				member_key: -10,
				progress: item.progress,
				detail: item.detail,
			}
		}).then(function(response){
				successMsg('업무 업데이트 성공!', '업무가 성공적으로 업데이트 되었습니다.');
		}).catch(function(error){
			errorMsg('업무할당 실패', '에러메세지 : '+error);
		});
	}else if(item.type === "task"){
		if(item.selectedUserKey) {
			gantt.ajax.post({
				url:"${path}/uptTask",
				data: {
					id: item.id,
					member_key: item.selectedUserKey,
					text: item.text,
					start_date: startDate,
					end_date: endDate,
					duration: item.duration,
					progress: item.progress,
					detail: item.detail,
				}
			}).then(function(response){
				successMsg('업무 업데이트 성공!', '업무가 성공적으로 업데이트 되었습니다.');
				delete item.selectedUserKey;
			}).catch(function(error){
				errorMsg('업무 업데이트 실패', '에러메세지 : '+error);
			});
		}else{
			gantt.ajax.post({
				url:"${path}/uptTask",
				data: {
					id: id,
					member_key: -1,
					start_date: startDate,
					end_date: endDate,
					duration: item.duration,
					progress: item.progress,
				}
			}).then(function(response){
				toastMsg('success', '업무 업데이트 성공!');
			}).catch(function(error){
				errorMsg('업무 업데이트 실패', '에러메세지 : '+error);
			});
		}
	}
});

gantt.attachEvent("onTaskOpened", function (id){
	updateTaskOpenStatus(id, true);
});
gantt.attachEvent("onTaskClosed", function (id){
	updateTaskOpenStatus(id, false);
});

gantt.init("gantt_here");
gantt.load("${pageContext.request.contextPath}/getGantt");
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