<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
#chatList {
	/* background-color: white; */
}

.chatScrean {
	/* margin: 0 auto; */
	
}

.chat {
	/* border: 1px solid; */
	text-align: left;
}

.${loginMem.member_id} {
	/* color: red; */
	/* border: 1px solid; */
	width: auto;
	text-align: right;
}

.sendMsg {
	border-radius: 10px;
	width: 600px;
}

.inputbox {
	display:inline-block;
}
</style>

<script>
$(document).ready(function(){
	wsocket = new WebSocket(
		"ws:localhost:1111/ws/chat"	
	)
	
	wsocket.onmessage = function(evt){
		// 서버에서 push 접속한 모든 client에 전송..
		revMsg(evt.data) // 메시지 처리 공통 함수 정의				
	}
	
	/* var idVal = "${loginMem.member_name}"
	wsocket = new WebSocket(
		"ws:localhost:1111/ws/chat"	
	)
	
	wsocket.onopen = function(evt){
		console.log(evt)
		
		wsocket.send(idVal+"님 접속하셨습니다!")
	}
	wsocket.onmessage = function(evt){
		// 서버에서 push 접속한 모든 client에 전송..
		revMsg(evt.data) // 메시지 처리 공통 함수 정의				
	} */
})

function revMsg(msg){
	var calName = "chat"
	var msgArr = msg.split("/")
	console.log(msgArr)
	
	var msgObj = $("<td></td>").append(msgArr[3]).attr("class",
			calName)
			
	$("#" + msgArr[0]).text(msgArr[3])
		
}

function sendMsg(){
	wsocket.send("${loginMem.member_id}" + ":"+$("#sendMsg").val())
	$("#sendMsg").val("")
}

function clickList(listKey) {
	alert("채팅방으로 이동합니다. " + listKey)
	location.href="${path}/chat/" + listKey
	
}

</script>
<div class="main-panel">
<div class="content-wrapper">
<div class="col-md-12">
<div class="row">

	<div class="col-12 grid-margin stretch-card">
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
						<tr>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="chat" items="${chatMap}" varStatus="status">
							<tr
								onclick="clickList(${chatList[status.index].chatlist_key})">
								<td>${chat.key}</td>
								<c:choose>
									<c:when test="${lastChat.containsKey(chatList[status.index].chatlist_key)}">
										<td id="${chatList[status.index].chatlist_key}">${lastChat.get(chatList[status.index].chatlist_key)}</td>
									</c:when>
									<c:otherwise>
										<td id="${chatList[status.index].chatlist_key}">${chat.value}</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- <div class="col-md-9 grid-margin stretch-card">
		<div class="card">
			<div class="card-body d-flex flex-column justify-content-between">
				<div
					class="d-flex justify-content-between align-items-center mb-2">
					<p class="mb-0">채팅 내용</p>
				</div>
				
				<div id="chatScrean" >
					
				</div>
				<div class="form-group" style="display: flex;">
					<input class="typeahead sendMsg" id="sendMsg" />
					<input type="button" class="btn btn-info" value="전송" onclick="sendMsg()">
				</div>
				
			</div>
		</div>
	</div> -->
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