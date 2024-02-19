package com.web.spring.task.controller;

import com.web.spring.SessionService;
import com.web.spring.file.service.UploadService;
import com.web.spring.task.service.TaskReportService;
import com.web.spring.vo.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
public class TaskReportController {
    @Autowired(required = false)
    private TaskReportService service;
    @Autowired(required = false)
    private SessionService sessionService;
    @Autowired(required = false)
    private UploadService uploadService;

    @GetMapping("taskReport")
    public String taskReport(){
        return "project/taskReport";
    }

    @GetMapping("getMemberTaskList")
    public String getMemberTaskList(Model d, Task task , HttpSession session) {
        Member member = sessionService.getMember(session);
        if(member != null) {
            task.setMember_key(member.getMember_key());
            d.addAttribute("taskList", service.getMemberTaskList(task));
        }
        return "pageJsonReport";
    }
    @GetMapping("getMemberTask")
    public String getMemberTask(Task task, Model d){
        d.addAttribute("task", service.getMemberTask(task));
        return "pageJsonReport";
    }

    @PostMapping("reportTask")
    public String reportTask(Approval approval, FileStorage file, Model d){
        MultipartFile[] files = file.getFiles();
        // 파일 있을 때
        if(files != null && files.length > 0) {
            List<String> fileKeys = uploadService.uploadFile(file);
            if(service.reportTask(approval)>0) {
                int cnt = service.reportTaskFileUse(fileKeys);
                d.addAttribute("result", cnt>0?"업무보고 성공(첨부파일 "+cnt+"개 포함)":"업무보고 실패");
            }
        } else { // 파일 없을 때
            d.addAttribute("result", service.reportTask(approval)>0?"업무보고 성공(첨부파일 없음)":"업무보고 실패");
        }
        return "pageJsonReport";
    }

    @GetMapping("getRejectApprovalList")
    public String getRejectApprovalList(Approval approval, Model d, HttpSession session) {
        Member member = sessionService.getMember(session);
        if(member != null) {
            approval.setMember_key(member.getMember_key());
            d.addAttribute("rejectList", service.getRejectApprovalList(approval));
        }
        return "pageJsonReport";
    }

    @GetMapping("getRejectApprovalFileList")
    public String getRejectApprovalFileList(Approval approval, Model d, HttpSession session) {
        Member member = sessionService.getMember(session);
        if(member != null) {
            approval.setMember_key(member.getMember_key());
            d.addAttribute("rejectFileList", service.getRejectApprovalFileList(approval));
        }
        return "pageJsonReport";
    }
}