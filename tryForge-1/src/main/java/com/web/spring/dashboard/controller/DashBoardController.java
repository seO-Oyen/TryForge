package com.web.spring.dashboard.controller;

import com.web.spring.vo.Member;
import com.web.spring.vo.Project;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashBoardController {
    @RequestMapping("dashboard")
    public String test(HttpSession session, Model d){
        if (session.getAttribute("loginMem") != null ) {
            if(session.getAttribute("projectMem") != null) {
                Project project = (Project)session.getAttribute("projectMem");
                d.addAttribute("project", project);
            }
        }
        return "project/dashBoard";
    }
}