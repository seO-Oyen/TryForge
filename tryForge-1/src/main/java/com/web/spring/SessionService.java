package com.web.spring;

import org.springframework.stereotype.Service;

import com.web.spring.vo.Member;
import com.web.spring.vo.Project;

import jakarta.servlet.http.HttpSession;

@Service
public class SessionService {
    public Project getProject(HttpSession session) {
        if(session.getAttribute("loginMem") != null && session.getAttribute("projectMem") != null) {
            return (Project)session.getAttribute("projectMem");
        }
        return null;
    }

    public Member getMember(HttpSession session) {
    	if(session.getAttribute("loginMem") != null) {
    		return (Member)session.getAttribute("loginMem");
    	}
    	return null;
    }
}
