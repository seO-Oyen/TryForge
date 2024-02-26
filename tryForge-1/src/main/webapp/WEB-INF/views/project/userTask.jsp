<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="${path}/template/module/module_main.jsp" flush="true"/>
<style>
    #myModal .modal-dialog {
        max-width: 50%; /* 모달의 최대 너비를 80%로 설정 */
    }

    #myModal02 .modal-dialog {
        max-width: 50%; /* 모달의 최대 너비를 80%로 설정 */
    }

    #myModal02 .form-group {
        margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
        margin-left: 3%;
        margin-right: 8%;
    }

    /* 입력 요소 여백 조절 */
    #myModal .form-group {
        margin-bottom: 15px; /* 각 입력 요소 아래 여백 조절 */
        margin-left: 3%;
        margin-right: 8%;
    }
    #myModal .modal-dialog {
        max-width: 50%; /* 모달의 최대 너비를 80%로 설정 */
    }

    #myModal .form-control {
        margin-right: 3%; /* 입력 요소 오른쪽 여백 조절 */
        margin-left: 3%; /* 입력 요소 왼쪽 여백 조절 */
    }

    #searchResults {
        height: 150px;
        overflow-y: auto;
    }

    dropdown-menu {
        display: flex;
        flex-direction: column;
    }
    .dropdown-item {
        display: flex;
    }
    .dropdown-item::before {
        display: block;
        content: '▶';
        width: 20px;
        height: 20px;
    }

</style>
<script>
    $(document).ready(function () {
        $("#clsBtn").click(function () {
            $("#modelFrm")[0].reset()
        })
        $("#xBtn").click(function () {
            $("#modelFrm")[0].reset()
        })
        $("#clsBtn02").click(function () {
            $("#modelFrm")[0].reset()
        })
        $("#xBtn02").click(function () {
            $("#modelFrm")[0].reset()
        })
        $("#riskRegBtn").click(function(){
            regRisk();
        })
    })
    // 상세 모달창
    function openDetail(id) {
        console.log(id)
        $.ajax({
            url: "${path}/taskDetail",
            data: "id=" + id,
            dataType: "json",
            success: function (data) {
                var detail = data.taskDetail
                $("#modalFrm [name=text]").val(detail.text)
                $("#modalFrm [name=detail]").val(detail.detail)
                var startDate = new Date(detail.start_date);
                startDate.setDate(startDate.getDate() + 1);
                var formattedStartDate = startDate.toISOString().split('T')[0];
                var endDate = new Date(detail.end_date);
                endDate.setDate(endDate.getDate() + 1);
                var formateedendtDate = endDate.toISOString().split('T')[0];
                $("#modalFrm [name=start_date]").val(formattedStartDate)
                $("#modalFrm  [name=end_date]").val(formateedendtDate)
                if (detail.confirm === '1' || detail.confirm === 1) {
                    // 확인여부 확인해 확인한 업무 모달창 구성
                    $("#confirmBtn").hide();
                    $("#proTitle").text("진행중인 업무")
                    $(".modal-title").text("Ongoing Task")
                } else {
                    // 확인여부 확인해 새 업무 할당시 모달창 구성
                    $("#confirmBtn").show();
                    $("#proTitle").text("새 업무")
                    $(".modal-title").text("New Task")
                }
                $("#myModal").modal('show');
                $("#confirmBtn").click(function () {
                    uptConfirm(id)
                })
            },
            error: function (err) {
                console.log(err)
            }
        })

    }
    // PL 업데이트
    function uptConfirm(id) {
    	console.log(id)
        $.ajax({
            url: "${path}/uptConfirm",
            data: "id=" + id,
            dataType: "json",
            success: function (data) {
                var uptMsg = data.uptMsg;
                if (uptMsg != null) {
                    Swal.fire({
                        title: uptMsg,
                        text: ' ',
                        icon: 'success',
                    }).then(function () {
                        //$("#clsBtn").click();
                        window.location.reload();
                    });
                }
            },
            error: function (err) {
                console.log(err)
            }
        })
    }

    // 리스크 등록 모달창 오픈
    function showRiskModel(key,title) {
        $("#task_title").val(title)
        $("#modalFrm02 [name=task_key]").val(key)
        $("#myModal02").modal('show');
    }

    // 리스크 등록
    function regRisk(){
        $.ajax({
            url:"${path}/insRisk",
            data:$("#modalFrm02").serialize(),
            dataType:"json",
            success:function(data){
                var insMsg = data.insMsg;
                if (insMsg != null) {
                    Swal.fire({
                        title: '등록성공',
                        text: insMsg,
                        icon: 'success',
                    }).then(function () {
                        Swal.close();
                        window.location.reload();
                    });

                }
            },
            error:function(err){
                console.log(err)
            }

        })
    }

