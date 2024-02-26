package com.web.spring.risk.dao;

import com.web.spring.vo.FileStorage;
import com.web.spring.vo.FileUse;
import com.web.spring.vo.Risk;
import com.web.spring.vo.Risk_Approval;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Mapper
public interface Risk_ApprovalDao {
    // 리스크 결제 등록
    int insRiskApproval(Risk_Approval ins);
    // FileUse 등록
    int insFileUse(FileStorage file);
    // 결재 정보
    List<Risk_Approval> riskApprovalInfo();
    // 리스크 키로 리스크 & 리스크 대응전략 상세정보
    Risk rlistByrisk_key(@Param("risk_key")int risk_key);
    // 리스크키로 리스크 결재정보 확인
    Risk_Approval ralist(@Param("risk_key")int risk_key);
    // 재상신 보낼 폼에서 일단 정보 가져오기
    Risk_Approval getRiskApprovalByrakey(@Param("risk_approval_key")int risk_approval_key);
    // 재상신 요청시 정보수정
    int reRiskApproval(Risk_Approval upt);
    int reRiskApprovalFileUse(FileUse file);

}
