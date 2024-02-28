package com.web.spring.file.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import com.web.spring.file.service.UploadService;
import com.web.spring.vo.FileStorage;

import jakarta.servlet.http.HttpSession;

import java.util.List;


@Controller
public class UploadController {
	@Autowired(required = false)
	private UploadService service;
	
	@PostMapping("upload")
	public String upload(FileStorage file, Model d) {
		List<String> keys = service.uploadFile(file);
		if(!keys.isEmpty()) {
			int cnt = keys.size();
			d.addAttribute("msg",  "파일 "+cnt+"건 등록 완료");
		}else {
			d.addAttribute("msg", "파일 등록 실패");
		}
		return "pageJsonReport";
	}
}
