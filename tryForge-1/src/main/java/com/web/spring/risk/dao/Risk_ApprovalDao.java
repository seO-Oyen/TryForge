package com.web.spring.risk.dao;

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
    int insFileUse();
    // 결재 정보
    List<Risk_Approval> riskApprovalInfo();
    // 리스크 키로 리스크 & 리스크 대응전략 상세정보
    Risk rlistByrisk_key(@Param("risk_key")int risk_key);
    // 리스크키로 리스크 결재정보 확인
    Risk_Approval ralist(@Param("risk_key")int risk_key);
    // 재상신 보내면 기존 재상신 받은 항목 삭제
    int delReturnRisk(@Param("risk_approval_key")int risk_approval_key);

}
