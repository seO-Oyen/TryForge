package com.web.spring.task.dao;

import com.web.spring.vo.Task;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TaskReportDao {
    List<Task> getMemberTaskList(Task task);
    Task getMemberTask(Task task);
}
