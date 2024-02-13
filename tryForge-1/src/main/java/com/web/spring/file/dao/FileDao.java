package com.web.spring.file.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.FileStorage;

@Mapper
public interface FileDao {
	List<FileStorage> getFileList(FileStorage file);

	String getFilePath(FileStorage file);

	int delFile(FileStorage file);

	FileStorage getFileDetail(FileStorage file);
}
