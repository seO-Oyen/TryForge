package com.web.spring.member.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.chat.controller.ChatController;
import com.web.spring.member.service.MemberService;
import com.web.spring.vo.InviteMember;
import com.web.spring.vo.MailSender;
import com.web.spring.vo.Member;

import jakarta.servlet.http.HttpSession;


@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private ChatController chatController;

	// 로그인 창 띄우기
	@GetMapping("login")
	public String login(HttpSession session) {
		// 기존 session이 있다면 삭제
		if (session.getAttribute("loginMem") != null) {
			System.out.println(chatController.chatSave());
			session.removeAttribute("loginMem");
			if(session.getAttribute("projectMem") != null){
				session.removeAttribute("projectMem");
				System.out.println("세션(멤버&프로젝트) 삭제");
			}
		}

		return "user/login";
	}

	// 로그인 기능
	@PostMapping("login")
	public String memberLogin(Member member, HttpSession session) {
		Member loginMember = memberService.loginMember(member);

		// 로그인 여부
		if (loginMember != null) {
			session.setAttribute("loginMem", loginMember);
		}

		return "user/login";

	}
	
	// 회원가입 창 띄우기
	@GetMapping("register")
	public String registerPage() {
		
		return "user/register";
	}
	
	// 회원가입
	@PostMapping("register")
	public String register(Member member, Model d) {
		
		// 회원가입 성공 여부
		d.addAttribute("insertResult", memberService.registerMember(member));
		
		return "user/register";
	}
	
	// 아이디 중복체크
	@GetMapping("idCheck")
	public String idCheck(
			@RequestParam("userId") String userId, Model d) {
		if (memberService.checkId(userId)) {
			System.out.println("중복");
		} else {
			System.out.println("안중복");
		}
		d.addAttribute("userIdChk", memberService.checkId(userId));
		
		return "pageJsonReport";
	}
	
	// 유저 초대 창
	@GetMapping("insertUser")
	public String insertUser(Model d) {
		List<InviteMember> inviteList = memberService.inviteMemberList();
		List<Member> memberList = new ArrayList<Member>();
		
		for(InviteMember invite : inviteList) {
			memberList.add(memberService.getMember(invite.getInvited_member()));
		}
		
		d.addAttribute("list", inviteList);
		d.addAttribute("mem", memberList);
		
		return "user/insertUser";
	}
	
	@PostMapping("insertUser")
	public String mailSend(@RequestParam("receiver") String receiver, Model d, HttpSession session) {
		MailSender mailVo = new MailSender();
		Member sendMem = (Member)session.getAttribute("loginMem");
		mailVo.setReceiver(receiver);
		mailVo.setTitle("TryForge에 초대합니다.");
		
		mailVo.setContent(sendMem.getMember_name() + "님이 초대하셨습니다."
				+ "\n아래링크를 눌러 가입해주세요.\n\nhttp://211.63.89.67:1111/tryForge/register");
		d.addAttribute("msg", memberService.sendMail(mailVo, sendMem).equals("메일 발송 성공"));
		
		return "redirect:/insertUser";
		
	}

}