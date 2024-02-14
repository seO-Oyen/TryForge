package com.web.spring.file.controller;

import com.web.spring.SessionService;
import com.web.spring.vo.Project;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.spring.file.service.FileService;
import com.web.spring.vo.FileStorage;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class FileController {
	@Autowired(required = false)
	private FileService service;
	@Autowired(required = false)
	private SessionService sessionService;

	@GetMapping("file")
	public String file() {
		return "/project/fileStorage";
	}

	@GetMapping("getFileList")
	public String getFileList(FileStorage file, Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			file.setProject_key(project.getProject_key());
			d.addAttribute("fList", service.fileList(file));
		}
		return "pageJsonReport";
	}

	@PostMapping("deleteFile")
	public String delFile(FileStorage file, Model d){
		d.addAttribute("result", service.delFile(file));
		return "pageJsonReport";
	}

	@PostMapping("modifyFile")
	public String modifyFile(FileStorage file, Model d){
		d.addAttribute("result", service.modifyFile(file));
		return "pageJsonReport";
	}

	@GetMapping("getFileDetail")
	public String getFileDetail(FileStorage file, Model d) {
		d.addAttribute("detail", service.getFileDetail(file));
		return "pageJsonReport";
	}
}