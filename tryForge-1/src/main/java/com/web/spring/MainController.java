package com.web.spring;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.admin.service.AdProjectService;
import com.web.spring.admin.service.NoticeService;
import com.web.spring.member.service.MemberService;
import com.web.spring.vo.Member;
import com.web.spring.vo.NoticeSch;
import com.web.spring.vo.Project;

import jakarta.servlet.http.HttpSession;



@Controller
public class MainController {
	@Autowired(required = false)
	private NoticeService noticeService; 
	@Autowired(required = false)
	private AdProjectService PJRequestService;
	@Autowired(required = false)
	private MemberService memberService;

	// http://localhost:1112/adMain
	@GetMapping("index")
	public String indexPage() {

		return "index";
	}

	@GetMapping("userIndex")
	public String userIndexPage(HttpSession session, Model d) {
		if (session.getAttribute("loginMem") != null ) {
			Member member = (Member)session.getAttribute("loginMem");
			Project project = memberService.getUserProject(member);
			if (project != null) {
				session.setAttribute("projectMem", project);
			}
		}

		return "user/userIndex";
	}
	
	//메인페이지 출력
	@GetMapping("adMain")
	public String ad_main(NoticeSch sch, Model d) {
		d.addAttribute("noticeList", noticeService.noticeList(sch));
		d.addAttribute("plist", PJRequestService.projList());
		
	    return "ad_main\\ad_main";
	}
	
	//마이페이지 출력
	@GetMapping("myPage")
	public String myPage(Model d) {
		
	    return "user/myPage";
	}

}