package com.web.spring.gantt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.gantt.dao.GanttDao;
import com.web.spring.vo.Task;
import com.web.spring.vo.Task_Dependency;


@Service
public class GanttService {
	@Autowired(required = false)
	private GanttDao dao;
	
	public List<Task> getTask(String project_key){
		return dao.getTask(project_key);
	}
	
	public List<Task_Dependency> getTaskDep(String project_key){
		return dao.getTaskDep(project_key);
	}

	public List<Task> getTaskMem(String project_key) {
		return dao.getTaskMem(project_key);
	}

	public Task getProjectPeriod(String project_key) {
		return dao.getProjectPeriod(project_key);
	}
	public int insertTask(Task ins) {
		return dao.insertTask(ins);
	}
	public String insertTaskDep(Task_Dependency ins) {
		return dao.insertTaskDep(ins)>0?"등록성공":"등록실패";
	}

	public int updateTask(Task upt) {
		if(upt.getMember_key()==-10) {
			return dao.updateProject(upt);
		}else if(upt.getMember_key()==-1){
			return dao.updateTaskDragDrop(upt);
		}else {
			return dao.updateTaskLightbox(upt);
		}
	}
	public int deleteTask(Task del) {
		return dao.deleteTask(del);
	}
}
