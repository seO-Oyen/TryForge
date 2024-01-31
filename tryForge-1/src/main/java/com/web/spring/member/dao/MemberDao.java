package com.web.spring.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.InviteMember;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;


@Mapper
public interface MemberDao {

	// 로그인
	Member loginMember(Member member);
	
	// 회원가입
	int registerMember(Member member);
	
	// 아이디 중복체크 - 회원가입
	int checkId(String member_id);
	
	List<Project> getUserProject(int member_key);
	
	// 초대 내역 저장
	int inviteMember(Member member);
	
	// 초내 내역 출력
	List<InviteMember> getInviteMemberList();
	
	// 유저 key로 유저 찾기
	Member getMeber(int memberKey);
	
	// 비밀번호 확인
	int checkPwd(@Param("member_key") String memKey, @Param("pwd") String pwd);
	
	int changeUserInfo(@Param("name") String name, @Param("id") String id, 
			@Param("memKey") String memKey);
}