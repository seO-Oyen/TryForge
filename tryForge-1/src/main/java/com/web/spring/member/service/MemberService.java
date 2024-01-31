package com.web.spring.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.member.dao.MemberDao;
import com.web.spring.vo.InviteMember;
import com.web.spring.vo.MailSender;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;


@Service
public class MemberService {

	@Autowired(required = false)
	private MemberDao memberDao;
	//@Autowired(required = false)
	//private JavaMailSender sender;

	// 로그인
	public Member loginMember(Member member) {
		return memberDao.loginMember(member);
	}
	
	// 회원가입
	public boolean registerMember(Member member) {
		int result = memberDao.registerMember(member);
		
		if (result > 0) {
			return true;
		} else {
			return false;
		}
		
	}
	
	// 아이디 중복 체크
	public boolean checkId(String id) {
		if (id != null && memberDao.checkId(id) > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	// 본인이 소속되어있는 프로젝트 출력
	public Project getUserProject(Member member) {
		
		return memberDao.getUserProject(member.getMember_key());
	}
	
	// 초대 목록 
	public List<InviteMember> inviteMemberList() {
		
		return memberDao.getInviteMemberList();
	}
	
	// 유저key로 유저 찾기
	public Member getMember(int memberKey) {
		return memberDao.getMeber(memberKey);
	}
	
	// 메일 발송
	/*
	public String sendMail(MailSender email, Member sendMem) {
		String msg = "";
		
		MimeMessage mmsg = sender.createMimeMessage();
		
		try {
			mmsg.setSubject(email.getTitle());
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(email.getReceiver()));
			mmsg.setText(email.getContent());

			memberDao.inviteMember(new Member(sendMem.getMember_key(), email.getReceiver()));
			sender.send(mmsg);
			msg = "메일 발송 성공";
		} catch (MessagingException e) {
			System.out.println("메시지 전송에러 발송 : " + e.getMessage());
			msg = "메일 발송 에러 발생 : " + e.getMessage();
		} catch (Exception e) {
			System.out.println("기타 에러 : " + e.getMessage());
			msg = "기타 에러 발생 : " + e.getMessage();
		}
		
		return msg;
	}
	 * */
}