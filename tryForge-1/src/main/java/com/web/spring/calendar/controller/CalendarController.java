package com.web.spring.calendar.controller;

import com.web.spring.vo.Project;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.calendar.service.CalendarService;
import com.web.spring.vo.Calendar;



@Controller
public class CalendarController {
	@Autowired(required = false)
	private CalendarService service;

	private Project getProject(HttpSession session) {
		if(session.getAttribute("loginMem") != null && session.getAttribute("projectMem") != null) {
			return (Project)session.getAttribute("projectMem");
		}
		return null;
	}

	@GetMapping("calendar")
	public String calendar() {
		return "project/calendar";
	}
	
	@GetMapping("getCalendar")
	public String getCalendar(HttpSession session, Model d) {
		Project project = getProject(session);
		if(project != null) {
			d.addAttribute("cal", service.getCalendar(project));
		}
		return "pageJsonReport";
	}
	
	@PostMapping("insertCalendar")
	public String insertCalendar(Calendar ins, Model d, HttpSession session) {
		d.addAttribute("msg", service.insertCalendar(ins));
		Project project = getProject(session);
		if(project != null) {
			d.addAttribute("cal", service.getCalendar(project));
		}
		return "pageJsonReport";
	}
	
	@PostMapping("updateCalendar")
	public String updateCalendar(Calendar upt, Model d, HttpSession session) {
		d.addAttribute("msg", service.updateCalendar(upt));
		Project project = getProject(session);
		if(project != null) {
			d.addAttribute("cal", service.getCalendar(project));
		}
		return "pageJsonReport";
	}
	
	@PostMapping("deleteCalendar")
	public String deleteCalendar(@RequestParam("calendar_key") int calendar_key, Model d, HttpSession session) {
		d.addAttribute("msg", service.deleteCalendar(calendar_key));
		Project project = getProject(session);
		if(project != null) {
			d.addAttribute("cal", service.getCalendar(project));
		}
		return "pageJsonReport";
	}
}
