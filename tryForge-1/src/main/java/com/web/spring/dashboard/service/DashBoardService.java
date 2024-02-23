package com.web.spring.dashboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.chat.dao.ChatDao;
import com.web.spring.member.dao.MemberDao;
import com.web.spring.vo.Member;
import com.web.spring.vo.Project;

@Service
public class DashBoardService {
	@Autowired(required = false) 
	private MemberDao memDao;
	@Autowired(required = false) 
	private ChatDao chatDao;
	
	public Project getProject(String project_key) {
		
		return memDao.getProject(project_key);
	}
	
	public List<Member> getProjectMember(String project_key) {
		
		return memDao.getProjectMember(project_key);
	}
	
	public int getChatListNum(String project_key) {
		if (chatDao.getChatListNum(project_key) == null) {
			return -1;
		} else {
			return chatDao.getChatListNum(project_key);
		}
	}

}
