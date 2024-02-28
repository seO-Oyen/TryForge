package com.web.spring.risk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.risk.dao.Risk_ApprovalDao;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.FileUse;
import com.web.spring.vo.Risk;
import com.web.spring.vo.Risk_Approval;

@Service
public class Risk_ApprovalService {
    @Autowired(required = false)
    private Risk_ApprovalDao dao;
    public int insFileUse(List<String> fileKeys){
        int cnt = 0;
        for(String fileKey : fileKeys) {
            FileStorage file = new FileStorage();
            file.setFile_key(fileKey);
            cnt += dao.insFileUse(file);
            System.out.println("###파일키??"+fileKey);
        }
        return cnt;
    }
    public int insRiskApproval(Risk_Approval ins){
        return dao.insRiskApproval(ins);
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
    public int reRiskApproval(Risk_Approval upt) {
    	return dao.reRiskApproval(upt);
    }
    
    public int reRiskApprovalFileUse(List<String> fileKeys, Risk_Approval ra) {
    	  int cnt = 0;
          for(String fileKey : fileKeys) {
              FileUse file = new FileUse();
              file.setFile_key(fileKey);
              file.setRisk_approval_key(ra.getRisk_approval_key());
              cnt += dao.reRiskApprovalFileUse(file);
          }
          return cnt;
      }
   
}
