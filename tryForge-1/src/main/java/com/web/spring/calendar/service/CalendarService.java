package com.web.spring.calendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.calendar.dao.CalendarDao;
import com.web.spring.vo.Calendar;



@Service
public class CalendarService {
	@Autowired(required = false)
	private CalendarDao dao;
	
	public List<Calendar> getCalendar(){
		return dao.getCalendar();
	}
	
	public String insertCalendar(Calendar ins) {
		return dao.insertCalendar(ins)>0?"등록성공":"등록실패";
	}
	
	public String updateCalendar(Calendar upt) {
		return dao.updateCalendar(upt)>0?"업데이트 성공":"업데이트 실패";
	}
	
	public String deleteCalendar(int calendar_key) {
		return dao.deleteCalendar(calendar_key)>0?"삭제 성공":"삭제 실패";
	}
}
