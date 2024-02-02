package com.web.spring.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.admin.service.AdTaskService;
import com.web.spring.vo.MemberSch;
import com.web.spring.vo.Task;



@Controller
public class AdTaskController {
	@Autowired(required = false)
	private AdTaskService service;
	// 프로젝트 별로 구분
	@ModelAttribute("title")
	public List<String> getTitle() {
		return service.getTitle();
	}
	// 초기화면 맴버 구성원 출력
	@RequestMapping("task")
	public String test(MemberSch sch, Model d ) {
		d.addAttribute("memList",service.schTaskMem(sch));
		return "adTask/task";
	}
	// 업무등록
	@RequestMapping("insertTask")
	public String insertTask(Task ins, Model d) {
		d.addAttribute("insMsg",service.insertTask(ins));
		return "pageJsonReport";
	}
	// 상세업무 조회
	@RequestMapping("taskList")
	public String taskList(Task t,@RequestParam("member_key")int member_key, Model d) {
		d.addAttribute("getTask",service.taskList(member_key));
		return "pageJsonReport";
	}
	// 상세업무 모달창에서 업무수정
	@RequestMapping("uptTask")
	public String uptTask(Task upt, Model d) {
		System.out.println(upt.getId());
		d.addAttribute("uptMsg",service.uptTask(upt));
		return "pageJsonReport";
	}
	// 상세업무 모달창에서 업무삭제
	@GetMapping("delTask")
	public String delTask(@RequestParam("id")int id, Model d) {
		d.addAttribute("delMsg",service.delTask(id));
		return "pageJsonReport";
	}
	@RequestMapping("test")
	public String test(){
		return "adTask/taskManage";
	}

}
