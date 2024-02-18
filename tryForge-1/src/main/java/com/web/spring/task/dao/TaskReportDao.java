package com.web.spring.task.dao;

import com.web.spring.vo.Approval;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.Task;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Mapper
public interface TaskReportDao {
    List<Task> getMemberTaskList(Task task);
    Task getMemberTask(Task task);

    int reportTask(Approval approval);
    int reportTaskFileUse(FileStorage file);
}
