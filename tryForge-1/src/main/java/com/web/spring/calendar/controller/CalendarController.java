package com.web.spring.calendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.calendar.service.CalendarService;
import com.web.spring.vo.Calendar;



@Controller
public class CalendarController {
	@Autowired(required = false)
	private CalendarService service;
	
	@GetMapping("calendar.do")
	public String calendar() {
		return "project/calendar";
	}
	
	@GetMapping("getCalendar.do")
	public String getCalendar(Model d) {
		d.addAttribute("cal", service.getCalendar());
		return "pageJsonReport";
	}
	
	@PostMapping("insertCalendar.do")
	public String insertCalendar(Calendar ins, Model d) {
		d.addAttribute("msg", service.insertCalendar(ins));
		d.addAttribute("cal", service.getCalendar());
		return "pageJsonReport";
	}
	
	@PostMapping("updateCalendar.do")
	public String updateCalendar(Calendar upt, Model d) {
		d.addAttribute("msg", service.updateCalendar(upt));
		d.addAttribute("cal", service.getCalendar());
		return "pageJsonReport";
	}
	
	@PostMapping("deleteCalendar.do")
	public String deleteCalendar(@RequestParam("calendar_key") int calendar_key, Model d) {
		d.addAttribute("msg", service.deleteCalendar(calendar_key));
		d.addAttribute("cal", service.getCalendar());
		return "pageJsonReport";
	}
}
