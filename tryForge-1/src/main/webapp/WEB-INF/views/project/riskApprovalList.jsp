<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="${path}/template/module/module_main.jsp" flush="true"/>
<style>
    .card-title {
        font-size: 20px;
        font-weight: bold;
    }
    #myModal .modal-dialog {
        max-width: 50%; /* 모달의 최대 너비를 80%로 설정 */
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
    $(document).ready(function () {
        // 담당자 지정된 거 가져오기
        var pj = "${projectMem.project_key}"
        var member_name = "${loginMem.member_name}"
        var vm = Vue.createApp({
            name: "App",
            data() {
                return {
                    rlist: [], name: member_name, riskApprovalData: [], risk_key: 0, risk_response_key: 0, riskArr:[]
                };
            },
            created() {
                this.contactRisk()
                this.riskAppInfo()
            },
            methods: {
                contactRisk() {
                    var url = "${path}/rlist01";
                    this.rlist = []; // 초기화
                    var it = this
                    axios.get(url, {params: {project_key: pj}}).then((response) => {
                        it.rlist = response.data.rlist01;
                    });
                },
                riskAppInfo() {
                    var url = "${path}/raInfo";
                    var it = this
                    axios.get(url).then((response) => {
                        it.riskApprovalData = [];
                        it.riskApprovalData = response.data.raInfo;
                    });
                },
                formatDate(dateString) {
                    var date = new Date(dateString);
                    date.setDate(date.getDate() + 1);
                    return date.toISOString().split('T')[0];
                },
                goPage(event) {
                    const riskKey = event.target.dataset.riskKey;
                    const riskResponseKey = event.target.dataset.riskResponseKey;
                    location.href = "${path}/riskApproval?risk_key=" + riskKey + "&risk_response_key=" + riskResponseKey;
                },
                openPage(key){
                    var url = "${path}/rlistByRiskKey?risk_key="+key;
                    var risk_key = key;
                    console.log(key)
                    var it = this
                    it.riskArr = [];
                    axios.get(url).then((response)=>{
                        it.riskArr = response.data.risk;
                        // 모달 채우기
                        $("#myModal [name=status]").val(it.riskArr.status);
                        $("#myModal [name=task_title]").val(it.riskArr.text);
                        $("#myModal [name=registrant]").val(it.riskArr.registrant);
                        $("#myModal [name=detail]").val(it.riskArr.detail);
                        $("#myModal [name=contact]").val(it.riskArr.contact);
                        $("#myModal [name=strategy]").val(it.riskArr.strategy);
                        $("#myModal [name=response_method]").val(it.riskArr.response_method);

                        $("#myModal").modal('show');
                    }).catch((err)=>{
                        console.log(err)
                    })
                }
            }
        }).mount("#contactRisk");
    })



    // 결재중, 반려, 재상신요청 상세정보
</script>

