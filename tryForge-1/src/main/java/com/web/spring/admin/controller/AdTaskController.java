package com.web.spring.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.spring.admin.service.AdTaskService;
import com.web.spring.vo.MemberSch;
import com.web.spring.vo.Task;



@Controller
public class AdTaskController {
	@Autowired(required = false)
	private AdTaskService service;
	
	@ModelAttribute("title")
	public List<String> getTitle() {
		return service.getTitle();
	}
	
	@RequestMapping("task")
	public String test(MemberSch sch, Model d ) {
		d.addAttribute("memList",service.schTaskMem(sch));
		return "adTask/insertTask";
	}
	
	@RequestMapping("insertTask")
	public String insertTask(Task ins, Model d) {
		d.addAttribute("insMsg",service.insertTask(ins));
		return "pageJsonReport";
	}
}
