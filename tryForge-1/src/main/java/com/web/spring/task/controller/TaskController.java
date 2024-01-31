package com.web.spring.task.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.task.service.TaskService;

@Controller
public class TaskController {
	@Autowired(required = false)
	private TaskService service;
	
	@GetMapping("getTask")
	public String getTask(Model d) {
		d.addAttribute("getTask",service.getTask());
		return "project/userTask";
	}
}