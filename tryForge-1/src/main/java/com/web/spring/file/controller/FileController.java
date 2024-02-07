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


@Controller
public class FileController {
	@Autowired(required = false)
	private FileService service;
	@Autowired(required = false)
	private SessionService sessionService;
	@GetMapping("file")
	public String FileList(FileStorage file, Model d, HttpSession session) {
		Project project = sessionService.getProject(session);
		if(project != null) {
			file.setProject_key(project.getProject_key());
			d.addAttribute("fList", service.FileList(file));
		}
		return "/project/fileStorage";
	}
}