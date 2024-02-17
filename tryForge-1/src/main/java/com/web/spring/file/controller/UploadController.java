package com.web.spring.file.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import com.web.spring.file.service.UploadService;
import com.web.spring.vo.FileStorage;


@Controller
public class UploadController {
	@Autowired(required = false)
	private UploadService service;
	
	@PostMapping("upload")
	public String upload(FileStorage file, Model d) {
		d.addAttribute("msg", service.uploadFile(file));
		return "pageJsonReport";
	}
}
