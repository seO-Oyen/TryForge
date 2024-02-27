package com.web.spring.dashboard.dao;

import com.web.spring.vo.Calendar;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DashBoardDao {
	int getCountCompleteTask(@Param("project_key") String project_Key);
	int getCountIncompleteTask(@Param("project_key") String project_key);
	float getProjectProgress(@Param("project_key") String project_key);
	int getProjectElapsedDate(@Param("project_key") String project_key);
	int getProjectDday(@Param("project_key") String project_key);
	String getProjectEndDate(@Param("project_key") String project_key);

	List<Calendar> getComingSchedule(@Param("project_key") String project_key);
}
