// com.web.spring.AOPDao
package com.web.spring.admin.dao;


import java.util.List;

import org.apache.ibatis.annotations.*;

import com.web.spring.vo.AOP_Error;

@Mapper
public interface AOPDao {
    //  일반에러
    @Insert("INSERT INTO AOP_error values (err_seq.nextval ,sysdate, #{error_type}, #{error_detail}, #{error_path}, '일반에러' , 0) ")
    int insNormalError(AOP_Error ins);
    // 심각에러
    @Insert("INSERT INTO AOP_error values (err_seq.nextval, sysdate, #{error_type}, #{error_detail}, #{error_path}, '심각에러' , 0) ")
    int insCriticalError(AOP_Error ins);
    // 에러 확인
    @Update("update AOP_error set error_confirm = 1 where error_key = #{error_key}")
    int ConfirmError(@Param("error_key")int error_key);
    // 에러 출력
    @Select("select * from AOP_Error")
    List<AOP_Error> errorList();
}
