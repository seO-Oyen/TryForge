package com.web.spring.risk.dao;
import java.util.List;

// com.web.spring.risk.dao.RiskDao
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.Risk;

@Mapper
public interface RiskDao {
	// 소속 프로젝트 등록 리스크 출력
	List<Risk> riskList(@Param("project_key")String project_key);
}
