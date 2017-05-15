package com.service;

import java.util.List;

import com.dao.LanguageDao;
import com.pojo.Language;

public class LanguageService {
	private LanguageDao languageDao;

	public void setLanguageDao(LanguageDao languageDao) {
		this.languageDao = languageDao;
	}
	
	public List<Language> findAll(){
		return languageDao.selectAll();
	}
	
	public void create(Language language){
		languageDao.insert(language);
		
	}
}
