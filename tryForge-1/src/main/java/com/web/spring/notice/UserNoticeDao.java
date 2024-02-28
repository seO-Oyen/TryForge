package com.web.spring.notice;
// com.web.spring.notice.UserNoticeDao
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeSch;

@Mapper
public interface UserNoticeDao {
	List<Notice> noticeList01(NoticeSch sch);
	
	// 총 데이터 건수
	public int totNotice01(NoticeSch sch);
	
	// 상세페이지
	Notice getNotice01(@Param("notice_Key") int notice_Key);
	
	// 조회수++
	@Update("update notice set notice_readcnt = notice_readcnt+1 where notice_key=#{notice_Key}")
	void readCntUptNotice01(@Param("notice_Key") int notice_Key);
	
}
