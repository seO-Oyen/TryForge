package com.web.spring.file.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.FileStorage;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UploadDao {
	// 파일업로드
	@Insert("INSERT INTO file_storage VALUES \r\n"
			+ "('FILE-'||file_storage_SEQ.nextVal, #{project_key}, #{fname}, #{path}, #{ftype}, #{fsize}, sysdate, #{member_key})")
	int uploadFile(FileStorage upload);

	@Select("SELECT FILE_KEY from FILE_STORAGE " +
			"WHERE FILE_KEY = 'FILE-'||file_storage_SEQ.currval")
	String getFileKey();
}
