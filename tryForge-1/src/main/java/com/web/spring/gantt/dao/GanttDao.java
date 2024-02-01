package com.web.spring.gantt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.Task;
import com.web.spring.vo.Task_Dependency;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface GanttDao {
	List<Task> getTask();

	Task taskDetail(@Param("id")int id);
	List<Task_Dependency> getTaskDep();
}
