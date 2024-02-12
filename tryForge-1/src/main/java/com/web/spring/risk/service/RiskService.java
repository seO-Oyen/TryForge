package com.web.spring.risk.service;

import com.web.spring.risk.dao.RiskDao;
import com.web.spring.vo.Risk;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RiskService {
    @Autowired(required = false)
    private RiskDao dao;
    // 소속 프로젝트 등록 리스크 출력
    public List<Risk> riskList(String project_key){
        return dao.riskList(project_key);
    }
}
