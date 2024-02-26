package com.web.spring.dashboard.controller;

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
	
	@GetMapping("setPj")
	public String setPj (
				@RequestParam("projectNum") String pjNum,
				HttpSession session, Model d
			) {
		if (session.getAttribute("loginMem") != null ) {
        	
        	Project pj = service.getProject(pjNum);
        	
            if(session.getAttribute("projectMem") != null) {
            	session.setAttribute("projectMem", pj);
                Project project = (Project)session.getAttribute("projectMem");
                d.addAttribute("project", project);
            }
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
		if(session.getAttribute("projectMem") != null) {
			Project project = (Project)session.getAttribute("projectMem");
			d.addAttribute("completeTask", service.countCompleteTask());
			d.addAttribute("inCompleteTask", service.countIncompleteTask());
			d.addAttribute("projectProgress", service.projectProgress(project.getProject_key())*100);
		}
        return "project/dashBoard";
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