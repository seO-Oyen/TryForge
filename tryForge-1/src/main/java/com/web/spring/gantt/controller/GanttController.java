package com.web.spring.gantt.controller;

import com.web.spring.vo.Project;
import com.web.spring.vo.Task;
import com.web.spring.vo.Task_Dependency;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.gantt.service.GanttService;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class GanttController {
	@Autowired(required = false)
	private GanttService service;

	private Project getProject(HttpSession session) {
		if(session.getAttribute("loginMem") != null && session.getAttribute("projectMem") != null) {
			return (Project)session.getAttribute("projectMem");
		}
		return null;
	}
	@GetMapping("gantt")
	public String Gantt(Model d, HttpSession session) {
		Project project = getProject(session);
		if(project != null) {
			d.addAttribute("date", service.getProjectPeriod(project.getProject_key()));
			d.addAttribute("memList", service.getTaskMem(project.getProject_key()));
		}
		return "project/gantt";
	}

	@GetMapping("getGantt")
	public String getGantt(Model d, HttpSession session) {
		Project project = getProject(session);
		if(project != null) {
			d.addAttribute("data", service.getTask(project.getProject_key()));
			d.addAttribute("links", service.getTaskDep(project.getProject_key()));
		}
		return "pageJsonReport";
	}
	// 업무할당
	@PostMapping("insTask")
	public String insertTask(Task ins, Model d, HttpSession session) {
		Project project = getProject(session);
		if(project != null) {
			ins.setProject_key(project.getProject_key());
			d.addAttribute("msg", service.insertTask(ins));
		}
		return "pageJsonReport";
	}
	// 업무종속성할당
	@PostMapping("insTaskDep")
	public String insertTaskDep(Task_Dependency ins, Model d, HttpSession session) {
		Project project = getProject(session);
		if(project != null) {
			ins.setProject_key(project.getProject_key());
			d.addAttribute("msg", service.insertTaskDep(ins));
		}
		return "pageJsonReport";
	}
	// 업무수정
	@PostMapping("uptTask")
	public String updateTask(Task upt, Model d) {
		d.addAttribute("msg", service.updateTask(upt));

		return "pageJsonReport";
	}
}