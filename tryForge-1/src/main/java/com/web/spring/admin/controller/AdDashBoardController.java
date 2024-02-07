package com.web.spring.admin.controller;

import com.web.spring.admin.service.AdDashBoardService;
import com.web.spring.vo.NoticeSch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdDashBoardController {
    @Autowired(required = false)
    private AdDashBoardService service;
    //메인페이지 출력
    @GetMapping("adMain")
    public String ad_main() {
        return "ad_main/ad_main";
    }
    // 프로젝트 진척도
    @GetMapping("projectProgress")
    public String projectProgress(Model d){
        d.addAttribute("pjprogress",service.projectProgress());
        return "pageJsonReport";
    }
    // 가용인원
    @GetMapping("ablePersonnel")
    public String ablePersonnel(Model d){
        d.addAttribute("totMem",service.totMember());
        d.addAttribute("totTeamMem",service.totTeamMember());
        return "pageJsonReport";
    }
    // 올해 프로젝트
    @GetMapping("totProject")
    public String totProject(Model d){
        d.addAttribute("totOngoingPJ",service.totOngoingPJ());
        d.addAttribute("totCompletePJ",service.totCompletePJ());
        d.addAttribute("totWaitingPJ",service.totWaitingPJ());
        return "pageJsonReport";
    }
    // 프로젝트 + 담당자별 업무 진행률
    @GetMapping("ownerProgress")
    public String ownerProgress(@RequestParam("project_key")String project_key, Model d){
        d.addAttribute("taskProgressByOwner",service.taskProgressBypeople(project_key));
        return "pageJsonReport";
    }
}
