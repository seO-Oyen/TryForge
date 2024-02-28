package com.web.spring.admin.dao;

import com.web.spring.vo.Approval;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.Project;
import com.web.spring.vo.Risk_Approval;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AdApprovalDao {
    @Select("SELECT * FROM PROJECT WHERE CREATER = #{creater} ")
    List<Project> projectByCreater(@Param("creater")int creater);
    // 업무결재정보
    List<Approval> approvalList(Approval sch);
    // 업무결재키로 업무상세, 파일이름
    Approval getApproval(@Param("approval_key")int approval_key);
    List<FileStorage> getFname(@Param("approval_key")int approval_key);
    // 결재전, 처리완료, 재상신요청 3개
    int approvalStatusBefore(int approval_key);
    int approvalStatusFin(int approval_key);
    int approvalStatusReturn(Approval ins);

    List<Risk_Approval> riskApprovalList(@Param("project_key")String project_key);
    Risk_Approval getRiskApproval(@Param("risk_approval_key")int risk_approval_key);
    List<FileStorage> getRiskFname(@Param("risk_approval_key")int risk_approval_key);
    // 상태수정~
    int riskApprovalStatusFin(@Param("risk_approval_key")int risk_approval_key);
    int riskResponseFin(@Param("risk_approval_key")int risk_approval_key);
    int riskApprovalStatusReturn(Risk_Approval ins);
	int taskUptFin(@Param("approval_key")int approval_kay);

}
