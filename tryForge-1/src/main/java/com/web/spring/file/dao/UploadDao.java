package com.web.spring.file.dao;

import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.FileStorage;

@Mapper
public interface UploadDao {
	// 파일업로드
	int uploadFile(FileStorage upload);

	int getFileSeq();
}
