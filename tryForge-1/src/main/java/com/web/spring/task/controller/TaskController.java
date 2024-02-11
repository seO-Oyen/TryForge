package com.web.spring.task.controller;

import com.web.spring.vo.Risk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	@GetMapping("uptConfirm")
	public String uptConfirm(@RequestParam("id")int id, Model d){
		d.addAttribute("uptMsg",service.uptConfirm(id));
		return "pageJsonReport";
	}
	// 상세정보 가져오기
	@GetMapping("taskDetail")
	public String taskDetail(@RequestParam("id")int id, Model d){
		d.addAttribute("taskDetail",service.taskDetail(id));
		return "pageJsonReport";
	}
	// 리스크 등록
	@RequestMapping ("insRisk")
	public String insRisk(Risk ins, Model d){
		d.addAttribute("insMsg",service.insertRisk(ins));
		return "pageJsonReport";
	}
}
