package com.web.spring.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.admin.dao.NoticeDao;
import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeSch;


@Service
public class NoticeService {
	@Autowired(required = false)
	private NoticeDao dao;
	
	// 공지사항 조회, 페이징처리
	public List<Notice> noticeList(NoticeSch sch){
		if(sch.getNotice_Title()==null) {
			sch.setNotice_Title("");
		}
		if(sch.getNotice_Writer()==null) {
			sch.setNotice_Writer("");
		}
		
		sch.setCount(dao.totNotice(sch));
		if(sch.getPageSize()==0) sch.setPageSize(5);
		int totPage = (int)Math.ceil(sch.getCount()/(double)sch.getPageSize());
		sch.setPageCount(totPage);
		if(sch.getCurPage()==0) sch.setCurPage(1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		if(sch.getEnd()>sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setBlockSize(5);
		int blockNum = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
		sch.setEndBlock(blockNum*sch.getBlockSize());
		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
		if(sch.getEndBlock()>sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		return dao.noticeList(sch);
	}
	
	// 상세페이지 + 조회수 증가 service
	public Notice getNotice(int notice_Key) {
		dao.readCntUptNotice(notice_Key);
		return dao.getNotice(notice_Key);
	}
	
	// 공지사항 등록
	public String insertNotice(Notice ins) {
		if(ins.getNotice_Title()==null) ins.setNotice_Title("");
		if(ins.getNotice_Detail()==null) ins.setNotice_Detail("");
		
		String msg="";
		int chkInsert = dao.insertNotice(ins);
		if(chkInsert >0) {
			msg = "공지사항이 등록되었습니다.";
		}else {
			msg = "공지사항 등록이 실패하였습니다.\n 다시 시도해주세요.";
		}
		return msg;
	}
	
	// 공지사항 수정
	public int updateNotice(Notice upt) {
	    return dao.updateNotice(upt);
	}
	
	// 공지사항 삭제
	public String deleteNotice(int notice_Key) {
		int delNo = dao.deleteNotice(notice_Key);
		String msg="";
		if(delNo>0) {
			msg="공지사항이 삭제되었습니다.";
		}else {
			msg="공지사항 삭제가 실패하였습니다. \n 다시 시도해주세요.";
		}
		return msg;
	}
	
}
