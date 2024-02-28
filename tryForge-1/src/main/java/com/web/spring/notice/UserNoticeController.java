package com.web.spring.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.vo.NoticeSch;

@Controller
public class UserNoticeController {
	@Autowired(required = false)
	private UserNoticeService service;
	
	// 공지사항 관리페이지 검색, 조회기능
		@RequestMapping("notice")
		public String notice(NoticeSch sch, Model d) {
			d.addAttribute("noticeList", service.noticeList01(sch));
			return "user\\notice";
		}
		
		
		// 공지사항 상세페이지
		@RequestMapping("noticeDetail")
		public String noticeDetail(@RequestParam("notice_Key")int notice_Key, Model d) {
			d.addAttribute("notice",service.getNotice01(notice_Key));
			return "user\\getNotice";
		}
}
