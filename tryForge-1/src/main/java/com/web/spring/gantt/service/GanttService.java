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
	
	public List<Task> getTask(){
		return dao.getTask();
	}
	
	public List<Task_Dependency> getTaskDep(){
		return dao.getTaskDep();
	}
	
	
}
