package com.web.spring.gantt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.gantt.service.GanttService;


@Controller
public class GanttController {
	@Autowired(required = false)
	private GanttService service;
	
	@GetMapping("gantt.do")
	public String Gantt() {
		return "project/gantt";
	}
	
	@GetMapping("getGantt.do")
	public String getGantt(Model d) {
		d.addAttribute("data", service.getTask());
		d.addAttribute("links", service.getTaskDep());
		return "pageJsonReport";
	}
	
	
}