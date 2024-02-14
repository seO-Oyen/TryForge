<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${path}/template/module/module_admain.jsp"
             flush="true"/>
<style>
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
    $(document).ready(function () {

        $("#clsBtn").click(function () {
            $("#myModal form")[0].reset()

        })
        $("#xBtn").click(function () {
            $("#myModal form")[0].reset()

        })

        $("#uptBtn").click(function(){

        })
    })

    function openPage(confirm){
        if(confirm==0){
            $("#uptBtn").show();
        }else{
            $("#uptBtn").hide();
        }
        $("#myModal").modal('show')
    }

    function confirmError(error_key){
        $.ajax({
            url:"${path}/confirmError",
            data:"error_key="+error_key,
            dataType:"json",
            success:function (data){
                if(data.uptMsg!=null){
                    Swal.fire({
                        title: '수정 성공',
                        text: data.uptMsg,
                        icon: 'success',
                    }).then(function () {
                        $("#clsBtn").click();
                        window.location.reload();
                    });
                }
            },
            error:function (err){
                console.log(err)
            }
        })
    }


</script>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <!-- 에러 -->
            <div class="col-md-12" style="margin-bottom: 20px; padding-right: 0; padding-left: 0">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">New Risk</h4>
                        <!-- 에러 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>에러종류</th>
                                    <th>에러타입</th>
                                    <th>에러설명</th>
                                    <th>에러날짜</th>
                                    <th>발생경로</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="elist" items="${elist}">
                                    <c:if test="${elist.error_confirm == 0}">
                                        <tr ondblclick='openPage("${elist.error_confirm}")'>
                                            <td>${elist.error_level}</td>
                                            <td>${elist.error_type}</td>
                                            <td>${elist.error_detail}</td>
                                            <c:set var="formattedDate" value="${fn:substring(elist.incident_date, 0, 10)}"/>
                                            <td>${formattedDate}</td>
                                            <td>${elist.error_path}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 확인 완료 에러 -->
            <div class="col-md-12" style="padding-right: 0; padding-left: 0">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Confirm Risk</h4>
                        <!-- 에러 테이블 -->
                        <div class="table-responsive"
                             style="width: 95%; margin-left: 4%; max-height: 500px; overflow-x: auto;">
                            <table class="table table-hover" style="width: 100%;">
                                <thead>
                                <tr>
                                    <th>에러종류</th>
                                    <th>에러타입</th>
                                    <th>에러설명</th>
                                    <th>에러날짜</th>
                                    <th>발생경로</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="elist" items="${elist}">
                                    <c:if test="${elist.error_confirm == 1}">
                                        <tr ondblclick='openPage("${elist.error_confirm}")'>
                                            <td>${elist.error_level}</td>
                                            <td>${elist.error_type}</td>
                                            <td>${elist.error_detail}</td>
                                            <c:set var="formattedDate" value="${fn:substring(elist.incident_date, 0, 10)}"/>
                                            <td>${formattedDate}</td>
                                            <td>${elist.error_path}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
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
                        <h2 class="modal-title">Error</h2>

                        <button type="button" class="close" data-dismiss="modal" id="xBtn">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div style="display: flex;">
                            <h3 id=proTitle>에러 확인</h3>
                        </div>
                    </div>
                    <form class="forms-sample" id="modalFrm">
                    <c:forEach var="elist" items="${elist}">
                        <c:set var="error_key" value="${elist.error_key}"/>
                        <c:set var="level" value="${elist.error_level}"/>
                        <c:set var="type" value="${elist.error_type}"/>
                        <c:set var="detail" value="${elist.error_detail}"/>
                        <c:set var="formattedDate" value="${fn:substring(elist.incident_date, 0, 10)}"/>
                        <c:set var="path" value="${elist.error_path}"/>
                        <c:set var="confirm" value="${elist.error_confirm}"/>
                    </c:forEach>
                        <div class="form-group">
                            <label for="exampleInputUsername1">에러 종류</label> <input value="${level}"
                               type="text" class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">에러 타입</label>
                            <input type="text"  class="form-control" value="${type}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">에러 설명</label> <input value="${detail}"
                                type="text" class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputConfirmPassword1">에러 날짜</label> <input value="${formattedDate}"
                                type="date" class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleTextarea1">발생경로</label>
                            <textarea class="form-control" rows="10" name="detail">${path}</textarea>
                        </div>
                    </form>


                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="mx-auto">
                            <button type="button" class="btn btn-" id="uptBtn" onclick='confirmError("${error_key}")'
                                    style="background-color: #007FFF; color: white;">에러 확인
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

