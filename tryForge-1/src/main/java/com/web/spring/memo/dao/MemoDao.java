package com.web.spring.memo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.spring.vo.Memo;

@Mapper
public interface MemoDao {
	
	List<Memo> getMemoList(int member_key);

	int createMemo(Memo memo);
}
