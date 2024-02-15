<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="${path}/template/module/module_myPage.jsp"
	flush="true" />

<style>
.card {
	text-align:center;
}

.chat {
	text-align: left;
}

.${loginMem.member_id} {
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

#createChat {
	margin-top: 15px;
}

table {
	cursor: pointer;
}

#myModal .modal-dialog {
    max-width: 50%;
}

/* 입력 요소 여백 조절 */
#myModal .form-group {
    margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
    margin-left: 3%;
    margin-right: 8%;
}

#myModal .form-control {
    margin-right: 3%; /* 입력 요소 오른쪽 여백 조절 */
    margin-left: 3%; /* 입력 요소 왼쪽 여백 조절 */
}

</style>

<script>
var selectedMemberKeys = [];
$(document).ready(function(){
	
	wsocket = new WebSocket(
		"ws:localhost:1111/tryForge/chat"
		
		// 서버컴 주소
		// "ws:211.63.89.67:1111/tryForge/chat"
	)
	
	wsocket.onmessage = function(evt){
		revMsg(evt.data) // 메시지 처리 공통 함수 정의				
	}
	
	$(document).on('click', '.btn-open', function() {
		// 모달 열기
		$("#myModal").modal('show');
		$("[name=member_name]").val("")
		
		schMem();
		
		$("#regBtn").click(function () {
            event.preventDefault();
            // 공백 유효성 체크
            if ($("#selectMem tr").val() == null) {
                return;
            }
            console.log(getAllMemberKeys())
            
            $.ajax({
                // 등록 controller 호출
                url: "${path}/createChat",
                type: "POST",
                data: $("#modalFrm").serialize(),
                dataType: "json",
                success: function (data) {
                    Swal.fire({
                        title: '등록 성공',
                        text: ' ',
                        icon: 'success',
                    }).then(function () {
                        $("#clsBtn").click();
                        window.location.reload();
                    });
                },
                error: function (err) {
                    console.log(err)
                }
            })
        })
	})
	
	$("[name=member_name]").keyup(function () {
        schMem();
    })
	
})

function getAllMemberKeys() {
    var member_key = [];

    $("#selectMem tr").each(function () {
        var memberKey = $(this).data("member-key");
        member_key.push(memberKey);
    });

    // hidden 필드의 값을 업데이트
    $("#hiddenMemberKey").val(member_key);
    return member_key;
}

function deleteMem(buttonElement) {
    // 삭제 버튼이 속한 행을 찾아서 삭제
    var row = $(buttonElement).closest("tr");
    var member_key = row.data("member-key");
    row.remove();
}

function revMsg(msg){
	var calName = "chat"
	var msgArr = msg.split("/")
	console.log(msgArr)
	
	var msgObj = $("<td></td>").append(msgArr[3]).attr("class",
			calName)
			
	$("#" + msgArr[0]).text(msgArr[3])
		
}

function clickList(listKey) {
	location.href="${path}/chat/" + listKey
}

function schMem() {
    $.ajax({
        url: "${path}/schMem",
        data: $("#modalFrm").serialize(),
        dataType: "json",
        success: function (data) {
            var memList = data.memList;
            var html = "";
            $(memList).each(function (idx, member) {
                const today = new Date();
                const endDate = new Date(member.end_date);
                
                if ("${loginMem.member_key}" != member.member_key) {
	                var member_key = member.member_key;
		                html += "<tr ondblclick='selectMem(\""
		                    + member_key
		                    + "\", \""
		                    + member.member_name
		                    + "\", \""
		                    + member.member_email
		                    + "\")' > ";
		                html += "<td>"
		                    + member.member_name
		                    + "</td>";
		                html += "<td>"
		                    + member.member_email
		                    + "</td>";
		
		                html += "</tr>";
                }
                
            });

            $("#addMem").html(html);
        },
        error: function (err) {
            console.log(err);
        }
    });
}

function selectMem(member_key, member_name, member_email) {
    //console.log("Member Key Type:", typeof member.member_key);
    console.log("Selected Member Key:", member_key);
    console.log("Member Name:", member_name);
    console.log("Member Email:", member_email);

    var row = "<tr data-member-key='" + member_key + "'>";
    row += "<td>" + member_name + "</td>";
    row += "<td>" + member_email + "</td>";
    row += "<td><button class='btn btn-danger' type='button' onclick='deleteMem(this)'>삭제</button></td>";
    row += "</tr>";

    $("#selectMem").append(row);
}

</script>
<div class="main-panel" onselectstart="return false" ondragstart="return false">
<div class="content-wrapper">
<div class="col-md-12">
<div class="row">

	<div class="col-12 grid-margin stretch-card">
		<div class="card">
			<!-- <div class="card-body d-flex flex-column justify-content-between"> -->
			<div class="card-body">
				<div
					class="d-flex justify-content-between align-items-center mb-2">
					<p class="mb-0">채팅 리스트</p>
				</div>
				<table class="table table-hover"
					style="width: 95%; margin-left: 4%;">
					<col width="30%">
					<col width="70%">
					<thead>
						<tr>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="chat" items="${chatMap}" varStatus="status">
							<tr
								ondblclick="clickList(${chatList[status.index].chatlist_key})">
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
				<button id="createChat" type="button" class="btn btn-info btn-rounded btn-lg btn-open">채팅방 생성</button>
			</div>
			
		</div>
		
	</div>
	
	
</div>

</div>
</div>
</div>
	
<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

            </div>
            <form class="forms-sample" id="modalFrm" onsubmit="false;">
                <!-- 프로젝트 구성원 추가 -->
                <div class="form-group">
                    <label id="tm">채팅원 추가</label>
                    <div class="row mt-3">
                        <!-- 아래: 검색 결과 -->
                        <div class="col-12" id="bottom">
                            <input type="text" class="form-control mb-2" name="member_name"
                                   placeholder="검색">
                            <div id="searchResults"
                                 style=" overflow-y: auto; margin-left: 3%; width: 100%; max-height: 300px;">
                                <table class="table table-hover">
                                    <tbody id="addMem">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- 위: 선택한 구성원 -->
                        <div class="col-12 mb-2" id="top">
                            <div id="selectMember"
                                 style="height: 200px; overflow-y: auto; width: 100%; margin-left: 3%;">
                                <input type="hidden" name="member_key" value=""
                                       id="hiddenMemberKey">
                                <table class="table table-hover">
                                    <tbody id="selectMem">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


            </form>


            <!-- Modal footer -->
            <div class="modal-footer">
                <div class="mx-auto">
                    <button type="button" class="btn" id="regBtn"
                            style="background-color: #007FFF; color: white;">등록
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"
                            id="clsBtn">닫기
                    </button>
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