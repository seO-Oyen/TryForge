package com.web.spring.risk.service;

import com.web.spring.risk.dao.Risk_ApprovalDao;
import com.web.spring.vo.Risk;
import com.web.spring.vo.Risk_Approval;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Risk_ApprovalService {
    @Autowired(required = false)
    private Risk_ApprovalDao dao;

    public String insRiskApproval(Risk_Approval ins){
        int insRiskApproval = dao.insRiskApproval(ins);
        dao.insFileUse();
        return insRiskApproval>0? "결재 완료":"결재 실패";
    }
    // 리스크 결재 리스트 출력
    public List<Risk_Approval> riskApprovalInfo(){
        return dao.riskApprovalInfo();
    }
    // 리스크 키로 리스크 & 리스크 대응전략 상세
    public Risk rlistByrisk_key(int risk_key){
        return dao.rlistByrisk_key(risk_key);
    }
    // 리스크 키로 리스크 결재정보
    public Risk_Approval ralist(int risk_key){
        return dao.ralist(risk_key);
    }
    // 재상신 2 getRiskApprovalByrakey reRiskApproval
    public Risk_Approval getRiskApprovalByrakey(int risk_approval_key) {
    	return dao.getRiskApprovalByrakey(risk_approval_key);
    }
    public String reRiskApproval(Risk_Approval upt) {
    	return dao.reRiskApproval(upt)>0?"재상신 완료" : "재상신 에러";
    }
}