<div class="main-panel">
    <div id="contactRisk">
        <div class="content-wrapper">
            <div class="row">

                <!-- 리스크 -->
                <div class="col-md-12" style="margin-bottom: 20px; padding-right: 0; padding-left: 0">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">발생 전 리스크</h4>
                            <!-- 결재 x 내가 담당자 & 발생전 상태 -->
                            <div class="table-responsive"
                                 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                                <table class="table table-hover" style="width: 100%;">
                                    <thead>
                                    <tr>
                                        <th>업무 명</th>
                                        <th>등록자</th>
                                        <th>등록일</th>
                                        <th>리스크 종류</th>
                                        <th>발생 가능성</th>
                                        <th>처리 우선순위</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="risk01 in riskApprovalData" @dblclick="openPage(risk01.r_risk_key)">
                                        <td v-if="risk01.contact == name && risk01.status =='발생전' && (risk01.report_status == '' || risk01.report_status == null)"> {{risk01.text}}</td>
                                        <td v-if="risk01.contact == name && risk01.status =='발생전' && (risk01.report_status == '' || risk01.report_status == null)">
                                            {{risk01.registrant}}
                                        </td>
                                        <td v-if="risk01.contact == name && risk01.status =='발생전' && (risk01.report_status == '' || risk01.report_status == null)">
                                            {{formatDate(risk01.reg_date)}}
                                        </td>
                                        <td v-if="risk01.contact == name && risk01.status =='발생전' && (risk01.report_status == '' || risk01.report_status == null)">{{risk01.type}}</td>
                                        <td v-if="risk01.contact == name && risk01.status =='발생전' && (risk01.report_status == '' || risk01.report_status == null)">
                                            {{risk01.possibility}}
                                        </td>
                                        <td v-if="risk01.contact == name && risk01.status =='발생전' && (risk01.report_status == '' || risk01.report_status == null)">
                                            {{risk01.priority}}순위
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 처리중 으로 변경된 -->
                <div class="col-md-12" style="padding-right: 0; padding-left: 0; margin-bottom: 20px;">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">처리중인 리스크</h4>
                            <!-- 리스크 테이블 -->
                            <div class="table-responsive"
                                 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                                <table class="table table-hover" style="width: 100%;">
                                    <thead>
                                    <tr>
                                        <th>업무 명</th>
                                        <th>등록자</th>
                                        <th>등록일</th>
                                        <th>리스크 종류</th>
                                        <th>발생 가능성</th>
                                        <th>처리 우선순위</th>
                                        <th>결재 보고</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="risk02 in riskApprovalData" v-bind:data-risk-key01="risk02.r_risk_key" ondblclick="openPage01('risk02.r_risk_key')">
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            {{risk02.text}}
                                        </td>
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            {{risk02.registrant}}
                                        </td>
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            {{formatDate(risk02.report_date)}}
                                        </td>
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            {{risk02.type}}
                                        </td>
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            {{risk02.possibility}}
                                        </td>
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            {{risk02.priority}}순위
                                        </td>
                                        <td v-if="risk02.contact == name && risk02.status == '처리중' && (risk02.report_status == '' || risk02.report_status == null)">
                                            <button type="button" class="btn-btn"
                                                    v-bind:data-risk-key="risk02.r_risk_key"
                                                    v-bind:data-risk-response-key="risk02.rr_risk_response_key"
                                                    style="background-color: #007FFF; color: white; width: 100px; height: 30px; border: none;"
                                                    @click="goPage($event)">
                                                결재
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 결재중 -->
                <div class="col-md-12" style="padding-right: 0; padding-left: 0; margin-bottom: 20px;">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">결재중</h4>
                            <!-- 리스크 테이블 -->
                            <div class="table-responsive"
                                 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                                <table class="table table-hover" style="width: 100%;">
                                    <thead>
                                    <tr>
                                        <th>보고명</th>
                                        <th>보고자</th>
                                        <th>업무명</th>
                                        <th>보고날짜</th>
                                        <th>보고상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="risk03 in riskApprovalData" v-bind:data-risk-key01="risk03.r_risk_key" ondblclick="openPage01('risk03.r_risk_key')">
                                        <td v-if="risk03.contact == name && risk03.report_status == '결재요청'">
                                            {{risk03.title}}
                                        </td>
                                        <td v-if="risk03.contact == name && risk03.report_status == '결재요청'">
                                            {{risk03.reporter}}
                                        </td>
                                        <td v-if="risk03.contact == name && risk03.report_status == '결재요청'">
                                            {{risk03.text}}
                                        </td>
                                        <td v-if="risk03.contact == name && risk03.report_status == '결재요청'">
                                            {{formatDate(risk03.report_date)}}
                                        </td>
                                        <td v-if="risk03.contact == name && risk03.report_status == '결재요청'">
                                            {{risk03.report_status}}
                                        </td>

                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 재상신 -->
                <div class="col-md-12" style="padding-right: 0; padding-left: 0; margin-bottom: 20px;">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">재상신요청</h4>
                            <!-- 리스크 테이블 -->
                            <div class="table-responsive"
                                 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                                <table class="table table-hover" style="width: 100%;">
                                    <thead>
                                    <tr>
                                        <th>보고명</th>
                                        <th>보고자</th>
                                        <th>업무명</th>
                                        <th>보고날짜</th>
                                        <th>보고상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="risk04 in riskApprovalData">
                                        <td v-if="risk04.contact == name && risk04.report_status == '재상신요청'">
                                            {{risk04.title}}
                                        </td>
                                        <td v-if="risk04.contact == name && risk04.report_status == '재상신요청'">
                                            {{risk04.reporter}}
                                        </td>
                                        <td v-if="risk04.contact == name && risk04.report_status == '재상신요청'">
                                            {{risk04.text}}
                                        </td>
                                        <td v-if="risk04.contact == name && risk04.report_status == '재상신요청'">
                                            {{formatDate(risk04.report_date)}}
                                        </td>
                                        <td v-if="risk04.contact == name && risk04.report_status == '재상신요청'">
                                            {{risk04.report_status}}
                                        </td>

                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 결재완료 -->
                <div class="col-md-12" style="padding-right: 0; padding-left: 0; margin-bottom: 20px;">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">결재완료</h4>
                            <!-- 리스크 테이블 -->
                            <div class="table-responsive"
                                 style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                                <table class="table table-hover" style="width: 100%;">
                                    <thead>
                                    <tr>
                                        <th>보고명</th>
                                        <th>보고자</th>
                                        <th>업무명</th>
                                        <th>보고날짜</th>
                                        <th>보고상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="risk05 in riskApprovalData">
                                        <td v-if="risk05.contact == name && risk05.report_status == '결재완료'">
                                            {{risk05.title}}
                                        </td>
                                        <td v-if="risk05.contact == name && risk05.report_status == '결재완료'">
                                            {{risk05.reporter}}
                                        </td>
                                        <td v-if="risk05.contact == name && risk05.report_status == '결재완료'">
                                            {{risk05.text}}
                                        </td>
                                        <td v-if="risk05.contact == name && risk05.report_status == '결재완료'">
                                            {{formatDate(risk05.report_date)}}
                                        </td>
                                        <td v-if="risk05.contact == name && risk05.report_status == '결재완료'">
                                            {{risk05.report_status}}
                                        </td>

                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <!-- 업무정보 모달창 -->
        <!-- The Modal -->
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content" >

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h2 class="modal-title">Risk Response</h2>

                        <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div style="display: flex;">
                            <h3 id=proTitle>리스크 정보</h3>
                        </div>
                    </div>
                    <form class="forms-sample" id="modalFrm">
                        <div class="form-group" >
                            <label id="risk_status_label" for="exampleInputUsername1">리스크 상태</label>
                            <input name="status" type="text" readonly class="form-control" id="risk_status" placeholder="title">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputUsername1">해당 업무 명</label>
                            <input name="task_title" type="text" readonly class="form-control" id="task_text"

                                   placeholder="title">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputPassword1">리스크 등록자</label> <input
                                name="registrant" type="text" readonly class="form-control" id="registrant"

                                placeholder="risk_registrant">
                        </div>

                        <div class="form-group">
                            <label for="exampleTextarea1">상세설명</label>
                            <textarea type="text" name="detail" class="form-control" readonly ></textarea>
                        </div>

                        <div class="form-group">
                            <label for="exampleInputPassword1" id="contactLabel">담당자</label>
                            <input name="contact" type="text" readonly class="form-control"
                                   placeholder="title">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputConfirmPassword1">리스크 대응전략</label>
                            <input type="text" name="strategy" class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleTextarea1">대응 상세</label>
                            <textarea type="text" name="response_method" class="form-control" readonly ></textarea>
                        </div>


                    </form>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="mx-auto">
                            <button type="button" class="btn btn-" id="appRiskBtn"
                                    style="background-color: #007FFF; color: white;">리스크 결재
                            </button>

                            <button type="button" class="btn btn-danger" data-dismiss="modal"
                                    id="clsBtn">닫기
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
