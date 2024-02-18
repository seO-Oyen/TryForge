package com.web.spring.admin.service;

import com.web.spring.admin.dao.AdApprovalDao;
import com.web.spring.vo.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdApprovalService {
    @Autowired(required = false)
    private AdApprovalDao dao;

    public List<Project> projectByCreater(int creater){
        return dao.projectByCreater(creater);
    }

}
