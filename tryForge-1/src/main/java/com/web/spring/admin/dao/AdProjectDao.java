package com.web.spring.admin.dao;
// tryForge.admin.dao.AdProjectDao
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.Member;
import com.web.spring.vo.Project;
import com.web.spring.vo.Team;
import com.web.spring.vo.Team_Member;

@Mapper
public interface AdProjectDao {
	List<Project> projList();
	List<Member> PJMemList(String project_key);
	List<Member> schMem(@Param("member_name")String member_name);
	List<Member> exceptSchMem(@Param("member_name")String member_name);
	int insertPJ(Project insProject);
	int insPJtoTask(Project insProject);
	int insertTeam(Team insTeam);
	int insertTm(int member_key);
	int uptCnt();
	Project projectInfo(String project_key);
	Team teamInfo(String project_key);
	List<Team_Member> tmInfo(int team_key);
	Member memberInfo(int member_key);
	int delProject(String project_key);
	int delTeam(String project_key);
	int delTm(int member_key);
	int uptFin(String project_key);
	int uptProject(Project uptPro);
	int uptTeam(Team uptTeam);
	int insBookProject(Project ins);
	int convertTeam(Team ins);
	int convertTm(int member_key);
	int insPJtoTask02(Project insProject);
	int convertProject(Project upt);
}
