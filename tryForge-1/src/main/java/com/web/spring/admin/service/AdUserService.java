package com.web.spring.admin.service;

import com.web.spring.admin.dao.AdProjectDao;
import com.web.spring.admin.dao.AdUserDao;
import com.web.spring.vo.Team_Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdUserService {
    @Autowired(required = false)
    private AdUserDao dao;
    @Autowired(required = false)
    private AdProjectDao prodao;
    // 맴버키로 팀원 테이블 정보 가져오기
    public Team_Member tmFromMember(Team_Member tm){
        return dao.tmFromMember(tm);
    }
    // 팀원삭제
    public String delTm(int team_Member_key){
        return prodao.delTm(team_Member_key)>0?"팀원 삭제 성공":"팀원 삭제 에러";
    }
    // PL 변경
    public String assignPL(int team_Member_key){
        return dao.assignPL(team_Member_key)>0?"PL 변경 완료":"PL 변경 실패";
    }
    // 구성원 추가
    public String insNewTm(Team_Member ins){
        return dao.insNewTm(ins)>0?"구성원 추가 완료":"구성원 추가 에러";
    }
}
