package com.web.spring.risk.dao;

import com.web.spring.vo.Risk;
import com.web.spring.vo.Risk_Approval;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

}
