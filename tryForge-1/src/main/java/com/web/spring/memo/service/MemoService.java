package com.web.spring.memo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.memo.dao.MemoDao;
import com.web.spring.vo.Memo;

@Service
public class MemoService {
	@Autowired(required = false)
	private MemoDao memoDao;
	
	
	public List<Memo> getMemoList(int member_key) {
		return memoDao.getMemoList(member_key);
	}

	public boolean createMemo(Memo memo) {
		
		if (memoDao.createMemo(memo) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean deleteMemo(int memoKey) {
		if (memoDao.deleteMemo(memoKey) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
}
