package com.web.spring.dashboard.controller;

import com.web.spring.SessionService;
import com.web.spring.dashboard.service.DashBoardService;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DashBoardController {
	@Autowired(required = false)
	private DashBoardService service;
	@Autowired(required = false)
	private SessionService sessionService;

	@GetMapping("setPj")
	public String setPj (
				@RequestParam("projectNum") String pjNum,
				HttpSession session, Model d
			) {
		if (session.getAttribute("loginMem") != null ) {
        	
        	Project pj = service.getProject(pjNum);

			session.setAttribute("projectMem", pj);
			Project project = (Project)session.getAttribute("projectMem");
			d.addAttribute("project", project);
        }
		return "pageJsonReport";
	}
	
	@GetMapping("projectMem")
	public String getProjectMem(
				@RequestParam("projectNum") String pjNum,
				Model d
			) {

		List<Member> memList = service.getProjectMember(pjNum);
		
		d.addAttribute("memList", memList);
		
		return "pageJsonReport";
	}
	
    @GetMapping("dashboard")
    public String dashboard(Model d, HttpSession session){
		Project project = sessionService.getProject(session);
		if(project != null) {
			String projectKey = project.getProject_key();

			d.addAttribute("completeTask", service.getCountCompleteTask(projectKey)); // 완료
			d.addAttribute("inCompleteTask", service.getCountIncompleteTask(projectKey)); // 미완료
			d.addAttribute("projectProgress", (int) (service.getProjectProgress(projectKey) * 100));
			d.addAttribute("projectElapsedDate", service.getProjectElapsedDate(projectKey));
			d.addAttribute("projectDday", service.getProjectDday(projectKey));
			d.addAttribute("projectEndDate", (service.getProjectEndDate(projectKey)).split(" ")[0]);
		}
        return "project/dashBoard";
    }

	@GetMapping("getComingSchedule")
	public String getComingSchedule(Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			d.addAttribute("scheduleList", service.getComingSchedule(project.getProject_key()));
		}
		return "pageJsonReport";
	}

	@GetMapping("getTaskMem")
	public String getTaskMem(Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			d.addAttribute("memberList", service.getTaskMem(project.getProject_key()));
		}
		return "pageJsonReport";
	}

	@GetMapping("getProjectStatusChart")
	public String getProjectStatusChart(Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			d.addAttribute("projectStatusData", service.getProjectStatusChart(project.getProject_key()));
			d.addAttribute("projectElapsed", service.getProjectElapsed(project.getProject_key()));
		}
		return "pageJsonReport";
	}

    @GetMapping("goPjChat")
    public String pjChat(
	    		@RequestParam("projectNum") String pjNum,
	    		Model d
	    	) {
    	int chatListNum = service.getChatListNum(pjNum);
    	if (chatListNum == -1) {
    		d.addAttribute("msg", "없음");
    	} else {
    		d.addAttribute("chat", "/chat/" + chatListNum);    		
    	}
    	
    	return "pageJsonReport";
    }

}