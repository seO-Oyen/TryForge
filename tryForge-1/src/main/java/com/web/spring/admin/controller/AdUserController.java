package com.web.spring.admin.controller;

import com.web.spring.admin.service.AdUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.admin.service.AdProjectService;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;
import com.web.spring.vo.Team;
import com.web.spring.vo.Team_Member;

@Controller
public class AdUserController {
  @Autowired(required = false)
  private AdProjectService pjService;
  @Autowired(required = false)
  private AdUserService service;
  
	// 프로젝트 출력
	@RequestMapping("adUser")
	public String adUser(Project p , Model d) {
	    d.addAttribute("plist",pjService.projList());
	    return "adUser\\userProject";
	}
	  // 프로젝트 키로 상세정보 출력
	  @RequestMapping("userdetail")
	  public String detail(Project p, Team t, Team_Member tm, Member m, @RequestParam("project_key")String project_key, Model d ) {
	      d.addAttribute("projectInfo",pjService.projectInfo(project_key));
	      d.addAttribute("teamInfo",pjService.teamInfo(p.getProject_key()));
	      d.addAttribute("tmInfo",pjService.tmInfo(p.getProject_key(), t.getTeam_key()));
	      d.addAttribute("memberInfo",pjService.memberInfo(p.getProject_key(),t.getTeam_key()));
	      return "pageJsonReport";
	  }
	// 맴버키로 팀원 정보 가져오기
	  @RequestMapping("tmInfo")
	public String tmInfo(Team_Member tm,Model d){
		d.addAttribute("tmInfo",service.tmFromMember(tm));
		  return "pageJsonReport";
	  }
	  // 팀원 삭제
	  @GetMapping("userDelete")
	public String userDelete(@RequestParam("team_Member_key")int team_Member_key, Model d){
        d.addAttribute("delMsg",service.delTm(team_Member_key));
        return "pageJsonReport";
    }
	// PL지정
	@GetMapping("assignPL")
	public String assignPL(@RequestParam("team_Member_key")int team_Member_key, Model d){
		d.addAttribute("uptMsg",service.assignPL(team_Member_key));
		return "pageJsonReport";
	}
	// 새로운 구성원 추가 검색
	@RequestMapping("newMemSch")
	public String schMem(@RequestParam(value="member_name", defaultValue = "")String member_name, Model d) {
		d.addAttribute("memList", pjService.schMem(member_name));
		return "pageJsonReport";
	}
	// 새로운 구성원 추가
	@PostMapping("insNewMem")
	public String insNewMem(Team_Member ins,Model d){
		d.addAttribute("insMsg",service.insNewTm(ins));
		return "pageJsonReport";
	}

}
