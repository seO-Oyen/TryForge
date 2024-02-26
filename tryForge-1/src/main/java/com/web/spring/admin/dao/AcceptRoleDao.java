package com.web.spring.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.spring.vo.RoleRequest;

@Mapper
public interface AcceptRoleDao {
	List<RoleRequest> getRoleRequestList();
	
	int updateRequest(@Param("state") String state, @Param("comment") String comment,
			@Param("requestKey") int requestKey);
	
	int updateRole(@Param("memberKey") int memberKey);
}
