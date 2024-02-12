package com.web.spring.risk.controller;

import com.web.spring.admin.service.AdTaskService;
import com.web.spring.risk.service.RiskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RiskController {
    @Autowired(required = false)
    private RiskService service;
    @Autowired(required = false)
    private AdTaskService adService;

    @GetMapping("risk")
    public String risk(){
        return "project/risk";
    }
    @GetMapping("riskList")
    public String riskList(@RequestParam("project_key")String project_key, Model d){
        d.addAttribute("rlist",service.riskList(project_key));
        return "pageJsonReport";
    }
    
    // 리스크 대응 상세정보
    @GetMapping("RiskResponseInfo")
    public String RiskResponseInfo(@RequestParam("risk_key")int risk_key, Model d){
        d.addAttribute("RiskResponseInfo",adService.getRiskResponse(risk_key));
        return "pageJsonReport";
    }
}
