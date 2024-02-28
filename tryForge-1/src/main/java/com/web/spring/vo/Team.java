package com.web.spring.vo;    

import org.springframework.beans.factory.annotation.Autowired;

public class Team {
	private int team_key;
	private String team_name;
	private int project_cnt;
	private String project_key;
	private Project project;
	public Team() {
		// TODO Auto-generated constructor stub
	}
	public Team(int team_key, String team_name, int project_cnt) {
		this.team_key = team_key;
		this.team_name = team_name;
		this.project_cnt = project_cnt;
	}
	
	public int getTeam_key() {
		return team_key;
	}
	public void setTeam_key(int team_key) {
		this.team_key = team_key;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public int getProject_cnt() {
		return project_cnt;
	}
	public void setProject_cnt(int project_cnt) {
		this.project_cnt = project_cnt;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public String getProject_key() {
		return project_key;
	}
	public void setProject_key(String project_key) {
		this.project_key = project_key;
	}
	
}
