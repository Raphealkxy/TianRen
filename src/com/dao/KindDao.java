package com.dao;

import java.util.List;

import com.dao.base.GenericDaoImpl;
import com.pojo.Kind;

public class KindDao extends GenericDaoImpl<Kind, Integer>{
	public Kind selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Kind> selectAll(){
		return super.selectAll();
	}
	
	public void insert(Kind kind){
		super.insert(kind);
	}
	
	public void delete(Kind kind){
		super.delete(kind);
	}
	
	public void update(Kind kind){
		super.update(kind);
	}
}
