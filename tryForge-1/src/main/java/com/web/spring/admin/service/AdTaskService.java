package com.web.spring.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.admin.dao.AdTaskDao;
import com.web.spring.gantt.dao.GanttDao;
import com.web.spring.vo.MemberSch;
import com.web.spring.vo.Task;

@Service
public class AdTaskService {
    @Autowired(required = false)
    private AdTaskDao dao;
    @Autowired(required = false)
    private GanttDao ganttDao;

    // 구성원 검색(for 업무할당)
    public List<MemberSch> schTaskMem(MemberSch sch) {
        if (sch.getTitle() == null) sch.setTitle("");
        if (sch.getMember_name() == null) sch.setMember_name("");
        return dao.schTaskMem(sch);
    }

    // 프로젝트 별로 select 로 구분
    public List<String> getTitle() {
        return dao.getTitle();
    }

    // 업무등록
    public String insertTask(Task ins) {
        return dao.insertTask(ins) > 0 ? "업무배정완료" : "업무배정실패";
    }

    // 맴버키에 맞는 업무리스트 출력
    public List<Task> taskList(int member_key) {
        return dao.taskList(member_key);
    }

    // 업무키의 제목, 상세설명 변경
    public String uptTask(Task upt) {
        return dao.uptTask(upt) > 0 ? "수정 완료" : "수정 실패";
    }
    // 해당 업무키 삭제
    public String delTask(int id) {
        return dao.delTask(id) > 0 ? "삭제 성공" : "삭제 실패";
    }
    // 총, 완료, 확인, 미확인 차트용 갯수출력
    public int unConfirm(){
        System.out.println(dao.unConfirmCnt());
        return dao.unConfirmCnt();}
    public int confirm(){
        System.out.println(dao.confirmCnt());
        return dao.confirmCnt();
    }
    public int completedTaskCnt(){
        System.out.println(dao.completedTaskCnt());
        return dao.completedTaskCnt();
    }
    public int allTaskCnt(){return dao.allTaskCnt();}

}
