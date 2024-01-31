package com.web.spring.gantt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.gantt.service.GanttService;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class GanttController {
	@Autowired(required = false)
	private GanttService service;
	
	@GetMapping("gantt")
	public String Gantt() {
		return "project/gantt";
	}
	
	@GetMapping("getGantt")
	public String getGantt(Model d) {
		d.addAttribute("data", service.getTask());
		d.addAttribute("links", service.getTaskDep());
		return "pageJsonReport";
	}

	@PostMapping("addTask")
	public ResponseEntity<?> addTask(){
		return ResponseEntity.ok("task");
	}
	
	
}