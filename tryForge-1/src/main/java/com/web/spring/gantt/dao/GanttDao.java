package com.web.spring.gantt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.Task;
import com.web.spring.vo.Task_Dependency;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface GanttDao {
	List<Task> getTask(@Param("project_key") String project_key);

	Task taskDetail(@Param("id")int id);

	List<Task_Dependency> getTaskDep(@Param("project_key") String project_key);

	List<Task> getTaskMem(@Param("project_key") String project_key);

	Task getProjectPeriod(@Param("project_key") String project_key);

	int insertTask(Task ins);
	int insertTaskDep(Task_Dependency ins);
}
