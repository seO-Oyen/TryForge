package com.web.spring.file.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DownloadController {
	@RequestMapping("download")
	public String download(@RequestParam("fname") String fname, @RequestParam("file_key") String file_key, Model d) {
		d.addAttribute("downloadFile", file_key);
		d.addAttribute("fname", fname);
		return "downloadViewer";
	}
}