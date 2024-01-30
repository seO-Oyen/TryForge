package com.web.spring.dashboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashBoardController {
    @RequestMapping("dashboard")
    public String test(){
        return "project/dashBoard";
    }
}