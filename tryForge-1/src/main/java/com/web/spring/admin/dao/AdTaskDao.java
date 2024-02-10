package com.web.spring.admin.dao;

import java.util.List;

import com.web.spring.vo.Risk;
import com.web.spring.vo.Risk_Response;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.MemberSch;
import com.web.spring.vo.Task;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface AdTaskDao {
	List<MemberSch> schTaskMem(MemberSch sch);
	@Select("select DISTINCT title from project order by title")
	List<String> getTitle();
	int insertTask(Task ins);
	List<Task> taskList(@Param("member_key")int member_key);
	int uptTask(Task upt);
	int delTask(@Param("id")int id);
	// 차트용 갯수 구하기 dao 4형제
	@Select("select count(*) from task where CONFIRM=0")
	int unConfirmCnt();
	@Select("select count(*) from task where CONFIRM=1")
	int confirmCnt();
	@Select("SELECT count(*) FROM task WHERE STATUS='완료'")
	int completedTaskCnt();
	@Select("SELECT count(*) FROM task")
	int allTaskCnt();
	// 자기가 만든 프로젝트에 한해서 리스크 보기
	List<Risk> adRiskList(@Param("creater")int creater);
	// 리스크 대응자 출력
	List<MemberSch> riskContactList(@Param("project_key")String project_key);
	// 리스크 대응방안 등록
	int insertRiskRes(Risk_Response ins);
	// 새로운 리스크 확인
	@Update("update risk set confirm = 1 where RISK_KEY = #{risk_key} ")
	int confirmNewRisk(@Param("risk_key")int risk_key);

}
