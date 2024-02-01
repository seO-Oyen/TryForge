package com.web.spring.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.MemberSch;
import com.web.spring.vo.Task;

@Mapper
public interface AdTaskDao {
	List<MemberSch> schTaskMem(MemberSch sch);
	@Select("select DISTINCT title from project order by title")
	List<String> getTitle();
	int insertTask(Task ins);
	List<Task> taskList(@Param("member_key")int member_key);
	int uptTask(Task upt);
	int delTask(@Param("id")int id);
	@Select("select count(*) from task where CONFIRM=0")
	int unConfirm();
	@Select("select count(*) from task where CONFIRM=1")
	int Confirm();
}
