<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${path}/template/module/module_admain.jsp"
             flush="true"/>
<style>
    .card-title {
        font-size: 20px;
        font-weight: bold;
    }
</style>
<script>
    $(document).ready(function () {
        var creater = "${loginMem.member_key}";

        var vm = Vue.createApp({
            name: "App",
            data() {
                return {
                    pjlist: []
                };
            },
            created() {
                this.projectList()
            },
            methods: {
                projectList() {
                    var url = "${path}/getProjectByCreater?creater="+creater;
                    var it = this
                    axios.get(url).then((response) => {
                        it.pjlist = [];
                        it.pjlist = response.data.plist;
                    });
                },
                formatDate(dateString) {
                    var date = new Date(dateString);
                    date.setDate(date.getDate() + 1);
                    return date.toISOString().split('T')[0];
                },
                goPage(event) {
                	 const projectKey = event.target.dataset.projectKey;
                    location.href = "${path}/adRiskApproval?project_key="+projectKey;
                }
            }
        }).mount(".main-panel");

    })
</script>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <!-- 진행중인 프로젝트 -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">진행중인 프로젝트</h4>
                        <!-- 진행중인 프로젝트 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트 명</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                    <th>결재관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="plist in pjlist">
                                    <td v-if="plist.status=='진행중' ">
                                        {{plist.title}}
                                    </td>
                                    <td v-if="plist.status=='진행중' ">
                                        {{formatDate(plist.start_date)}}
                                    </td>
                                    <td v-if="plist.status=='진행중' ">
                                        {{formatDate(plist.end_date)}}
                                    </td>

                                    <td v-if="plist.status=='진행중' ">
                                        <button type="button" class="btn-btn"
                                                v-bind:data-project-key="plist.project_key"
                                                style="background-color: #007FFF; color: white; width: 100px; height: 30px; border: none;"
                                                @click="goPage($event)">
                                            결재관리
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 진행중인 프로젝트 end -->

            <!-- 완료된 프로젝트 -->
            <div class="col-md-12" style="margin-top: 3%;">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">완료된 프로젝트</h4>
                        <!-- 완료된 프로젝트 테이블 -->
                        <div class="table-responsive" style="width: 95%; margin-left: 4%;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>프로젝트 명</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="plist in pjlist">
                                    <td v-if="plist.status=='완료' ">
                                        {{plist.title}}
                                    </td>
                                    <td v-if="plist.status=='완료' ">
                                        {{formatDate(plist.start_date)}}
                                    </td>
                                    <td v-if="plist.status=='완료' ">
                                        {{formatDate(plist.end_date)}}
                                    </td>


                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 완료된 프로젝트 end -->
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

