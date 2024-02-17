<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
.main-panel {
	overflow: hidden;
}

#chatScrean {
	height: 500px;
	overflow: auto;
}

.chat {
	/* border: 1px solid; */
	text-align: left;
	padding-left: 10px;
	padding-right: 10px;
	padding-bottom: 10px;
}

.chat span {
	background-color: white;
	border: 1px solid white;
	width: auto;
	padding : 5px;
	border-radius: 10px 10px 10px 0px;
}

.${loginMem.member_id} {
	display: block;
	width: auto;
	text-align: right;
	padding: 10px;
}

.${loginMem.member_id} span {
	background-color: #FFEB33;
	border: 1px solid #FFEB33;
	width: auto;
	text-align: right;
	padding : 5px;
	border-radius: 10px 10px 0px 10px;
}

.sendMsg {
	border-radius: 10px;
	width: 600px;
	margin-right: 20px;
}

.inputbox {
	display:inline-block;
}
</style>

<script>
$(document).ready(function(){
	var idVal = "${loginMem.member_name}"
	$('#chatScrean').scrollTop($('#chatScrean')[0].scrollHeight)
	
	wsocket = new WebSocket(
		// 경로 수정
		// 내컴퓨터 서버주소
		// "ws:192.168.10.110:1111/ws/chat"	
		"ws:localhost:1111/tryForge/chat"
		
		// 서버컴 주소
		// "ws:211.63.89.67:1111/tryForge/chat"
	)
	
	wsocket.onmessage = function(evt){
		revMsg(evt.data) // 메시지 처리 공통 함수 정의				
	}
	
	$("#sendMsg").on("keyup",function(key){
		if(key.keyCode==13) {
			sendMsg()
		}
	});
	
})

var userName;

function revMsg(msg){
	var calName = "chat"
	var msgArr = msg.split("/")

	// 본인이 보낸 메세지면 오른쪽정렬, 아니면 왼쪽정렬
	if ("${loginMem.member_id}" == msgArr[1]){
		calName = "${loginMem.member_id}"
		userName = msgArr[2]
	} else if(userName != msgArr[2]) {
		// 연속으로 보낸 일시 이름 안나올수 있게
		var sendMem = $("<div class='chat'></div>").text(msgArr[2])
		userName = msgArr[2]
		$("#chatScrean").append(sendMem)
	}
	
	// 메세지 내용과 시간 넣기
	var msgObj = $("<div></div>").append("<span>" + msgArr[3] + "</span>" 
			+ "<div style='padding-top: 5px; color: gray;'>" + msgArr[4] + "</div>").attr("class",
			calName)
	
	$("#chatScrean").append(msgObj)
	
	$('#chatScrean').scrollTop($('#chatScrean')[0].scrollHeight)
}

function sendMsg(){
	if($("#sendMsg").val() == "") {
		return false;
	}
	var date = new Date()
	var yyyy = date.getFullYear()
	var mm = date.getMonth() + 1
	mm = mm >= 10 ? mm : '0' + mm
	var dd = date.getDate();
	dd = dd >= 10 ? dd : '0' + dd;
	var hour = date.getHours()
	var minute = date.getMinutes()
	hour = hour >= 10 ? hour : '0' + hour
    minute = minute >= 10 ? minute : '0' + minute
	
	wsocket.send("${chats[0].chatlist_key}/${loginMem.member_id}/${loginMem.member_name}/" 
			+ $("#sendMsg").val() + "/" + yyyy + '-' + mm + '-' + dd + " " + hour + ":" + minute)
	$("#sendMsg").val("")
}

</script>
<div class="main-panel">
<div class="content-wrapper">
<div class="col-md-12">
<div class="row">
	<div class="col-md-12 grid-margin stretch-card">
		<div class="card" style="background-color: #BACEE0;">
			<div class="card-body d-flex flex-column justify-content-between"
				style="min-height: 600px;">
				<div
					class="d-flex justify-content-between align-items-center mb-2">
					<p class="mb-0">채팅방</p>
				</div>
				<div id="chatScrean" class="card-body">
					<c:set var="lastName" value="" />
					<c:set var="lastDate" value="" />
					
					<c:forEach var="chat" items="${chats}" varStatus="status">
						
						<c:if test="${memList[status.index].member_id ne loginMem.member_id}">
							
							<c:if test="${lastName ne memList[status.index].member_id}">
								<div class="chat text">${memList[status.index].member_name}</div>
							</c:if>
						</c:if>
						
						<div class="chat ${memList[status.index].member_id}">
							<c:if test="${chat.chat_detail ne null}">
								<span>${chat.chat_detail}</span>
								<div style="padding-top: 5px; color: gray;">${chat.send_time}</div>
							</c:if>
							<%-- <c:choose>
								<c:when test="${chat.send_time ne chats[status.index - 1].send_time}">
									<div>${chat.send_time}</div>
								</c:when>
								<c:when test="${chat.send_time eq chats[status.index - 1].send_time}">
									<div>${chat.send_time}</div>
								</c:when>
								
							</c:choose> --%>
						</div>
						<div>
							
						</div>
						
						<c:set var="lastName" value="${memList[status.index].member_id}" />
						
					</c:forEach>
					
				</div>
				<div class="form-group" style="display: flex; margin: auto">
						<input class="typeahead sendMsg" id="sendMsg" />
						<input type="button" class="btn btn-info" value="전송" onclick="sendMsg()">
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