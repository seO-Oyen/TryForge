package com.web.spring.admin.controller;

import com.web.spring.admin.service.AdApprovalService;
import com.web.spring.vo.Approval;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdApprovalController {
    @Autowired(required = false)
    private AdApprovalService service;

    @GetMapping("adApprovalPlist")
    // 프로젝트 별로 기본 분류 페이지 호출
    public String adApprovalPlist(){
        return "adApproval/adApprovalPlist";
    }
    @GetMapping("getProjectByCreater")
    // 프로젝트 만든사람 구분
    public String getProjectByCreater(@RequestParam("creater")int creater, Model d){
        d.addAttribute("plist",service.projectByCreater(creater));
        return "pageJsonReport";
    }
    @GetMapping("adApproval")
    // 업무 결재 페이지 이동 호출
    public String adApproval(){
        return "adApproval/adApproval";
    }
    // 업무결재 리스트
    @PostMapping("approvalList")
    public String approvalList(Approval sch, Model d){
        d.addAttribute("apList",service.approvalList(sch));
        return "pageJsonReport";
    }
    @GetMapping("getApprovalInfo")
    public String getApprovalInfo(@RequestParam("approval_key")int approval_key, Model d){
        d.addAttribute("getApproval",service.getApproval(approval_key));
        d.addAttribute("getFname",service.getFname(approval_key));
        return "pageJsonReport";
    }
    @GetMapping("approvalStatusBefore")
    public String approvalStatusBefore(@RequestParam("approval_key")int approval_key, Model d){
        d.addAttribute("beforeMsg",service.approvalStatusBefore(approval_key));
        return "pageJsonReport";
    }
    @GetMapping("approvalStatusFin")
    public String approvalStatusFin(@RequestParam("approval_key")int approval_key,  Model d){
        d.addAttribute("finMsg",service.approvalStatusFin(approval_key));
        return "pageJsonReport";
    }
    @PostMapping("approvalStatusReturn")
    public String approvalStatusReturn(Approval ins , Model d){
        d.addAttribute("returnMsg", service.approvalStatusReturn(ins));
        return "pageJsonReport";
    }
    // 리스크 결재 ㄱㄱ
    @GetMapping("adRiskApprovalPlist")
    public String adRiskApprovalPlist(){
        return "adApproval/adRiskApprovalPlist";
    }
    @GetMapping("riskapprovalList")
    public String riskapprovalList(@RequestParam("project_key")String project_key, Model d){
        d.addAttribute("rapList",service.riskApprovalList(project_key));
        return "pageJsonReport";
    }
    @GetMapping("adRiskApproval")
    public String adRiskApproval(){
        return "adApproval/adRiskApproval";
    }
}
