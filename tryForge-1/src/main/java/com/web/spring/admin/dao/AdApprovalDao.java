package com.web.spring.admin.dao;

import com.web.spring.vo.Project;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AdApprovalDao {
    @Select("SELECT * FROM PROJECT WHERE CREATER = #{creater} ")
    List<Project> projectByCreater(@Param("creater")int creater);
}
