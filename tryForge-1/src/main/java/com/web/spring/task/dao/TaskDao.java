package com.web.spring.task.dao;
// com.web.spring.task.dao.TaskDao
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.Task;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface TaskDao {
	List<Task> getTask();

	@Update("UPDATE task SET confirm = 1 WHERE task_key = #{id}")
	int uptConfirm(@Param("id")int id);
}
