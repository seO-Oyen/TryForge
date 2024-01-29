package com.web.spring.file.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.FileStorage;


public interface FileDao {
	@Select("SELECT * FROM FILE_STORAGE WHERE PROJECT_KEY= 'pj-001' ORDER BY UPLOAD_TIME DESC")
	List<FileStorage> getFileList(FileStorage file);
	//#{project_key}
}