</script>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <!-- 새 업무 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">New Task</h4>
                        <!-- 새 업무 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 2000px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>업무명</th>
                                    <th>업무시작일</th>
                                    <th>업무종료일</th>
                                    <th>전달자</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="tlist" items="${getTask}" varStatus="sts">
                                    <c:if
                                            test="${tlist.member_key == loginMem.member_key && tlist.confirm == 0}">

                                        <tr class="member-row" data-member-key="${tlist.id}" ondblclick='openDetail("${tlist.id}")'>
                                            <td>${tlist.text}</td>
                                            <td>${tlist.start_date}</td>
                                            <td>${tlist.end_date}</td>
                                            <td>${tlist.assignor}</td>
                                            <td>
                                                <button type="button" class="btn btn-open" onclick='showRiskModel("${tlist.id}","${tlist.text}")'
                                                        style="background-color: #007FFF; color: white;">
                                                    리스크등록
                                                </button>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${empty getTask}">
                                        <tr>
                                            <td>새로운 업무가 없습니다.</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 새 업무 end -->

            <!-- 진행중인 업무 -->
            <div class="col-md-12" style="margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Ongoing Task</h4>
                        <!-- 진행중인 업무 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 2000px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>업무명</th>
                                    <th>업무시작일</th>
                                    <th>업무종료일</th>
                                    <th>전달자</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="tlist" items="${getTask}" varStatus="sts">
                                    <c:if
                                            test="${tlist.member_key == loginMem.member_key && tlist.confirm == 1}">

                                        <tr class="task-row" data-member-key="${tlist.id}" ondblclick='openDetail("${tlist.id}")'>
                                            <td>${tlist.text}</td>
                                            <td>${tlist.start_date}</td>
                                            <td>${tlist.end_date}</td>
                                            <td>${tlist.assignor}</td>
                                            <td>
                                                <button type="button" class="btn btn-open" onclick='showRiskModel("${tlist.id}","${tlist.text}")'
                                                        style="background-color: #007FFF; color: white;">
                                                    리스크등록
                                                </button>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${empty getTask}">
                                        <tr>
                                            <td>진행중인 업무가 없습니다.</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 진행중인 업무 end -->
        </div>

        <!-- The Modal -->
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h2 class="modal-title">New Task</h2>

                        <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div style="display: flex;">
                            <h3 id=proTitle>새 업무</h3>

                        </div>

                    </div>
                    <form class="forms-sample" id="modalFrm">
                        <div class="form-group">
                            <label for="exampleInputUsername1">업무이름</label> <input
                                name="text" type="text" class="form-control" placeholder="title">
                        </div>
                        <div class="form-group">
                            <label for="exampleTextarea1">상세내용</label>
                            <textarea class="form-control" rows="4" name="detail"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">업무 시작일</label> <input
                                name="start_date" type="date" class="form-control" placeholder="startDate">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputConfirmPassword1">업무 종료일</label>
                            <input name="end_date" type="date" class="form-control" placeholder="endDate">
                        </div>
                    </form>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="mx-auto">
                            <button type="button" class="btn btn-" id="confirmBtn"
                                    onclick="insTask()"
                                    style="background-color: #007FFF; color: white;">확인완료
                            </button>

                            <button type="button" class="btn btn-danger" data-dismiss="modal"
                                    id="clsBtn">닫기
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- 리스크 등록 모달장 -->
        <div class="modal" id="myModal02">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h2 class="modal-title">Risk</h2>

                        <button type="button" class="close" data-dismiss="modal" id="xBtn02">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div style="display: flex;">
                            <h3>리스크 등록</h3>

                        </div>

                    </div>
                    <form class="forms-sample" id="modalFrm02">
                        <input type="hidden" name="project_key" value="${projectMem.project_key}">
                        <input type="hidden" name="task_key">
                        <div class="form-group">
                            <label for="exampleInputUsername1">프로젝트 명</label> <input value="${projectMem.title}"
                                                                                     type="text" class="form-control" placeholder="project_title">
                        </div>
                        <div class="form-group">
                            <label for="exampleTextarea1">업무 명</label>
                            <input type="text" class="form-control" placeholder="task_title" id="task_title">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">리스크 등록자</label> <input value="${loginMem.member_name}"
                                                                                      name="registrant" type="text" class="form-control" placeholder="risk_registrant">
                        </div>
                        <div class="form-group">

                            <label for="exampleInputConfirmPassword1">리스크 종류</label>

                            <select name="type" class="form-control form-control-lg">
                                <option value="">선택</option>
                                <option value="요구사항 관련 리스크">▶ [요구 사항 관련 리스크] 부정확한 또는 모호한 요구 사항 / 요구 사항 변경의 빈도와 범위</option>
                                <option value="일정 및 자원 관리 리스크">▶ [일정 및 자원 관리 리스크] 프로젝트 일정의 불명확성 또는 너무 낙관적인 일정 설정 / 자원(인력, 장비 등)의 부족 또는 부적절한 할당</option>
                                <option value="기술적 리스크">▶ [기술적 리스크] 기술 스택의 선택과 변경에 따른 위험 / 기술적 제약 사항 또는 새로운 기술 도입에 따른 불확실성</option>
                                <option value="품질 및 테스트 관련 리스크">▶ [품질 및 테스트 관련 리스크] 테스트 커버리지 부족으로 인한 결함 감지 부족 / 테스트 환경의 부적절성 또는 제한</option>
                                <option value="외부 의존성 및 파트너 관리 리스크">▶ [외부 의존성 및 파트너 관리 리스크] 외부 공급 업체의 서비스 및 제품에 대한 의존도 / 외부 파트너 또는 공급 업체의 안정성과 신뢰성</option>
                                <option value="보안 및 개인 정보 보호 리스크">▶ [보안 및 개인 정보 보호 리스크] 보안 취약점 및 데이터 유출 위험 / 개인 정보 보호 및 규정 준수 위반 가능성</option>
                                <option value="의사소통 및 협업 관련 리스크">▶ [의사소통 및 협업 관련 리스크] 팀 내외의 의사소통 및 협업 문제 / 분산된 팀의 조정 및 협력의 어려움</option>
                                <option value="변경 및 유지보수 관련 리스크">▶ [변경 및 유지보수 관련 리스크] 변경 관리 프로세스의 부재 또는 부족 / 유지보수 요구 사항의 부족 또는 변경 빈도</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="exampleInputConfirmPassword1">발생 가능성</label>
                            <select name="possibility" class="form-control form-control-lg">
                                <option value="">선택</option>
                                <option>상</option>
                                <option>중</option>
                                <option>하</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputConfirmPassword1">처리 우선순위</label>
                            <select name="priority" class="form-control form-control-lg">
                                <option value="">선택</option>
                                <option value="1">1 순위</option>
                                <option value="2">2 순위</option>
                                <option value="3">3 순위</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="exampleTextarea1">상세설명</label>
                            <textarea class="form-control" id="detail" rows="4" name="detail"></textarea>
                        </div>

                    </form>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="mx-auto">
                            <button type="button" class="btn btn-" id="riskRegBtn"
                                    style="background-color: #007FFF; color: white;">리스크 등록
                            </button>

                            <button type="button" class="btn btn-danger" data-dismiss="modal"
                                    id="clsBtn02">닫기
                            </button>
                        </div>
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