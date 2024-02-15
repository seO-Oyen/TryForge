package com.web.spring.task.controller;

import com.web.spring.SessionService;
import com.web.spring.task.service.TaskReportService;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;
import com.web.spring.vo.Task;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TaskReportController {
    @Autowired(required = false)
    private TaskReportService service;
    @Autowired(required = false)
    private SessionService sessionService;

    @GetMapping("taskReport")
    public String taskReport(){
        return "project/taskReport";
    }

    @GetMapping("getMemberTaskList")
    public String getMemberTaskList(Model d, Task task , HttpSession session) {
        Project project = sessionService.getProject(session);
        Member member = sessionService.getMember(session);
        if(project != null && member != null) {
            task.setProject_key(project.getProject_key());
            task.setMember_key(member.getMember_key());
            d.addAttribute("taskList", service.getMemberTaskList(task));
        }
        return "pageJsonReport";
    }
    @GetMapping("getMemberTask")
    public String getMemberTask(Task task, Model d){
        d.addAttribute("task", service.getMemberTask(task));
        return "pageJsonReport";
    }
}