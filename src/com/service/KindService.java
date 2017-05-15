package com.service;

import java.util.List;

import com.dao.KindDao;
import com.pojo.Kind;

public class KindService {
	private KindDao kindDao;

	public void setKindDao(KindDao kindDao) {
		this.kindDao = kindDao;
	}

	public List<Kind> findAll(){
		return kindDao.selectAll();
	}
	
	public void create(Kind kind){
		kindDao.insert(kind);
	}
}
