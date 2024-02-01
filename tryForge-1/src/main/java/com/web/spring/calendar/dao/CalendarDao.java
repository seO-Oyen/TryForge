package com.web.spring.calendar.dao;

import java.util.List;

import com.web.spring.vo.Project;
import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.Calendar;

@Mapper
public interface CalendarDao {
	List<Calendar> getCalendar(Project project); // 조회
	
	int insertCalendar(Calendar ins); // 추가
	
	int updateCalendar(Calendar upt); // 수정
	
	int deleteCalendar(int calendar_key); // 삭제
}
