package com.web.spring.admin.dao;
// com.web.spring.admin.dao.NoticeDao
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeSch;

@Mapper
// 공지사항 등록, 수정/삭제(로그인 섹션값), 조회/검색
public interface NoticeDao {
	// 공지사항 출력/검색
	List<Notice> noticeList(NoticeSch sch);
	
	// 총 데이터 건수
	public int totNotice(NoticeSch sch);
	
	// 상세페이지
	Notice getNotice(@Param("notice_Key") int notice_Key);
	
	// 조회수++
	@Update("update notice set notice_readcnt = notice_readcnt+1 where notice_key=#{notice_Key}")
	void readCntUptNotice(@Param("notice_Key") int notice_Key);
	
	// 공지사항 등록
	int insertNotice(Notice ins);
	
	// 공지사항 수정
	int updateNotice(Notice upt);
	
	// 공지사항 삭제
	@Delete("DELETE FROM notice WHERE notice_key = #{notice_Key}")
	int deleteNotice(@Param("notice_Key") int notice_Key);
}
