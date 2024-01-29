package com.web.spring.file.controller;

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
	
	@GetMapping("file.do")
	public String upload(FileStorage file, Model d) {
		d.addAttribute("fList", service.FileList(file));
		return "/project/fileStorage";
	}
}
