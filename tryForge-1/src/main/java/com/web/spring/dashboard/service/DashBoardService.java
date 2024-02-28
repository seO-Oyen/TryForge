package com.web.spring.dashboard.service;

import java.util.List;

import com.web.spring.dashboard.dao.DashBoardDao;
import com.web.spring.gantt.dao.GanttDao;
import com.web.spring.vo.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.chat.dao.ChatDao;
import com.web.spring.member.dao.MemberDao;

@Service
public class DashBoardService {
	@Autowired(required = false) 
	private MemberDao memDao;
	@Autowired(required = false) 
	private ChatDao chatDao;
	@Autowired(required = false)
	private DashBoardDao dashBoardDao;
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

	public int getCountCompleteTask(@Param("project_key") String project_key) {
		return dashBoardDao.getCountCompleteTask(project_key);
	}
	public int getCountIncompleteTask(@Param("project_key") String project_key) {
		return dashBoardDao.getCountIncompleteTask(project_key);
	}
	public float getProjectProgress(@Param("project_key") String project_key) {
		return dashBoardDao.getProjectProgress(project_key);
	}
	public int getProjectElapsedDate(@Param("project_key") String project_key) {
		return dashBoardDao.getProjectElapsedDate(project_key);
	}
	public int getProjectDday(@Param("project_key") String project_key) {
		return dashBoardDao.getProjectDday(project_key);
	}
	public String getProjectEndDate(@Param("project_key") String project_key) {
		return dashBoardDao.getProjectEndDate(project_key);
	}

	public List<Calendar> getComingSchedule(@Param("project_key") String project_key) {
		return dashBoardDao.getComingSchedule(project_key);
	}

	public List<DashBoard> getProjectStatusChart(@Param("project_key") String project_key) {
		return dashBoardDao.getProjectStatusChart(project_key);
	}

	public int getProjectElapsed(@Param("project_key") String project_key) {
		return dashBoardDao.getProjectElapsed(project_key);
	}
}
