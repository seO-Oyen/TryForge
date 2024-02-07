package com.web.spring.task.controller;

import com.web.spring.task.service.TaskReportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TaskReportController {
    @Autowired(required = false)
    private TaskReportService service;

    @GetMapping("taskReport")
    public String taskReport(Model d, HttpSession session){
        return "";
    }
}
