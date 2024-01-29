package com.web.spring.file.dao;

import org.apache.ibatis.annotations.Insert;

import com.web.spring.vo.FileStorage;


public interface UploadDao {
	// 파일업로드
	@Insert("INSERT INTO file_storage VALUES \r\n"
			+ "(file_storage_SEQ.nextVal, 'pj-001', #{fname}, #{path}, #{ftype}, #{fsize}, sysdate, 0)")
	int uploadFile(FileStorage upload);
}
