package com.web.spring.task.service;

import com.web.spring.file.dao.FileDao;
import com.web.spring.file.service.UploadService;
import com.web.spring.task.dao.TaskReportDao;
import com.web.spring.vo.Approval;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service
public class TaskReportService {
    @Autowired(required = false)
    private TaskReportDao dao;
    @Autowired(required = false)
    private UploadService uploadService;

    @Value("${file.upload}")
    private String path;

    public List<Task> getMemberTaskList(Task task) {
        return dao.getMemberTaskList(task);
    }
    public Task getMemberTask(Task task) {
        return dao.getMemberTask(task);
    }

    public int reportTask(Approval approval) {
        return dao.reportTask(approval);
    }

    public int reportTaskFileUse(List<String> fileKeys) {
        int cnt = 0;
        for(String fileKey : fileKeys) {
            FileStorage file = new FileStorage();
            file.setFile_key(fileKey);
            cnt += dao.reportTaskFileUse(file);
        }
        return cnt;
    }

}