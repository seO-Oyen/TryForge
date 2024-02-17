package com.web.spring.admin.service;

import com.web.spring.admin.dao.AOPDao;
import com.web.spring.vo.AOP_Error;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AOPService {
    @Autowired(required = false)
    AOPDao dao;

    public List<AOP_Error> errorList(){
        return dao.errorList();
    }
    public String ConfirmError(int error_key){
        return dao.ConfirmError(error_key)>0?"에러 확인 완료":"에러 확인 실패";
    }
}
