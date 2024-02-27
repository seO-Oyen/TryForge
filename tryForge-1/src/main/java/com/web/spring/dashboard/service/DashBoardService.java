package com.web.spring.dashboard.service;

import java.util.List;

import com.web.spring.gantt.dao.GanttDao;
import com.web.spring.vo.Task;
import org.apache.ibatis.annotations.Param;
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
	@Autowired(required = false)
	private GanttDao ganttDao;
	
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

	public List<Task> getTaskMem(@Param("project_key") String project_key) {
		return ganttDao.getTaskMem(project_key);
	}

	public int countCompleteTask(@Param("project_key") String project_key) {
		return ganttDao.countCompleteTask(project_key);
	}
	public int countIncompleteTask(@Param("project_key") String project_key) {
		return ganttDao.countIncompleteTask(project_key);
	}
	public float projectProgress(@Param("project_key") String project_key) {
		return ganttDao.projectProgress(project_key);
	}

}
