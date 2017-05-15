package com.dao;

import java.util.List;

import com.dao.base.GenericDaoImpl;
import com.pojo.Language;

public class LanguageDao extends GenericDaoImpl<Language, Integer>{
	
	public Language selectById(Integer id){
		return super.selectById(id);
	}
	
	public List<Language> selectAll(){
		return super.selectAll();
	}
	
	public void insert(Language language){
		super.insert(language);
	}
	
	public void delete(Language language){
		super.delete(language);
	}
	
	public void update(Language language){
		super.update(language);
	}
}
