package com.web.spring.gantt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.Task;
import com.web.spring.vo.Task_Dependency;


@Mapper
public interface GanttDao {
	List<Task> getTask();

	Task taskDetail();
	List<Task_Dependency> getTaskDep();
}
