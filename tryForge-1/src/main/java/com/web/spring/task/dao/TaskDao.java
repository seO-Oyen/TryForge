package com.web.spring.task.dao;
// com.web.spring.task.dao.TaskDao
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.Task;

@Mapper
public interface TaskDao {
	List<Task> getTask();
}
