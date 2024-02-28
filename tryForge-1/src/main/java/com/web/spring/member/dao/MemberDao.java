package com.web.spring.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.InviteMember;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;
import com.web.spring.vo.RoleRequest;

@Mapper
public interface MemberDao {

	// 로그인
	Member loginMember(Member member);
	
	// 회원가입
	int registerMember(Member member);
	
	// 아이디 중복체크 - 회원가입
	int checkId(String member_id);
	
	// 이메일 체크
	InviteMember checkEmail(String member_email);
	
	Project getUserProject(int member_key);
	
	List<Project> getUserProjectList(int member_key);
	
	Project getProject(String project_key);
	
	List<Member> getProjectMember(String project_key);
	
	// 초대 내역 저장
	int inviteMember(Member member);
	
	// 초대 내역 출력
	List<InviteMember> getInviteMemberList();
	
	// 초대 내역 true로 변경
	int updateInviteMember(String email);
	
	// 유저 key로 유저 찾기
	Member getMeber(int memberKey);
	
	// 유저 id로 유저 찾기
	Member getMeberToId(String memberId);
	
	// 비밀번호 확인
	int checkPwd(@Param("member_key") String memKey, @Param("pwd") String pwd);
	
	int changeUserInfo(@Param("name") String name, @Param("id") String id, 
			@Param("memKey") String memKey);
	
	// 비번 수정
	int changePwd(@Param("memKey") String memKey, @Param("pwd") String pwd);
	
	// 권한 요청
	int requestRole(@Param("member_key")int memberKey, @Param("comment") String comment);
	
	// 권한요청 리스트
	List<RoleRequest> getRequestRoleList(@Param("member_key")int memberKey);
	
	RoleRequest getRequestRole(@Param("request_key")int request_key);
	
	Member getIdToEmail(@Param("member_email") String email);
}