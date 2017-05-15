package com.service;

import java.util.List;

import com.dao.EditionDao;
import com.pojo.Edition;

public class EditionService {
	private EditionDao editionDao;

	public void setEditionDao(EditionDao editionDao) {
		this.editionDao = editionDao;
	}
	
	public List<Edition> findAll(){
		return editionDao.selectAll();
	}
	
	public void create(Edition edition){
		editionDao.insert(edition);
	}
}
