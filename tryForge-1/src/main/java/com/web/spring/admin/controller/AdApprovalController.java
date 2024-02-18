package com.web.spring.admin.controller;

import com.web.spring.admin.service.AdApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdApprovalController {
    @Autowired(required = false)
    private AdApprovalService service;

    @GetMapping("adApprovalPlist")
    public String adApprovalPlist(){
        return "adApproval/adApprovalPlist";
    }
    @GetMapping("getProjectByCreater")
    public String getProjectByCreater(@RequestParam("creater")int creater, Model d){
        d.addAttribute("plist",service.projectByCreater(creater));
        return "pageJsonReport";
    }
}
