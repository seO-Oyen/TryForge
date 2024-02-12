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
    public String taskChart(@RequestParam("creater")int creater,Model d){
        d.addAttribute("confCnt",service.confirm(creater));
        d.addAttribute("unConfCnt",service.unConfirm(creater));
        d.addAttribute("finCnt",service.completedTaskCnt(creater));
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
    // 리스크 대응 상세정보
    @GetMapping("getRiskResponse")
    public String getRiskResponse(@RequestParam("risk_key")int risk_key, Model d){
        d.addAttribute("getRiskResponse",service.getRiskResponse(risk_key));
        return "pageJsonReport";
    }
    // 리스크 상태 업데이트
    @GetMapping("uptProcessing")
    public String uptProcessing(@RequestParam("risk_response_key")int risk_response_key, Model d){
        d.addAttribute("pMsg",service.uptProcessing(risk_response_key));
        return "pageJsonReport";
    }
    @GetMapping("uptFin")
    public String uptFin(@RequestParam("risk_response_key")int risk_response_key, Model d){
        d.addAttribute("finMsg",service.uptFin(risk_response_key));
        return "pageJsonReport";
    }
    @RequestMapping("uptRiskResponse")
    public String uptRiskResponse(Risk_Response upt, Model d){
        d.addAttribute("uptRiskResMsg",service.uptRiskResponse(upt));
        return "pageJsonReport";
    }
    // 리스크 차트 riskNotConTot riskTot01
    @GetMapping("riskAllTot")
    public String riskAllTot(@RequestParam("creater")int creater, Model d){
        d.addAttribute("riskNotConTot",service.riskNotConTot(creater)); // 미확인
        d.addAttribute("riskTot01",service.riskTot01(creater)); // 확인+발생전
        d.addAttribute("riskTot02",service.riskTot02(creater)); // 확인+발생(처리중)
        d.addAttribute("riskTot03",service.riskTot03(creater)); // 확인+처리완료
        return "pageJsonReport";
    }
}
