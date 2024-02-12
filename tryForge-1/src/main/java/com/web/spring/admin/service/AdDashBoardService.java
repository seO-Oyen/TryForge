package com.web.spring.admin.service;

import com.web.spring.admin.dao.AdDashBoardDao;
import com.web.spring.admin.dao.AdTaskDao;
import com.web.spring.vo.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;


@Service
public class AdDashBoardService {
    @Autowired(required = false)
    private AdDashBoardDao dao;
    @Autowired(required = false)
    private AdTaskDao taskDao;
    // 프로젝트 진척도
    public List<Task> projectProgress(){
        return dao.projectProgress();
    }
    // 가용인원 차트
    public int totMember(){
        return dao.totMember();
    }
    public int totTeamMember(){
        return dao.totTeamMember();
    }
    // 올해프로젝트 totOngoingPJ / totCompletePJ / totWaitingPJ
    public int totOngoingPJ(){
        return dao.totOngoingPJ();
    }
    public int totCompletePJ(){
        return dao.totCompletePJ();
    }
    public int totWaitingPJ(){
        return dao.totWaitingPJ();
    }
    public List<Task> taskProgressBypeople(String project_key){
        return dao.taskProgressBypeople(project_key);
    }
    // 리스크 차트
    public List<String> getTitle(){
        return taskDao.getTitle();
    }
    public int riskTot(String title){
        return dao.riskTot(title);
    }
    public int risk01Tot(String title){
        return dao.risk01Tot(title);
    }
    public int risk02Tot(String title){
        return dao.risk02Tot(title);
    }
}
