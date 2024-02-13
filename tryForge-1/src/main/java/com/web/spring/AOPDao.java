package com.web.spring;
// com.web.spring.AOPDao
import com.web.spring.vo.AOP_Error;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AOPDao {
    //  일반에러
    @Insert("INSERT INTO AOP_error values (sysdate, #{error_type}, #{error_detail}, #{error_path}, '일반에러' , 0) ")
    int insNormalError(AOP_Error ins);
    // 심각에러
    @Insert("INSERT INTO AOP_error values (sysdate, #{error_type}, #{error_detail}, #{error_path}, '심각에러' , 0) ")
    int insCriticalError(AOP_Error ins);
    // 에러 확인
    // 에러 출력
}
