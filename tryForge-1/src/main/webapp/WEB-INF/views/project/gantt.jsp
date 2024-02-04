<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="${path}/template/module/module_main.jsp" flush="true" />
<script>
	function successMsg(title, text) {
		Swal.fire({
			icon: 'success',
			title: title,
			text: text,
		});
	}

	function errorMsg(title, text) {
		Swal.fire({
			icon: 'error',
			title: title,
			text: text,
		});
	}
</script>
<style>
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
gantt.setWorkTime({ day: 6, hours: false }); // 토요일
gantt.setWorkTime({ day: 0, hours: false }); // 일요일
gantt.config.duration_unit = "day"; // duration (기간) 쪽 단위 지정 hour 로 할 경우 시간단위로 조절가능
gantt.config.work_time = true; // 워크타임 적용(주말은 기간 합산 X)
// locale 설정 적용(지역에 맞게 번역설정)
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
        confirm_closing: "", // 변경사항이 손실될 수 있습니다. 계속하시겠습니까?
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
// 실제 표현되는 날짜 단위설정과 휴일설정
gantt.config.scales = [
    {unit: "month", step: 1, format: "%Y년 %m월"}, // 월 단위 설정, 포맷 변경
	{unit: "day", step: 1, format: "%d %D", css: function(date) { // day 포맷 및 휴일설정
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

// 기존 설정들 유지
show_empty_state = true;
// project에 대한 시작일과 종료일 (task 테이블에 저장된 값 불러옴)
gantt.config.start_date = new Date("${date.start_date}");
gantt.config.end_date = new Date("${date.end_date}+1");
gantt.config.autosize = "y"; // 간트차트 사이즈 자동조절

// 간트차트에서 YYYY-MM-DD 형식으로 출력하기 위함.
gantt.config.date_format = "%Y-%m-%d";
// 좌측컬럼 date 형식 포맷

gantt.config.date_grid = "%M %d일";

gantt.templates.task_time = function(start, end) {
   // 날짜 포맷을 정의합니다 (예: "%Y년 %m월 %d일")
    var dateFormat = gantt.date.date_to_str("%Y년 %m월 %d일");

    // 포맷된 시작일과 완료일을 반환합니다
    return dateFormat(start) + " - " + dateFormat(end);
};
// 프로젝트 참여중인 멤버리스트 불러와서 담당자로 선택할 수 있도록 설정
var users = [];
<c:forEach var="mem" items="${memList}">
	users.push({key: "${mem.member_key}", label: "${mem.owner}"});
</c:forEach>

// task 라이트박스 섹션
gantt.config.lightbox.sections = [
	{name: "description", height: 47, map_to: "text", type: "textarea", focus: true},
	// {name: "type", height: 40, map_to: "type", type: "typeselect"},
	{name: "owner", height: 40, map_to: "owner", type: "select", options: users},
	{name: "time",map_to: "auto", type: "time", time_format:["%Y","%m","%d"]},
	{name: "detail", height: 47, map_to: "detail", type: "textarea"}
	// {name: "hide_bar", type: "checkbox", map_to: "hide_bar"}
];

// project 눌렀을 때 뜨는 섹션인데 이건 프로젝트에 대한 정보가 보이도록 설정해야할듯 (수정..불가능하게?) 수정여부는 나중에 결정
gantt.config.lightbox.project_sections=[
    {name:"description", height:100, map_to:"text", type:"textarea", focus:true},
    {name:"time",        height:72, map_to:"auto", type:"duration"}
];

// 차트 바 길이
gantt.config.scale_height = 50;

// 날짜 형식 템플릿 정의
gantt.templates.date_scale = function(date){
    var formatFunc = gantt.date.date_to_str("%d %l");
    return formatFunc(date);
};
gantt.templates.lightbox_header = function(start, end, task) {
	return task.text;
};
// 왼쪽 컬럼
gantt.config.columns=[
    {name:"text",       label:"업무명",  tree:true, width:180 }, // 업무명 너비를 200px로 설정
    {name:"start_date", label:"시작일", align: "center", width:80 },
    {name:"duration",   label:"기간",   align: "center", width:40 },
    {name:"owner",      label:"담당자", align: "center", width:70 },
    {name:"add",        label:"", width:44 }
];
// 실제로 데이터를 넣어야 할 task 쪽.
/*
color 속성 추가 가능
label 속성은 높음 중간 낮음 이런식으로 작업 우선순위 표현가능
parrent 중요함. 부모속성.
progressColor <- 진행상태 나타내는 색상
*/
/*

	    // 종속성 나타내는 링크 
	    // source : 시작 테스크 id, target : 종료 테스크 id, type : 연결선 유형
	    // id 끼리 연결 한 다음에 이게 무슨 타입인지 넣어주면 됨
	    // 0 : Finish to Start (FS)
	    // 1 : Start to Start (SS)
	    // 2 : Finish to Finish (FF)
	    // 3 : Start to Finish (SF)
	    links: [
//	    	{id: 1, source: 1, target: 2, type: "0"}	    	
	    ]
	};
*/
// 라이트박스 save 시 유효성 검증 + 오류메세지 출력
gantt.attachEvent("onLightboxSave", function(id, task, is_new){
	if (!task.text || !task.detail) {
		gantt.hideLightbox();
		if(is_new) {
			gantt.deleteTask(id);
		}
		errorMsg('경고!', '업무명과 업무설명은 반드시 입력해야 합니다.');

		return false; // 작업 추가 취소
	}
	return true; // 작업 추가 계속
});
gantt.attachEvent("onAfterTaskAdd", function(id, item){
	var dateFormat = gantt.date.date_to_str("%Y-%m-%d");
	var startDate = dateFormat(item.start_date);
	var endDate = dateFormat(item.end_date);
	gantt.ajax.post({
		url:"${path}/insTask",
		data:{
			text:item.text,
			member_key:item.owner,
			start_date:startDate,
			end_date:endDate,
			duration:item.duration,
			progress:item.progress,
			parent:item.parent,
			// type:item.type,
			// rollup:item.rollup,
			// open:item.open,
			detail:item.detail,
		}

			}).then(function(response){
				var ownerName = users.find(function(user){
					return user.key == item.owner;
				}).label

				if(ownerName) {
					var task = gantt.getTask(id);
					task.owner = ownerName;
					gantt.updateTask(id);
				}
				successMsg('업무할당 성공!', task.owner+'에게 업무를 할당하였습니다.');
			})
			.catch(function(error){
				errorMsg('업무할당 실패', '에러메세지 : '+error);
			});
});

gantt.attachEvent("onAfterLinkAdd", function(id, link){
	gantt.ajax.post("${path}/insTaskDep", link)
			.then(function(response) {
				successMsg('업무 종속성 부여 성공!');
			})
			.catch(function(error) {
				errorMsg('종속성 부여 실패', '에러메세지 : '+error);
			});
});

/*

{
    id: link.id,          // 종속성 고유 ID
    source: link.source,  // 시작 작업 ID
    target: link.target,  // 종료 작업 ID
    type: link.type       // 종속성 유형 (예: 0 - 종료-시작, 1 - 시작-시작 등)
}
gantt.attachEvent("onAfterLinkDelete", function(id, link){
    gantt.ajax.post("/deleteDependency", {id: link.id})
        .then(function(response) {
            // 성공적으로 삭제되었을 때의 처리
        })
        .catch(function(error) {
            // 오류 처리
        });
});

gantt.attachEvent("onAfterTaskAdd", function(id, item){
    // Ajax 요청으로 서버에 업무 추가
});
gantt.attachEvent("onAfterTaskUpdate", function(id, item){
    // Ajax 요청으로 서버에 업무 수정
});
gantt.attachEvent("onAfterTaskDelete", function(id){
    // Ajax 요청으로 서버에 업무 삭제
}); 
 
 */
 /*
 gantt.ajax.get({
	    url: "${pageContext.request.contextPath}/getGantt",
	    //headers: {
	     //   "Authorization": "Token YOUR_AUTH_TOKEN"
	    //}
	}).then(function (xhr) {
	    // 서버 응답을 JSON 형식으로 파싱
	    var data = JSON.parse(xhr.responseText);
	    // Gantt 차트에 데이터 로드
	    gantt.parse(data);
	}).catch(function (error) {
	    // 오류 처리
	    console.error("Error loading data: ", error);
	}); 
*/ 
gantt.init("gantt_here"); // 간트 로딩 
gantt.load("${pageContext.request.contextPath}/getGantt"); 
//gantt.parse(tasks); // task 로딩
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