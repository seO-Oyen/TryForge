package com.web.spring.file.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.FileStorage;

@Mapper
public interface UploadDao {
	// 파일업로드
	@Insert("INSERT INTO file_storage VALUES \r\n"
			+ "(file_storage_SEQ.nextVal, #{project_key}, #{fname}, #{path}, #{ftype}, #{fsize}, sysdate, #{member_key}, #{originfname})")
	int uploadFile(FileStorage upload);
}
