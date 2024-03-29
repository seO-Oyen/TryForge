package com.web.spring.task.service;

import com.web.spring.file.service.UploadService;
import com.web.spring.task.dao.TaskReportDao;
import com.web.spring.vo.Approval;
import com.web.spring.vo.FileStorage;
import com.web.spring.vo.FileUse;
import com.web.spring.vo.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

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
    public List<Approval> getRejectApprovalList(Approval approval) {
        return dao.getRejectApprovalList(approval);
    }
    public List<FileStorage> getRejectApprovalFileList(Approval approval) {
        return dao.getRejectApprovalFileList(approval);
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

    public int reportTaskAgain(Approval approval) {
        return dao.reportTaskAgain(approval);
    }

    public int reportTaskAgainFileUse(List<String> fileKeys, Approval approval) {
        int cnt = 0;
        for(String fileKey : fileKeys) {
            FileUse file = new FileUse();
            file.setFile_key(fileKey);
            file.setApproval_key(approval.getApproval_key());
            cnt += dao.reportTaskAgainFileUse(file);
        }
        return cnt;
    }
}