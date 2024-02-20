package com.web.spring.risk.controller;



import java.util.Date;
import java.util.List;

import com.web.spring.risk.service.RiskService;
import com.web.spring.vo.Risk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.web.spring.risk.service.Risk_ApprovalService;
import com.web.spring.vo.Risk_Approval;

@Controller
public class Risk_ApprovalController {
    @Autowired(required = false)
    private Risk_ApprovalService service;
    @Autowired(required = false)
    private RiskService riskService;
//    @ModelAttribute("rlist01")
//    public List<Risk> rlist01(@RequestParam("project_key")String project_key){
//        return riskService.riskList(project_key);
//    }
    //
    @GetMapping("rlist01")
    public  String rlist01(@RequestParam("project_key")String project_key, Model d){
        d.addAttribute("rlist01",riskService.riskList(project_key));
        return "pageJsonReport";
    }

    @GetMapping("riskApprovalList")
    public String riskApprovalList(){
        return "project/riskApprovalList";
    }

    // 결재 보고 페이지 호출
    @RequestMapping("riskApproval")
    public String test(Model d){
        Date now = new Date();
        d.addAttribute("now", now);
        return "project/riskApproval";
    }
    // 결재 보고
    @PostMapping("insRiskApproval")
    public String insRiskApproval(Risk_Approval ins, Model d){
        d.addAttribute("insMsg",service.insRiskApproval(ins));
        return "pageJsonReport";
    }
    // 리스크 결재여부 리스트 출력
    @GetMapping("raInfo")
    public String raInfo(Model d){
        d.addAttribute("raInfo",service.riskApprovalInfo());
        return "pageJsonReport";
    }
    // 리스크 키로 리스크 & 리스크대응 상세정보
    @GetMapping("rlistByRiskKey")
    public String rlistByRiskKey(@RequestParam("risk_key")int risk_key, Model d){
        d.addAttribute("risk",service.rlistByrisk_key(risk_key));
        return "pageJsonReport";
    }
    // 리스크 키로 리스크 결재정보
    @GetMapping("riskApprovalInfo")
    public String riskApprovalInfo(@RequestParam("risk_key")int risk_key,Model d){
        d.addAttribute("ralist",service.ralist(risk_key));
        return "pageJsonReport";
    }
    // 재상신 요청 하면 기존에 재상신 요청 결재 테이블에서 지우고 새로 결재요청으로 변경
    @GetMapping("delRiskApproval")
    public String delRiskApproval(@RequestParam("risk_approval_key")int risk_approval_key, Model d){
        d.addAttribute("delRiskApproval",service.delReturnRisk(risk_approval_key));
        return "pageJsonReport";
    }
}
