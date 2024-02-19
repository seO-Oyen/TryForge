package com.web.spring.admin.service;

import com.web.spring.admin.dao.AdApprovalDao;
import com.web.spring.vo.Approval;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.Project;
import com.web.spring.vo.Risk_Approval;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdApprovalService {
    @Autowired(required = false)
    private AdApprovalDao dao;

    public List<Project> projectByCreater(int creater){
        return dao.projectByCreater(creater);
    }
    // 업무결재 정보
    public List<Approval> approvalList(Approval sch){
        return dao.approvalList(sch);
    }
    // 업무결재키로 결재상세 & 첨부파일이름
    public Approval getApproval(int approval_key){
        return dao.getApproval(approval_key);
    }
    public List<FileStorage> getFname(int approval_key){
        return dao.getFname(approval_key);
    }
    // 결재 상태 변경 3개
    public String approvalStatusBefore(int approval_key){
        return dao.approvalStatusBefore(approval_key)>0?"결재 확인 완료":"결재 확인 에러";
    }
    public String approvalStatusFin(int approval_key){
        return dao.approvalStatusFin(approval_key)>0?"결재 처리 완료":"결재 처리 에러";
    }public String approvalStatusReturn(Approval ins){
        return dao.approvalStatusReturn(ins)>0?"재상신 요청 완료":"재상신 요청 에러";
    }
    public List<Risk_Approval> riskApprovalList(String project_key){
        return dao.riskApprovalList(project_key);
    }
    public Risk_Approval getRiskApproval(int risk_approval_key){
        return dao.getRiskApproval(risk_approval_key);
    }
    public List<FileStorage> getRiskFname(int risk_approval_key){
        return dao.getRiskFname(risk_approval_key);
    }

    public String riskApprovalStatusFin(int risk_approval_key){
        dao.riskResponseFin(risk_approval_key);
        return dao.riskApprovalStatusFin(risk_approval_key)>0?"결재 처리 완료":"결재 처리 에러";
    }
    public String riskApprovalStatusReturn(Risk_Approval ins){
        return dao.riskApprovalStatusReturn(ins)>0?"재상신 요청 완료":"재상신 요청 에러";
    }

}
