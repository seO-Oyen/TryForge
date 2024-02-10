package com.web.spring.admin.controller;

import java.util.List;

import com.web.spring.vo.Risk_Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.web.spring.admin.service.AdTaskService;
import com.web.spring.vo.MemberSch;
import com.web.spring.vo.Task;


@Controller
public class AdTaskController {
    @Autowired(required = false)
    private AdTaskService service;

    // 프로젝트 별로 구분
    @ModelAttribute("title")
    public List<String> getTitle() {
        return service.getTitle();
    }

    // 초기화면 맴버 구성원 출력
    @RequestMapping("task")
    public String test(MemberSch sch, Model d) {
        d.addAttribute("memList", service.schTaskMem(sch));
        return "adTask/task";
    }

    // 업무등록
    @RequestMapping("insertTask")
    public String insertTask(Task ins, Model d) {
        d.addAttribute("insMsg", service.insertTask(ins));
        return "pageJsonReport";
    }

    // 상세업무 조회
    @RequestMapping("taskList")
    public String taskList(Task t, @RequestParam("member_key") int member_key, Model d) {
        d.addAttribute("getTask", service.taskList(member_key));
        return "pageJsonReport";
    }

    // 상세업무 모달창에서 업무수정
    @RequestMapping("uptTask")
    public String uptTask(Task upt, Model d) {
        System.out.println(upt.getId());
        d.addAttribute("uptMsg", service.uptTask(upt));
        return "pageJsonReport";
    }

    // 상세업무 모달창에서 업무삭제
    @GetMapping("delTask")
    public String delTask(@RequestParam("id") int id, Model d) {
        d.addAttribute("delMsg", service.delTask(id));
        return "pageJsonReport";
    }

    @RequestMapping("taskManage")
    public String taskManage() {
        return "adTask/taskManage";
    }
    
    @GetMapping("taskChart") // 차트용 ajax
    public String taskChart(Model d){
        d.addAttribute("confCnt",service.confirm());
        d.addAttribute("unConfCnt",service.unConfirm());
        d.addAttribute("finCnt",service.completedTaskCnt());
        d.addAttribute("allCnt",service.allTaskCnt());
        return "pageJsonReport";
    }
    // 만든 프로젝트 별 업무 리스크 출력
    @GetMapping("AdriskList")
    public String adRiskList(@RequestParam("creater")int creater, Model d){
        d.addAttribute("rlist",service.adRiskList(creater));
        return "pageJsonReport";
    }
    // 리스크 대응자 검색
    @GetMapping("riskContactSch")
    public String riskContactSch(@RequestParam("project_key")String project_key, Model d){
        d.addAttribute("mlist",service.riskContactList(project_key));
        return "pageJsonReport";
    }
    // 리스크 대응 등록
    @PostMapping("insertRiskResponse")
    public String insertRiskResponse(Risk_Response ins, Model d){
        d.addAttribute("insResMsg",service.insertRiskRes(ins));
        return "pageJsonReport";
    }
}
