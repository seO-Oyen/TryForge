package com.web.spring.task.service;

import com.web.spring.task.dao.TaskReportDao;
import com.web.spring.vo.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskReportService {
    @Autowired(required = false)
    private TaskReportDao dao;

    public List<Task> getMemberTaskList(Task task) {
        return dao.getMemberTaskList(task);
    }
    public Task getMemberTask(Task task) {
        return dao.getMemberTask(task);
    }
}
