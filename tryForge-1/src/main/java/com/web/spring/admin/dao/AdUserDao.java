package com.web.spring.admin.dao;
 import java.util.List;

// com.web.spring.admin.dao.AdUserDao
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.Team_Member;

@Mapper
public interface AdUserDao {
	List<Team_Member> tmFromMember(int member_key);
	// PL 변경
	int assignPL(@Param("team_Member_key")int team_Member_key);
	// 새 구성원 추가
	int insNewTm(Team_Member ins);
}
