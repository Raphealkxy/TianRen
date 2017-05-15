package com.dao;

import java.util.List;

import com.dao.base.GenericDaoImpl;
import com.pojo.Edition;

public class EditionDao extends GenericDaoImpl<Edition, Integer>{
	
	public Edition selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Edition> selectAll(){
		return super.selectAll();
	}
	
	public void insert(Edition edition){
		super.insert(edition);
	}
	
	public void delete(Edition edition){
		super.delete(edition);
	}
	
	public void update(Edition edition){
		super.update(edition);
	}
}
