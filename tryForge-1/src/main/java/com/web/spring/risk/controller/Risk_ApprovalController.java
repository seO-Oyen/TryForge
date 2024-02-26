package com.web.spring.risk.controller;



import java.util.Date;
import java.util.List;

import com.web.spring.file.service.UploadService;
import com.web.spring.risk.service.RiskService;
import com.web.spring.vo.Approval;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.Risk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.risk.service.Risk_ApprovalService;
import com.web.spring.vo.Risk_Approval;

@Controller
public class Risk_ApprovalController {
    @Autowired(required = false)
    private Risk_ApprovalService service;
    @Autowired(required = false)
    private RiskService riskService;
    @Autowired(required = false)
    private UploadService uploadService;
    
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
//    @PostMapping("insRiskApproval")
//    public String insRiskApproval(Risk_Approval ins, Model d){
//        d.addAttribute("insMsg",service.insRiskApproval(ins));
//        return "pageJsonReport";
//    }
    
    @PostMapping("insRiskApproval")
    public String reportTask(Risk_Approval ins, FileStorage file, Model d){
        MultipartFile[] files = file.getFiles();
        // 파일 있을 때
        if(files != null && files.length > 0) {
            List<String> fileKeys = uploadService.uploadFile(file);
            if(service.insRiskApproval(ins)!="") {
                d.addAttribute("result",service.insRiskApproval(ins));
            }
        } else { // 파일 없을 때
            d.addAttribute("result", service.insRiskApproval(ins));
        }
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
    // 재상신 
    @GetMapping("getRiskApprovalByrakey")
    public String getRiskApprovalByrakey(@RequestParam("risk_approval_key")int risk_approval_key, Model d) {
    	d.addAttribute("getRiskApproval",service.getRiskApprovalByrakey(risk_approval_key));
    	return "pageJsonReport";
    }
    @PostMapping("reRiskApproval")
    public String reRiskApproval(Risk_Approval upt, Model d) {
    	d.addAttribute("uptMsg",service.reRiskApproval(upt));
    	return "pageJsonReport";
    }
    
}
