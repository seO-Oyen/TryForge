package com.web.spring.file.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.FileStorage;

@Mapper
public interface FileDao {
	@Select("SELECT * FROM FILE_STORAGE WHERE PROJECT_KEY= #{project_key} " +
			"ORDER BY UPLOAD_TIME DESC")
	List<FileStorage> getFileList(FileStorage file);

	@Select("SELECT PATH FROM FILE_STORAGE WHERE FILE_KEY = #{file_key}")
	String getFilePath(FileStorage file);

	@Delete("DELETE FROM FILE_STORAGE WHERE FILE_KEY = #{file_key}")
	int delFile(FileStorage file);
}
