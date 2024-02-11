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
	@Select("SELECT COUNT(*) FROM task ta JOIN project p ON p.PROJECT_KEY = ta.PROJECT_KEY\n" +
			"WHERE p.CREATER = #{creater} AND ta.CONFIRM = 1")
	int unConfirmCnt(@Param("creater")int creater);
	@Select("SELECT COUNT(*) FROM task ta JOIN project p ON p.PROJECT_KEY = ta.PROJECT_KEY\n" +
			"WHERE p.CREATER = #{creater} AND ta.CONFIRM = 1")
	int confirmCnt(@Param("creater")int creater);
	@Select("SELECT COUNT(*) FROM task ta JOIN project p ON p.PROJECT_KEY = ta.PROJECT_KEY\n" +
			"WHERE p.CREATER = #{creater} AND ta.STATUS = '완료'")
	int completedTaskCnt(@Param("creater")int creater);

	// 자기가 만든 프로젝트에 한해서 리스크 보기
	List<Risk> adRiskList(@Param("creater")int creater);
	// 리스크 대응자 출력
	List<MemberSch> riskContactList(@Param("project_key")String project_key);
	// 리스크 대응방안 등록
	int insertRiskRes(Risk_Response ins);
	// 새로운 리스크 확인
	@Update("update risk set confirm = 1 where RISK_KEY = #{risk_key} ")
	int confirmNewRisk(@Param("risk_key")int risk_key);
	// 확인한 리스크 대응방안 상세보기
	@Select("SELECT * FROM RISK_RESPONSE WHERE risk_key = #{risk_key} ")
	Risk_Response getRiskResponse(@Param("risk_key")int risk_key);
	// 리스크 상태 처리중 업데이트
	@Update("update RISK_RESPONSE set status = '처리중' where RISK_RESPONSE_KEY= #{risk_response_key} ")
	int uptProcessing(@Param("risk_response_key")int risk_response_key);
	// 리스크 상태 처리완료 업데이트
	@Update("update RISK_RESPONSE set status = '처리완료' where RISK_RESPONSE_KEY= #{risk_response_key} ")
	int uptFin(@Param("risk_response_key")int risk_response_key);
	@Update("UPDATE RISK_RESPONSE SET COMPLETION_DATE= sysdate WHERE RISK_RESPONSE_KEY =#{risk_response_key} ")
	int uptCompletionDate(@Param("risk_response_key")int risk_response_key);
	int uptRiskResponse(Risk_Response upt);
	// 리스크 차트 4형제
	int riskNotConTot(@Param("creater")int creater); // 리스크 미확인
	int riskTot01(@Param("creater")int creater); // 발생전
	int riskTot02(@Param("creater")int creater); // 발생(처리중)
	int riskTot03(@Param("creater")int creater); // 처리완료

}
