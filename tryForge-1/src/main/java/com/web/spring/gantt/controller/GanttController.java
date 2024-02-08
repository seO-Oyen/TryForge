package com.web.spring.gantt.controller;

import com.web.spring.SessionService;
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
	@Autowired(required = false)
	private SessionService sessionService;

	// 프로젝트 시작/종료일과 프로젝트 참여중인 멤버리스트 출력
	@GetMapping("gantt")
	public String Gantt(Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			d.addAttribute("date", service.getProjectPeriod(project.getProject_key()));
			d.addAttribute("memList", service.getTaskMem(project.getProject_key()));
		}
		return "project/gantt";
	}
	// 프로젝트 키로 task 정보와 taskDep 정보 검색 후 전달
	@GetMapping("getGantt")
	public String getGantt(Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			d.addAttribute("data", service.getTask(project.getProject_key()));
			d.addAttribute("links", service.getTaskDep(project.getProject_key()));
		}
		return "pageJsonReport";
	}
	// 업무할당
	@PostMapping("insTask")
	public String insertTask(Task ins, Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			ins.setProject_key(project.getProject_key());
			d.addAttribute("id", service.insertTask(ins));
		}
		return "pageJsonReport";
	}
	// 업무종속성할당
	@PostMapping("insTaskDep")
	public String insertTaskDep(Task_Dependency ins, Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
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
	@PostMapping("uptTaskOpenStatus")
	public String updateTaskOpenStatus(Task upt, Model d) {
		d.addAttribute("msg", service.updateTaskOpenStatus(upt));
		return "pageJsonReport";
	}
	@PostMapping("delTask")
	public String deleteTask(Task del) {
		service.deleteTask(del);
		return "pageJsonReport";
	}
	@PostMapping("delTaskDep")
	public String deleteTaskDep(Task_Dependency del) {
		service.deleteTaskDep(del);
		return "pageJsonReport";
	}
}